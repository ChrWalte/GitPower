param([string]$location=(Get-Location)) 

Add-Content ./GitPower.log "GitPowerShell Start At $location On $(Get-Date)`n";

$folders = Get-ChildItem ./ |
            Where-Object {$_.PSIsContainer} |
            ForEach-Object {$_.Name};

foreach ($folder in $folders) {
    Set-Location ./$folder;
    
    Add-Content ../GitPower.log "Git Fetch on $folder";

    $gitFetch = (git fetch -v 2>&1);
    Add-Content ../GitPower.log $gitFetch;

    Add-Content ../GitPower.log "Git Pull on $folder";
    $gitPull = (git pull -v 2>&1);
    Add-Content ../GitPower.log $gitFetch;

    Add-Content ../GitPower.log "`n";

    Set-Location ../;
}

Add-Content ./GitPower.log "GitPowerShell End At $location On $(Get-Date)`n";