const durationMatcher = '(?<duration>((\\d+(?:d|h|m|s)) ?)+(\\s*))'
const workedTimeMatcher = '(?<workedTime>((\\s*)(\\d+(?:d|h|m|s)) ?)+)(\\s*)'
const startTimeMatcher = '(?<startTime>\\[.*\\](\\s*))'

tag mirrored-textarea
	prop tasksTxt = ""
	def parseTaskTxt(taskTxt) do 
		const regex = new RegExp(durationMatcher + '/' + workedTimeMatcher + startTimeMatcher + '$')
		const match = taskTxt.match(regex)
		if !match then return { value: taskTxt }
		for own key, value of match.groups
			if value === undefined then match.groups[key] = ""
		let { duration, workedTime, startTime } = match..groups
		const noMissingPart = [duration, workedTime, startTime].some(Boolean) 
		console.log("value match", `'{match[0]}'`)
		const value = if (noMissingPart) then taskTxt.replace(match[0], "") else taskTxt
		{ value, duration, workedTime, startTime }

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
			<span[c:orange6]> computedTask.duration
			<span[c:gray6]> "/" + computedTask.workedTime if computedTask.workedTime
			<span[c:teal7]> "{computedTask.startTime}" if computedTask.startTime
			<br>
