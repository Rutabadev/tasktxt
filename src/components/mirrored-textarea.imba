tag mirrored-textarea
	prop tasksTxt = ""
	def parseTaskTxt(taskTxt) do 
		const match = taskTxt.match(/(?<duration>((\d+(?:d|h|m|s)) ?)+)?((?<postDurationGap>\s*)\/(?<preWorkedTimeGap>\s*)(?<workedTime>((\d+(?:d|h|m|s)) ?)+))?(?<postWorkedTimeGap>\s*)(?<startTime>\[.*\])?$/)
		for own key, value of match.groups
			if value === undefined then match.groups[key] = ""
		let { duration, postDurationGap, preWorkedTimeGap, workedTime, postWorkedTimeGap, startTime } = match..groups
		const value = if ([duration, workedTime, startTime].some(Boolean)) then taskTxt.replace(match[0], "") else taskTxt
		{ value, duration, postDurationGap, preWorkedTimeGap, workedTime, postWorkedTimeGap, startTime }

	def computeTasks(tasksTxt)
		const tasks = tasksTxt.split(/\n/);
		tasks.map do(taskTxt)
			const task = parseTaskTxt(taskTxt)
			console.log task
			task	
	
	def render
		computedTasks = computeTasks(tasksTxt);
		<self> for computedTask in computedTasks
			<span> computedTask.value
			<span[c:orange6]> computedTask.duration + computedTask.postDurationGap
			<span[c:gray6]> "/{computedTask.preWorkedTimeGap}{computedTask.workedTime}{computedTask.postWorkedTimeGap}" if computedTask.workedTime
			<span[c:teal7]> "{computedTask.startTime}" if computedTask.startTime
			<br>
