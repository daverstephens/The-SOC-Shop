#
# Handy little powershell command to script conversion of .evtx files into .csv files for easier searching with commandline tools
#
$a = Get-Item c:\path to evtx files\*.evtx
foreach($file in $a)
{
get-winevent -path $file.FullName | export-csv $file.FullName.replace(".evtx",".csv") -useculture
}
