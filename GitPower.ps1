param([string]$location=(Get-Location)) 
$logLocation = Get-Location;

Add-Content $logLocation/GitPower.log "GitPowerShell Start At $location On $(Get-Date)`n";

$folders = Get-ChildItem $location |
            Where-Object {$_.PSIsContainer} |
            ForEach-Object {$_.Name};

foreach ($folder in $folders) {
    Set-Location $location/$folder;
    
    Add-Content $logLocation/GitPower.log "Git Fetch on $folder";

    $gitFetch = (git fetch -v 2>&1);
    Add-Content $logLocation/GitPower.log $gitFetch;

    Add-Content $logLocation/GitPower.log "Git Pull on $folder";
    $gitPull = (git pull -v 2>&1);
    Add-Content $logLocation/GitPower.log $gitPull;

    Add-Content $logLocation/GitPower.log "`n";

    Set-Location ../;
}

Add-Content $logLocation/GitPower.log "GitPowerShell End At $location On $(Get-Date)`n";