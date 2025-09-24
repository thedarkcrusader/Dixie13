/client/proc/toggle_jobs_for_persistent()
	set category = "GameMaster"
	set name = "Toggle all jobs for persistent"

	if(!check_rights(R_ADMIN))
		return FALSE

	var/list/options = list("DISABLE ALL JOBS, ENABLE PERSISTENT JOBS", "ENABLE ALL JOBS, DISABLE PERSISTENT JOBS", "DO NOTHING")

	var/toggle_jobs = browser_input_list(usr, "Which choice?", "Toggle all jobs for persistent", options, "DO NOTHING")
	switch(toggle_jobs)
		if("DO NOTHING")
			return
		if("DISABLE ALL JOBS, ENABLE PERSISTENT JOBS")
			for(var/datum/job/job_to_toggle in SSjob.joinable_occupations)
				if(job_to_toggle.persistent_job)
					job_to_toggle.enabled = TRUE
					job_to_toggle.total_positions = 8
				else
					job_to_toggle.enabled = FALSE
					job_to_toggle.total_positions = 0
			message_admins("[key_name_admin(usr)] disabled all jobs and enabled all persistent jobs.")
		if("ENABLE ALL JOBS, DISABLE PERSISTENT JOBS")
			for(var/datum/job/job_to_toggle in SSjob.joinable_occupations)
				if(!job_to_toggle.persistent_job)
					job_to_toggle.enabled = TRUE
					job_to_toggle.total_positions = initial(job_to_toggle.total_positions)
				else
					job_to_toggle.enabled = FALSE
					job_to_toggle.total_positions = 0
			message_admins("[key_name_admin(usr)] enabled all jobs and disabled all persistent jobs.")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Toggle all jobs for persistent")
