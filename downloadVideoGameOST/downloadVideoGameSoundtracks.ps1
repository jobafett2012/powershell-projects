$URLS = @(
"https://downloads.khinsider.com/game-soundtracks/album/metroid-super-metroid"
)

$BASE_PATH = "R:\MUSIC"

foreach($URL in $URLS){
    $DL_FOLDER = $(Split-Path -path "$URL" -leaf)
    New-Item -Type Directory -Path "${BASE_PATH}\${DL_FOLDER}"

    $(Invoke-WebRequest "$URL").Links | ? {$_.href -like "*.mp3" -and $_.outerText -notlike "*:*" -and $_.outerText -notlike "* MB" -and $_.outerText -ne "get_app"} | %{
        $CONTEXT = $_.href
        $URL = "https://downloads.khinsider.com${CONTEXT}"
        $FILENAME = [System.Uri]::UnescapeDataString(${CONTEXT}.Replace('%25','%'))| Split-Path -Leaf

        if($FILENAME.length -ge 248){
            $FILENAME = $FILENAME.Substring(0,50)
        }

        Invoke-WebRequest ($(Invoke-WebRequest "${URL}").Links | ? {$_.href -like "*.mp3"}).href -OutFile "R:\MUSIC\${DL_FOLDER}\${FILENAME}"
    }
}
