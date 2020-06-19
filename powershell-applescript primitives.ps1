#for choose from list, you get a comma-delimited applescript list aka powershell array
$results = 'choose from list {"thing1","thing2"} multiple selections allowed true'|/usr/bin/osascript

#split the string on a comma, and put each entry into an array
$listChoice = $results.Split(",")

#yoink unwanted trailing/leading spaces
for ($i = 0; $i -lt $listChoice.Count; $i++) {
     $listChoice[$i] = $listChoice[$i].Trim()
}

#for choose application, you just get the application name as a string
$results = 'choose application with prompt "choose the app" with multiple selections allowed'|/usr/bin/osascript

###this returns the POSIX path version of the alias that choose file normally returns as comma-delimited strings
#starting with "alias " Note that this is for choosing an existing file, not getting a path to a file you'll be be creating in that location
$results = 'choose file with prompt "choose the file" with multiple selections allowed'|/usr/bin/osascript

#put each file alias path in an array
$pathList = $results.Split(",")

#go through the array and convert to POSIX-style paths
for ($i = 0; $i -lt $pathList.Count; $i++) {
     #trim any leading/trailing spaces
     $pathlist[$i] = $pathList[$i].Trim()
     
     #trim the "alias " from the start of each entry
     $pathlist[$i] = $pathList[$i].TrimStart("alias ")
     
     #if we only did one file at a time, we'd not have to do this much work, we could do the whold thing in one step by 
     #adding "POSIX path of" in front of choose file and enclosing the choose file statement in parenthses. But that
     #doesn't work with multiple files, so we have to manipulate the string versions of the alias paths we get back.
     #luckily, it's pretty straightforward

     #get the position of the first colon, which will be the root "/" in the posix-style path
     $temp = $pathList[$i].IndexOf(":")

     #trim the name of the hard drive off of the alias path, so the first character is now the first colon
     $pathList[$i] = $pathList[$i].Substring($temp)

     #replace all the colons with unix path slashes
     $pathList[$i] = $pathList[$i] -replace ":","/"
}
$pathList
