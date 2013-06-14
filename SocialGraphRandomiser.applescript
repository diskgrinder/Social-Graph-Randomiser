tell application "Google Chrome"
	-- just check chrome's just there then
	activate
end tell


repeat
	-- you need google chrome open 
	-- with the first tab at your starting point
	tell application "Google Chrome" to tell tab 1 of window 1
		set t to execute javascript "document.body.innerText"
	end tell
	-- split the inner text into an array
	set theSentences to my splitString(t as text, " ")
	if the number of items in theSentences is greater than 3 then
		set word1 to some item of theSentences
		set word2 to some item of theSentences
		set word3 to some item of theSentences
		
		log "_________TEXT is " & word1 & " " & word2 & " " & word3
	else
		set word1 to do shell script "curl http://randomword.setgetgo.com/get.php"
		set word2 to do shell script "curl http://randomword.setgetgo.com/get.php"
		set word3 to do shell script "curl http://randomword.setgetgo.com/get.php"
		log "_________BACK UP TEXT is " & word1 & " " & word2 & " " & word3
	end if
	
	
	set thesearch to "https://www.google.co.uk/search?q=" & word1 & "+" & word2 & "+" & word3
	
	tell application "Google Chrome"
		tell window 1
			set the URL of tab 1 to thesearch
			delay 10
			try
				execute tab 1 javascript "document.forms[0]['btnI'].click()"
			end try
			delay 8
			set thesearch to the URL of tab 1
			log "step 1_________WENT TO " & thesearch
			set rand to random number from 1 to 20
			if rand is greater than 5 then
				try
					set s to execute tab 1 javascript "document.links.length"
					set rand to random number from 1 to s
					set j to execute tab 1 javascript "document.links[" & rand & "].href"
					log s & " links " & rand & " " & j
					
					execute tab 1 javascript "document.links[" & rand & "].click()"
					
				end try
				delay 8
				set thesearch to the URL of tab 1
				log "step 2_________WENT TO " & thesearch
			end if
			
		end tell
	end tell
	
	
	set rand to random number from 1 to 1000
	log "waiting " & rand
	delay rand
end repeat



-- i got this from somewhere, years ago..
to splitString(aString, delimiter)
	set retVal to {}
	set prevDelimiter to AppleScript's text item delimiters
	log delimiter
	set AppleScript's text item delimiters to {delimiter}
	set retVal to every text item of aString
	set AppleScript's text item delimiters to prevDelimiter
	return retVal
end splitString
