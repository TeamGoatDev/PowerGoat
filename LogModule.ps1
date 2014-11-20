#////////////////////////////////////////////////////////////////////////////////
# Module de Log d'erreurs: 
#	Script créant un Log contenant toutes les erreurs s'étant produites durant 
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

#Écris dans le fichier log
function WriteToLog($raisonErreur, $messageErreurExcept)
{
	CreateLog #Créer le Log si nécessaire
	
	Add-Content $CompletePath $raisonErreur
	Add-Content $CompletePath $messageErreurExcept
    Add-Content $CompletePath " " # Ajout d'une ligne vide

}


#Test
WriteToLog "Ok" "bonjour"
