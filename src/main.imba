import "./reset.imba"
import "./components/mirrored-textarea.imba"

global css
	@root
		fs:16px lh:24px fw:400 c:gray4
		color-scheme: light dark
		bgc:#242424
		
css
	textarea, mirrored-textarea
		ga:stack
		border:none resize:none
		px:12 py:6
		ff:monospace
		fw:500 fs:2xl
		word-break:break-word
		overflow-wrap:break-word
		ws:pre-wrap

	textarea
		bg:transparent c:transparent caret-color:gray2
		@focus outline:none

tag app
	tasksTxt = "My first task 5d 8m / 4h 2m [2020-12-12 10:00:00]"

	<self[min-height:100vh d:flex]>
		<div[w:30 bgc:gray7 ta:center py:4]> "sidebar"
		<div[flex:1 d:vflex bd:2px solid gray9]>
			<div[h:15 bgc:gray8 bdb:2px solid gray9 d:flex ai:center px:4]> "header"
			<main[flex:1 d:grid gta:"stack" bgc:gray8]>
				<mirrored-textarea tasksTxt=tasksTxt>
				<textarea bind=tasksTxt>



imba.mount <app>, document.getElementById "app"