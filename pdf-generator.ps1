function Grab-PDFs {
    [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    [System.Windows.Forms.Application]::EnableVisualStyles()
    $browse = New-Object System.Windows.Forms.FolderBrowserDialog
    $browse.SelectedPath = "C:\"
    $browse.ShowNewFolderButton = $false
    $browse.Description = "Select a directory"

    $loop = $true
    while($loop)
    {
        if ($browse.ShowDialog() -eq "OK")
        {
        $loop = $false
		
		cd $browse.SelectedPath
		
		# Grab PDFs from web page
		
		$psPage = Invoke-WebRequest "https://cv.solom.no"
		$urls = $psPage.ParsedHtml.getElementsByTagName("A") | ? {$_.href -like "*.pdf"} | Select-Object -ExpandProperty href

		$urls | ForEach-Object {Invoke-WebRequest -Uri $_ -OutFile ($_ | Split-Path -Leaf)}
		
		Write-Host "... PDF downloading is complete." 
		[System.Windows.Forms.MessageBox]::Show("Your PDFs have been downloaded.", "Job Complete")
		
        } else
        {
            $res = [System.Windows.Forms.MessageBox]::Show("You clicked Cancel. Would you like to try again or exit?", "Select a location", [System.Windows.Forms.MessageBoxButtons]::RetryCancel)
            if($res -eq "Cancel")
            {
                #Ends script
                return
            }
        }
    }
    $browse.SelectedPath
    $browse.Dispose()
} Grab-PDFs
