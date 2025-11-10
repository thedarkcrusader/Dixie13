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
		.textarea-[channel_name] { color: [channel.color]; }
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

		.textarea {
			background: transparent;
			border: none;
			font-size: 1.1rem;
			outline: none;
			resize: none;
			overflow-y: auto;
			overflow-x: hidden;
			flex: 1;
			min-width: 0;
			padding: 0.1rem 0.4rem;
			word-wrap: break-word;
		}

		.textarea::-webkit-scrollbar {
			width: 6px;
		}

		.textarea::-webkit-scrollbar-track {
			background: transparent;
		}

		.textarea::-webkit-scrollbar-thumb {
			background: rgba(255, 255, 255, 0.2);
			border-radius: 3px;
		}

		.textarea::-webkit-scrollbar-thumb:hover {
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
		<textarea class="textarea textarea-[default_channel]" id="input" maxlength="1024" spellcheck="false" autocorrect="off" rows="1"></textarea>
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
		const textarea = document.getElementById('input');

		//theming
		function applyTheme(channel) {
			windowEl.className = 'window window-' + channel;
			shineEl.className = 'shine shine-' + channel;
			button.className = 'button button-' + channel;
			textarea.className = 'textarea textarea-' + channel;
		}

		function updateWindowSize() {
			let len = textarea.value.length;
			let newSize = 'small';

			if (len > lineLengths.medium) {
				newSize = 'large';
				textarea.rows = 3;
			} else if (len > lineLengths.small) {
				newSize = 'medium';
				textarea.rows = 2;
			} else {
				newSize = 'small';
				textarea.rows = 1;
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
			textarea.value = '';
			textarea.rows = 1;
			currentSize = 'small';
			textarea.focus();

			window.location = 'byond://?src=' + encodeURIComponent('[ref(src)]') + ';action=open;channel=' + encodeURIComponent(channel);

			// thinking indicator if IC channel
			if (!quietChannels.includes(channel)) {
				window.location = 'byond://?src=' + encodeURIComponent('[ref(src)]') + ';action=thinking;visible=1';
			}
		}

		function closeWindow() {
			windowOpen = false;
			textarea.blur();
			historyIndex = -1;
			tempMessage = '';
			textarea.rows = 1;
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
			let entry = textarea.value.trim();
			if (entry.length > 0 && entry.length < 1024) {
				chatHistory.unshift(entry);
				if (chatHistory.length > 5) chatHistory.pop();

				window.location = 'byond://?src=' + encodeURIComponent('[ref(src)]') + ';action=entry;channel=' + encodeURIComponent(currentChannel) + ';entry=' + encodeURIComponent(entry);
			}
			closeWindow();
		}

		//clickie
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

		textarea.addEventListener('input', function() {
			updateWindowSize();

			if (!quietChannels.includes(currentChannel)) {
				window.location = 'byond://?src=' + encodeURIComponent('[ref(src)]') + ';action=typing';
			}
		});

		textarea.addEventListener('keydown', function(e) {
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
				if (historyIndex === -1 && textarea.value) {
					tempMessage = textarea.value;
				}
				if (historyIndex < chatHistory.length - 1) {
					historyIndex++;
					textarea.value = chatHistory\[historyIndex\];
					button.textContent = (historyIndex + 1).toString();
					updateWindowSize();
				}
			} else if (e.key === 'ArrowDown') {
				e.preventDefault();
				if (historyIndex > 0) {
					historyIndex--;
					textarea.value = chatHistory\[historyIndex\];
					button.textContent = (historyIndex + 1).toString();
					updateWindowSize();
				} else if (historyIndex === 0) {
					historyIndex = -1;
					textarea.value = tempMessage;
					tempMessage = '';
					button.textContent = currentChannel;
					updateWindowSize();
				}
			} else if ((e.key === 'Backspace' || e.key === 'Delete') && textarea.value.length === 0) {
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
