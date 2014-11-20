#////////////////////////////////////////////////////////////////////////////////
# Module de Log d'erreurs: 
#	Script cr�ant un Log contenant toutes les erreurs s'�tant produites durant 
#	la configuration du serveur.
#///////////////////////////////////////////////////////////////////////////////
$LogFile = "Output.log"
$LogFilePath = "C:\"
$CompletePath = $LogFilePath+$LogFile



#Returns true if the Log file exists false otherwise (and creates the log file)
function CreateLog()
{
	if ((Test-Path $CompletePath) -eq $true)
	{
	 	return $true
	}
	else 
	{
		New-Item -Name $LogFile -Path $LogFilePath -type "file"
		return $false
	}	
}

#�cris dans le fichier log
function WriteToLog($raisonErreur, $messageErreurExcept)
{
	CreateLog #Cr�er le Log si n�cessaire
	
	Add-Content $CompletePath $raisonErreur
	Add-Content $CompletePath $messageErreurExcept
    Add-Content $CompletePath " " # Ajout d'une ligne vide

}


#Test
WriteToLog "Ok" "bonjour"
