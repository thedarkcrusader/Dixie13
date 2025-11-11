/client/var/datum/native_say/native_say

/client/New()
	. = ..()
	native_say = new /datum/native_say(src)

/datum/native_say
	var/client/client
	var/list/hurt_phrases = list("GACK!", "GLORF!", "OOF!", "AUGH!", "OW!", "URGH!", "HRNK!")
	var/max_length = MAX_MESSAGE_LEN
	var/window_open = FALSE

	// Window sizing
	var/window_width = 231
	var/window_height = 30
	var/list/window_sizes = list("small" = 30, "medium" = 50, "large" = 70)
	var/list/line_lengths = list("small" = 20, "medium" = 39, "large" = 59)

	// Channel definitions - will be populated dynamically
	var/list/datum/say_channel/available_channels = list()
	var/list/channel_names = list()
	var/datum/say_channel/current_channel
	var/current_channel_index = 0

	// Chat history
	var/list/chat_history = list()
	var/history_index = 0
	var/temp_message = ""

/datum/native_say/New(client/C)
	src.client = C
	fetch_channels()
	initialize()

/datum/native_say/proc/fetch_channels()
	available_channels = list()
	channel_names = list()

	for(var/channel_type in subtypesof(/datum/say_channel))
		var/datum/say_channel/channel = new channel_type()

		if(channel.can_show(client))
			available_channels += channel
			channel_names += channel.name

	if(available_channels.len > 0)
		current_channel = available_channels[1]
		current_channel_index = 1

/datum/native_say/proc/initialize()
	set waitfor = FALSE
	reload_ui()

/datum/native_say/proc/reload_ui()
	client << browse(get_html(), "window=native_say;size=[window_width]x[window_height];pos=848,500;can_close=0;can_minimize=0;can_resize=0;titlebar=0")
	winset(client, "native_say", "is-visible=0")

/datum/native_say/proc/resize_window(size_name)
	if(!window_sizes[size_name])
		return

	window_height = window_sizes[size_name]
	winset(client, "native_say", "size=[window_width]x[window_height]")
	winset(client, "native_say.browser", "size=[window_width]x[window_height]")

/datum/native_say/proc/get_channel_styles()
	var/styles = ""
	for(var/datum/say_channel/channel in available_channels)
		var/channel_name = channel.name
		styles += {"
		.window-[channel_name] { background-color: [channel.color]; }
		.button-[channel_name] { border: 1px solid [channel.get_border_color()]; color: [channel.color]; }
		.button-[channel_name]:hover { border-color: [channel.get_hover_border()]; color: [channel.get_hover_color()]; }
		.editor-[channel_name] { color: [channel.color]; }
		.shine-[channel_name] {
			background: [channel.get_shine_gradient()];
		}
"}
	return styles

/datum/native_say/proc/get_html()
	var/list/js_channels = list()
	var/list/js_quiet = list()

	for(var/datum/say_channel/channel in available_channels)
		js_channels += "\"[channel.name]\""
		if(channel.quiet)
			js_quiet += "\"[channel.name]\""

	var/channels_json = "\[[jointext(js_channels, ", ")]\]"
	var/quiet_json = "\[[jointext(js_quiet, ", ")]\]"
	var/default_channel = current_channel?.name || "Say"

	return {"<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<style>
		* {
			margin: 0;
			padding: 0;
			box-sizing: border-box;
		}

		body {
			font-family: 'Verdana', sans-serif;
			overflow: hidden;
			background: transparent;
			height: 100vh;
			display: flex;
			flex-direction: column;
		}

		.window {
			position: absolute;
			inset: 0;
			background-color: #000;
			overflow: hidden;
			z-index: 0;
		}

		.shine {
			position: absolute;
			inset: 0;
			background-size: 150% 150%;
			animation: shine 15s linear infinite;
			z-index: 1;
			pointer-events: none;
		}

		@keyframes shine {
			0% { transform: rotate(0deg); }
			50% { transform: rotate(270deg); }
			100% { transform: rotate(360deg); }
		}

		.content {
			position: absolute;
			inset: 2px;
			background-color: #000;
			z-index: 2;
			display: flex;
			flex-direction: row;
			padding: 2px;
			gap: 2px;
			min-height: 0;
		}

		.button {
			background-color: #1f1f1f;
			border-radius: 0.3rem;
			border: none;
			font-size: 11px;
			font-weight: bold;
			outline: none;
			padding: 0.1rem 0.3rem;
			text-align: center;
			white-space: nowrap;
			cursor: pointer;
			user-select: none;
			flex-shrink: 0;
			width: 4rem;
		}

		.textarea-container {
			flex: 1;
			min-width: 0;
			display: flex;
		}

		.editor {
			background: transparent;
			border: none;
			font-size: 1.1rem;
			outline: none;
			overflow-y: auto;
			overflow-x: hidden;
			flex: 1;
			min-width: 0;
			padding: 0.1rem 0.4rem;
			word-wrap: break-word;
			white-space: pre-wrap;
		}

		.editor::-webkit-scrollbar {
			width: 6px;
		}

		.editor::-webkit-scrollbar-track {
			background: transparent;
		}

		.editor::-webkit-scrollbar-thumb {
			background: rgba(255, 255, 255, 0.2);
			border-radius: 3px;
		}

		.editor::-webkit-scrollbar-thumb:hover {
			background: rgba(255, 255, 255, 0.3);
		}

		/* Dynamic channel-specific colors */
		[get_channel_styles()]
	</style>
</head>
<body>
	<div class="window window-[default_channel]" id="window">
		<div class="shine shine-[default_channel]" id="shine"></div>
	</div>
	<div class="content">
		<button class="button button-[default_channel]" id="channelBtn">[default_channel]</button>
		<div class="textarea-container">
			<div class="editor editor-[default_channel]" id="editor" contenteditable="true" spellcheck="false"></div>
		</div>
	</div>

	<script>
		let currentChannel = '[default_channel]';
		let currentChannelIndex = 0;
		let windowOpen = false;
		let chatHistory = \[\];
		let historyIndex = -1;
		let tempMessage = '';
		let isDragging = false;
		let dragStartPos = {x: 0, y: 0};
		let currentSize = 'small';

		const channels = [channels_json];
		const quietChannels = [quiet_json];
		const windowSizes = { small: 30, medium: 50, large: 70 };
		const lineLengths = { small: 15, medium: 31, large: 46 };

		const windowEl = document.getElementById('window');
		const shineEl = document.getElementById('shine');
		const button = document.getElementById('channelBtn');
		const editor = document.getElementById('editor');
		let realText = ''; // Store the actual markdown input

		function parseMarkdownBasic(text, barebones) {
			if (!text || text.length === 0) return text;
			let t = text;

			if (!barebones) {
				t = t.replace(/\\$/g, '$-');
				t = t.replace(/\\\\\\\\/g, '$1');
				t = t.replace(/\\\\\\*\\*/g, '$2');
				t = t.replace(/\\\\\\*/g, '$3');
				t = t.replace(/\\\\__/g, '$4');
				t = t.replace(/\\\\_/g, '$5');
				t = t.replace(/\\\\\\^/g, '$6');
				t = t.replace(/\\\\\\(\\(/g, '$7');
				t = t.replace(/\\\\\\)\\)/g, '$8');
				t = t.replace(/\\\\\\|/g, '$9');
				t = t.replace(/\\\\%/g, '$0');
			}

			t = t.replace(/!/g, '$a');

			if (barebones) {
				t = t.replace(/\\+(\[^\\+\]+)\\+/g, '<b>$1</b>');
				t = t.replace(/\\|(\[^\\|\]+)\\|/g, '<i>$1</i>');
				t = t.replace(/_(\[^_\]+)_/g, '<u>$1</u>');
			} else {
				t = t.replace(/\\*(\[^\\*\]*)\\*/g, '<i>$1</i>');
				t = t.replace(/_(\[^_\]*)_/g, '<i>$1</i>');
				t = t.replace(/<i><\\/i>/g, '!');
				t = t.replace(/<\\/i><i>/g, '!');
				t = t.replace(/!(\[^!\]+)!/g, '<b>$1</b>');
				t = t.replace(/\\^(\[^\\^\]+)\\^/g, '<font size="4">$1</font>');
				t = t.replace(/\\|(\[^\\|\]+)\\|/g, '<center>$1</center>');
				t = t.replace(/!/g, '</i><i>');
			}

			t = t.replace(/\\$a/g, '!');

			if (!barebones) {
				t = t.replace(/\\$1/g, '\\\\\\\\');
				t = t.replace(/\\$2/g, '**');
				t = t.replace(/\\$3/g, '*');
				t = t.replace(/\\$4/g, '__');
				t = t.replace(/\\$5/g, '_');
				t = t.replace(/\\$6/g, '^');
				t = t.replace(/\\$7/g, '((');
				t = t.replace(/\\$8/g, '))');
				t = t.replace(/\\$9/g, '|');
				t = t.replace(/\\$0/g, '%');
				t = t.replace(/\\$-/g, '$');
			}

			return t;
		}

		function getCursorPosition() {
			const sel = window.getSelection();
			if (!sel.rangeCount) return 0;

			const range = sel.getRangeAt(0);
			const preRange = range.cloneRange();
			preRange.selectNodeContents(editor);
			preRange.setEnd(range.endContainer, range.endOffset);

			const renderedPos = preRange.toString().length;

			// Map rendered position back to raw text position
			return mapRenderedToRaw(renderedPos);
		}

		function mapRenderedToRaw(renderedPos) {
			// Parse the text to figure out where markdown syntax is
			let rawPos = 0;
			let renderedCount = 0;
			let i = 0;

			while (i < realText.length && renderedCount < renderedPos) {
				// Check for +bold+
				if (realText\[i\] === '+') {
					const closeIdx = realText.indexOf('+', i + 1);
					if (closeIdx !== -1) {
						// Skip opening +
						i++;
						rawPos++;
						// Count the content
						while (i < closeIdx && renderedCount < renderedPos) {
							renderedCount++;
							i++;
							rawPos++;
						}
						// Skip closing +
						if (i === closeIdx) {
							i++;
							rawPos++;
						}
						continue;
					}
				}
				// Check for |italic|
				if (realText\[i\] === '|') {
					const closeIdx = realText.indexOf('|', i + 1);
					if (closeIdx !== -1) {
						i++;
						rawPos++;
						while (i < closeIdx && renderedCount < renderedPos) {
							renderedCount++;
							i++;
							rawPos++;
						}
						if (i === closeIdx) {
							i++;
							rawPos++;
						}
						continue;
					}
				}
				// Check for _underline_
				if (realText\[i\] === '_') {
					const closeIdx = realText.indexOf('_', i + 1);
					if (closeIdx !== -1) {
						i++;
						rawPos++;
						while (i < closeIdx && renderedCount < renderedPos) {
							renderedCount++;
							i++;
							rawPos++;
						}
						if (i === closeIdx) {
							i++;
							rawPos++;
						}
						continue;
					}
				}

				// Normal character
				renderedCount++;
				i++;
				rawPos++;
			}

			return rawPos;
		}

		function mapRawToRendered(rawPos) {
			// Map raw text position to rendered position
			let renderedPos = 0;
			let i = 0;

			while (i < rawPos && i < realText.length) {
				// Check for +bold+
				if (realText\[i\] === '+') {
					const closeIdx = realText.indexOf('+', i + 1);
					if (closeIdx !== -1 && closeIdx < rawPos) {
						// Skip opening +
						i++;
						// Count the content
						while (i < closeIdx && i < rawPos) {
							renderedPos++;
							i++;
						}
						// Skip closing + if we're past it
						if (i === closeIdx && i < rawPos) {
							i++;
						}
						continue;
					}
				}
				// Check for |italic|
				if (realText\[i\] === '|') {
					const closeIdx = realText.indexOf('|', i + 1);
					if (closeIdx !== -1 && closeIdx < rawPos) {
						i++;
						while (i < closeIdx && i < rawPos) {
							renderedPos++;
							i++;
						}
						if (i === closeIdx && i < rawPos) {
							i++;
						}
						continue;
					}
				}
				// Check for _underline_
				if (realText\[i\] === '_') {
					const closeIdx = realText.indexOf('_', i + 1);
					if (closeIdx !== -1 && closeIdx < rawPos) {
						i++;
						while (i < closeIdx && i < rawPos) {
							renderedPos++;
							i++;
						}
						if (i === closeIdx && i < rawPos) {
							i++;
						}
						continue;
					}
				}

				// Normal character
				renderedPos++;
				i++;
			}

			return renderedPos;
		}

		function setCursorPosition(pos) {
			const sel = window.getSelection();
			const range = document.createRange();

			let charCount = 0;
			let foundPos = false;

			function traverseNodes(node) {
				if (foundPos) return;

				if (node.nodeType === Node.TEXT_NODE) {
					const nextCharCount = charCount + node.length;
					if (pos >= charCount && pos <= nextCharCount) {
						range.setStart(node, Math.min(pos - charCount, node.length));
						range.collapse(true);
						foundPos = true;
						return;
					}
					charCount = nextCharCount;
				} else {
					for (let i = 0; i < node.childNodes.length; i++) {
						traverseNodes(node.childNodes\[i\]);
						if (foundPos) return;
					}
				}
			}

			traverseNodes(editor);

			if (foundPos) {
				sel.removeAllRanges();
				sel.addRange(range);
			} else if (editor.childNodes.length > 0) {
				// Fallback: place at end
				const lastNode = editor.childNodes\[editor.childNodes.length - 1\];
				const lastChild = lastNode.nodeType === Node.TEXT_NODE ? lastNode : (lastNode.lastChild || lastNode);
				try {
					if (lastChild.nodeType === Node.TEXT_NODE) {
						range.setStart(lastChild, lastChild.length);
					} else {
						range.setStartAfter(lastChild);
					}
					range.collapse(true);
					sel.removeAllRanges();
					sel.addRange(range);
				} catch(e) {}
			}
		}

		function updatePreview() {
			// Parse and render the markdown
			const parsed = parseMarkdownBasic(realText, true);

			// Only update if the HTML changed to avoid cursor jumps
			if (editor.innerHTML !== parsed) {
				editor.innerHTML = parsed;
			}
		}

		function applyTheme(channel) {
			windowEl.className = 'window window-' + channel;
			shineEl.className = 'shine shine-' + channel;
			button.className = 'button button-' + channel;
			editor.className = 'editor editor-' + channel;
		}

		function updateWindowSize() {
			let len = realText.length;
			let newSize = 'small';

			if (len > lineLengths.medium) {
				newSize = 'large';
			} else if (len > lineLengths.small) {
				newSize = 'medium';
			} else {
				newSize = 'small';
			}

			if (newSize !== currentSize) {
				currentSize = newSize;
				window.location = 'byond://?src=' + encodeURIComponent('[ref(src)]') + ';action=resize;size=' + newSize;
			}
		}

		function openWindow(channel) {
			windowOpen = true;
			currentChannel = channel;
			currentChannelIndex = channels.indexOf(channel) || 0;

			button.textContent = channel;
			applyTheme(channel);
			editor.innerHTML = '';
			realText = '';
			currentSize = 'small';
			editor.focus();

			window.location = 'byond://?src=' + encodeURIComponent('[ref(src)]') + ';action=open;channel=' + encodeURIComponent(channel);

			if (!quietChannels.includes(channel)) {
				window.location = 'byond://?src=' + encodeURIComponent('[ref(src)]') + ';action=thinking;visible=1';
			}
		}

		function closeWindow() {
			windowOpen = false;
			editor.blur();
			historyIndex = -1;
			tempMessage = '';
			currentSize = 'small';

			window.location = 'byond://?src=' + encodeURIComponent('[ref(src)]') + ';action=close';
		}

		function cycleChannel() {
			currentChannelIndex = (currentChannelIndex + 1) % channels.length;
			currentChannel = channels\[currentChannelIndex\];
			button.textContent = currentChannel;
			applyTheme(currentChannel);

			let visible = !quietChannels.includes(currentChannel);
			window.location = 'byond://?src=' + encodeURIComponent('[ref(src)]') + ';action=thinking;visible=' + (visible ? '1' : '0');
		}

		function submitEntry() {
			let entry = realText.trim();
			if (entry.length > 0 && entry.length < 1024) {
				chatHistory.unshift(entry);
				if (chatHistory.length > 5) chatHistory.pop();

				window.location = 'byond://?src=' + encodeURIComponent('[ref(src)]') + ';action=entry;channel=' + encodeURIComponent(currentChannel) + ';entry=' + encodeURIComponent(entry);
			}
			closeWindow();
		}

		button.addEventListener('mousedown', function(e) {
			isDragging = true;
			dragStartPos = {x: e.screenX, y: e.screenY};
		});

		button.addEventListener('mouseup', function(e) {
			setTimeout(function() {
				if (isDragging && e.screenX === dragStartPos.x && e.screenY === dragStartPos.y) {
					cycleChannel();
				}
				isDragging = false;
			}, 50);
		});

		editor.addEventListener('beforeinput', function(e) {
			const cursorPos = getCursorPosition();
			const sel = window.getSelection();
			const hasSelection = sel.rangeCount > 0 && !sel.getRangeAt(0).collapsed;

			let selectionStart = cursorPos;
			let selectionEnd = cursorPos;

			if (hasSelection) {
				const range = sel.getRangeAt(0);
				const preRange = range.cloneRange();
				preRange.selectNodeContents(editor);
				preRange.setEnd(range.startContainer, range.startOffset);
				selectionStart = preRange.toString().length;
				selectionEnd = cursorPos;
			}

			// Track the raw text input by intercepting before HTML rendering
			if (e.inputType === 'insertText' && e.data) {
				e.preventDefault();
				// Insert character at cursor position
				realText = realText.slice(0, selectionStart) + e.data + realText.slice(selectionEnd);
				updatePreview();
				setCursorPosition(selectionStart + e.data.length);
			} else if (e.inputType === 'deleteContentBackward') {
				e.preventDefault();
				if (hasSelection) {
					// Delete selection
					realText = realText.slice(0, selectionStart) + realText.slice(selectionEnd);
					updatePreview();
					setCursorPosition(selectionStart);
				} else if (cursorPos > 0) {
					// Delete one character before cursor
					realText = realText.slice(0, cursorPos - 1) + realText.slice(cursorPos);
					updatePreview();
					setCursorPosition(cursorPos - 1);
				}
			} else if (e.inputType === 'deleteContentForward') {
				e.preventDefault();
				if (hasSelection) {
					// Delete selection
					realText = realText.slice(0, selectionStart) + realText.slice(selectionEnd);
					updatePreview();
					setCursorPosition(selectionStart);
				} else if (cursorPos < realText.length) {
					// Delete one character after cursor
					realText = realText.slice(0, cursorPos) + realText.slice(cursorPos + 1);
					updatePreview();
					setCursorPosition(cursorPos);
				}
			} else if (e.inputType === 'insertLineBreak') {
				e.preventDefault();
				// Handle enter key
				realText = realText.slice(0, selectionStart) + '\\n' + realText.slice(selectionEnd);
				updatePreview();
				setCursorPosition(selectionStart + 1);
			} else if (e.inputType === 'insertFromPaste') {
				e.preventDefault();
				// Handle paste
				const pastedText = e.dataTransfer ? e.dataTransfer.getData('text/plain') : '';
				realText = realText.slice(0, selectionStart) + pastedText + realText.slice(selectionEnd);
				updatePreview();
				setCursorPosition(selectionStart + pastedText.length);
			}

			updateWindowSize();

			if (!quietChannels.includes(currentChannel)) {
				window.location = 'byond://?src=' + encodeURIComponent('[ref(src)]') + ';action=typing';
			}
		});

		editor.addEventListener('keydown', function(e) {
			if (e.key === 'Enter' && !e.shiftKey) {
				e.preventDefault();
				submitEntry();
			} else if (e.key === 'Escape') {
				e.preventDefault();
				closeWindow();
			} else if (e.key === 'Tab') {
				e.preventDefault();
				cycleChannel();
			} else if (e.key === 'ArrowUp') {
				e.preventDefault();
				if (historyIndex === -1 && realText) {
					tempMessage = realText;
				}
				if (historyIndex < chatHistory.length - 1) {
					historyIndex++;
					realText = chatHistory\[historyIndex\];
					editor.textContent = realText;
					button.textContent = (historyIndex + 1).toString();
					updatePreview();
					updateWindowSize();
				}
			} else if (e.key === 'ArrowDown') {
				e.preventDefault();
				if (historyIndex > 0) {
					historyIndex--;
					realText = chatHistory\[historyIndex\];
					editor.textContent = realText;
					button.textContent = (historyIndex + 1).toString();
					updatePreview();
					updateWindowSize();
				} else if (historyIndex === 0) {
					historyIndex = -1;
					realText = tempMessage;
					editor.textContent = realText;
					tempMessage = '';
					button.textContent = currentChannel;
					updatePreview();
					updateWindowSize();
				}
			} else if ((e.key === 'Backspace' || e.key === 'Delete') && realText.length === 0) {
				if (historyIndex !== -1) {
					historyIndex = -1;
					button.textContent = currentChannel;
				}
			}
		});

		window.openSayWindow = openWindow;
	</script>
</body>
</html>"}

/datum/native_say/Topic(href, href_list)
	. = ..()
	if(href_list["action"])
		switch(href_list["action"])
			if("open")
				handle_open(href_list["channel"])
			if("close")
				handle_close()
			if("entry")
				handle_entry(href_list["channel"], href_list["entry"])
			if("thinking")
				handle_thinking(text2num(href_list["visible"]))
			if("typing")
				handle_typing()
			if("resize")
				handle_resize(href_list["size"])

/datum/native_say/proc/handle_resize(size_name)
	resize_window(size_name)

/datum/native_say/proc/handle_open(channel_name)
	window_open = TRUE

	for(var/datum/say_channel/channel in available_channels)
		if(channel.name == channel_name)
			current_channel = channel
			break

	if(current_channel && !current_channel.quiet)
		start_thinking()

/datum/native_say/proc/handle_close()
	window_open = FALSE
	stop_thinking()
	resize_window("small")
	winset(client, "native_say", "is-visible=0")

/datum/native_say/proc/handle_entry(channel_name, entry)
	if(!entry || length(entry) > max_length)
		return FALSE

	var/datum/say_channel/channel
	for(var/datum/say_channel/ch in available_channels)
		if(ch.name == channel_name)
			channel = ch
			break

	if(!channel)
		return FALSE

	channel.send(client, entry) // this is so we can add new channels for languages

	winset(client, "native_say", "is-visible=0")
	return TRUE

/datum/native_say/proc/handle_thinking(visible)
	if(visible)
		start_thinking()
	else
		stop_thinking()

/datum/native_say/proc/handle_typing()
	if(window_open)
		start_typing()

/datum/native_say/proc/start_thinking()
	if(!window_open)
		return FALSE
	return client.start_thinking()

/datum/native_say/proc/stop_thinking()
	return client.stop_thinking()

/datum/native_say/proc/start_typing()
	if(!window_open)
		return FALSE
	return client.start_typing()

/datum/native_say/proc/open_say_window(channel_name)
	var/datum/say_channel/channel = current_channel
	if(channel_name)
		for(var/datum/say_channel/ch in available_channels)
			if(ch.name == channel_name)
				channel = ch
				break

	if(!channel && available_channels.len > 0)
		channel = available_channels[1]

	if(channel)
		resize_window("small")
		winset(client, "native_say", "is-visible=1")
		client << output(null, "native_say.browser:openSayWindow('[channel.name]')")

/datum/native_say/proc/force_say()
	client << output(null, "native_say.browser:submitEntry()")
	client.stop_typing()
