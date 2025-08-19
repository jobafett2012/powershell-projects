#Set this to the folder where you stored the Links.txt file
$LIST_PATH = "B:\NintendoPower"

#Set this to the location where you want to download the files
#I set this to the same location i stored the Links file to keep things organized
$DL_PATH = $LIST_PATH

#parse Links.txt to get the file name and download link
Get-Content ${LIST_PATH}\Links.txt | ForEach-Object{
    $FILENAME = $($_ -split ',')[0]
    $URI = $($_ -split ',')[1]
    Write-Output "Downloading ${URI} to ${DL_PATH}\${FILENAME}"
    #Invoke the link and save the file to disk
    Invoke-WebRequest -Uri ${URI} -OutFile "${DL_PATH}\${FILENAME}"
}