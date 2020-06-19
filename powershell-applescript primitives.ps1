#for choose from list, you get a comma-delimited applescript list aka powershell array
$results = 'choose from list {"thing1","thing2"} multiple selections allowed true'|/usr/bin/osascript

#split the string on a comma, and put each entry into an array
$listChoice = $results.Split(",")

#yoink unwanted trailing/leading spaces
for ($i = 0; $i -lt $listChoice.Count; $i++) {
     $listChoice[$i] = $listChoice[$i].Trim()
}