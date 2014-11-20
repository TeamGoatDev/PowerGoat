# Script  : Script de Configuration
# Objet   : Permet de Configurer le serveur pour l'examen du 27 mai 2013
# Auteur  : Team G.O.A.T. aka Julien, Arnaud, Xavier, Jean-William, Alex Bouffard, (Alex Tessier)
# Date    : 8 mai 2013
# Version : 1.0
# State	  : Finished


#//////////////////////////////////////////////////////////////////////////
# ÉLÉMENTS DE GUI
#/////////////////////////////////////////////////////////////////////////
function ErrorBox([string]$Message="Message")
{
	$Message = "Fatal Error:`n" + $Message
	$box = [System.Windows.Forms.MessageBox]::Show($Message, "G.O.A.T Team Message: ERROR", [Windows.Forms.MessageBoxButtons]::OK, [Windows.Forms.MessageBoxIcon]::Error)
	return $box
}

function InformationBox([string]$Message="Message")
{
	$box = [System.Windows.Forms.MessageBox]::Show($Message, "G.O.A.T Team Message", [Windows.Forms.MessageBoxButtons]::OK, [Windows.Forms.MessageBoxIcon]::Information)
	return $box
}

function YesNoBox([string]$Message="Message")
{
	$box = [System.Windows.Forms.MessageBox]::Show($Message, "G.O.A.T Team Message", [Windows.Forms.MessageBoxButtons]::YesNo, [Windows.Forms.MessageBoxIcon]::Question)
	return $box
}


$global:OUTPUT = "Output"


#FENETRE DE PROGRESSION #######################################################################################
		#Importation des ressources GUI pour la fenêtre de progression.
		[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
		[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

		# Initialisation de la Fênetre
		$Window        = New-Object System.Windows.Forms.Form
		$Window.width  = 450
		$Window.height = 400
		$Window.Text   = "Setup Progress"

		# Initialisation de la ProgressBar
		$pgrBar		  = New-Object System.Windows.Forms.ProgressBar
		$pgrBar.Maximum  = 100
		$pgrBar.Minimum  = 0
		$pgrBar.Location = new-object System.Drawing.Size(10,10)
		$pgrBar.size     = new-object System.Drawing.Size(425,20)
		$i = 0
		$Window.Controls.Add($pgrBar)

		# Initialisation du Button
		$btnDemarrer 		  = new-object System.Windows.Forms.Button
		$btnDemarrer.Location = new-object System.Drawing.Size(122,55)
		$btnDemarrer.Size 	  = new-object System.Drawing.Size(200,30)
		$btnDemarrer.Text 	  = "Démarrer la configuration"
		$Window.Controls.Add($btnDemarrer)
		
		# Initialisation du Pourcentage TextLabel
		$PourcentageLabel 		   = new-object System.Windows.Forms.Label
		$PourcentageLabel.Location = new-object System.Drawing.Size(200,35)
		$PourcentageLabel.Size	   = new-object System.Drawing.Size(200,30)
		$PourcentageLabel.Text	   = "Pourcentage" #Pourcentage
		$Window.Controls.Add($PourcentageLabel)
		
		############################################## Début outputbox 

		$global:OUTPUTBox			 = New-Object System.Windows.Forms.RichTextBox
		$global:OUTPUTBox.Location  = New-Object System.Drawing.Size(10,110) 
		$global:OUTPUTBox.Size 	 = New-Object System.Drawing.Size(425,250) 
		$global:OUTPUTBox.MultiLine = $True 
		
		$global:OUTPUTBox.ScrollBars = "Vertical" 
		$Window.Controls.Add($global:OUTPUTBox) 

		############################################## Fin outputbox 





		# Button Click Event to Run ProgressBar
		$btnDemarrer.Add_Click({
		    #Should Call the main function
			main
		    while ($i -le 100) {
				
		        $pgrBar.Value = $i
		        Start-Sleep -m 10
		        $i
				$PourcentageLabel.Text	   = $i #Pourcentage
				$global:OUTPUTbox.Text = $global:OUTPUTbox.Text + "`n" + ($pgrBar.Value) + "%"
				$global:OUTPUTBox.Text = ($global:OUTPUTBox.Text +"  ==> " + $global:OUTPUT)
				$global:OUTPUTbox.SelectionStart = $global:OUTPUTbox.Text.Length
				$global:OUTPUTbox.ScrollToCaret()
		        $i += 1
		    }
		})


		
		
		
		
		
		
		# Show Form
		$Window.Add_Shown({$Window.Activate()})
		$Window.ShowDialog()

# FIN DE LA FENETRE DE PROGRESSION ############################################################################


#//////////////////////////////////////////////////////////////////////////
# Log D'erreurs: 
#	Script créant un Log contenant toutes les erreurs ayant eu lieu durant 
#	la configuration du serveur.
#////////////////////////////////////////////////////////////////////////
$LogFile = "Output.log"
$LogFilePath = "C:\"
$CompletePath = $LogFilePath+$LogFile

#Returns true if the Log file exists false otherwise
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

function WriteToLog($FunctionName, $Message)
{
	CreateLog #Créer le Log si nécessaire

	Add-Content $CompletePath " " #endline
	Add-Content $CompletePath $FunctionName
	Add-Content $CompletePath $Message
}

#//////////////////////////////////////////////////////////////////////////
# Accesseur et Mutateur du nom de l'Ordinateur
#////////////////////////////////////////////////////////////////////////

function GetComputerName() #Retourne le nom de l'ordinateur
{
	try
	{
		return $NomOrdinateur = gc env:computername
		if(!$?){throw $error[0].Exception}
	}
	catch [Exception]
	{
		$CodeErreur = ("There was an error obtaining the name of the computer:`n`r" + $_.Exception.Message)
		WriteToLog "There was an error obtaining the name of the computer:`n`r" $_.Exception.Message
		ErrorBox($CodeErreur) 
	}
	
}

function GetComputerNumber() #Retourne le numero courant du poste
{
	try
	{
		$NomOrdinateur 	  = GetComputerName
		if(!$?){throw $error[0].Exception}
		$NumeroOrdinateur = $NomOrdinateur.substring(6)
		if(!$?){throw $error[0].Exception}
		return $NumeroOrdinateur
	 }
	 catch [Exception]
	{
		$CodeErreur = ("There was an error obtaining the number of the computer:`n`r" + $_.Exception.Message)
		WriteToLog "There was an error obtaining the number of the computer:`n`r" $_.Exception.Message
		ErrorBox($CodeErreur) 
	}
	 
	 
	 
	 
}


function SetComputerName() #Permet d'attribuer un nouveau nom à l'ordinateur
{
	try
	{
		#Renommage
		$ComputerName = Get-WmiObject Win32_ComputerSystem
		if(!$?){throw $error[0].Exception}
		
		#Load le module pour les GUI
		[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null 
		if(!$?){throw $error[0].Exception}
		
		#Prompt le User avec une GUI
		$name = [Microsoft.VisualBasic.Interaction]::InputBox("Entrer le nom d'ordinateur désiré")
		$ComputerName.Rename($name)
		if(!$?){throw $error[0].Exception}
		
		#Redémarrage
		$Choice = YesNoBox("Voulez-vous redémarrer pour que les changements prennent effet? (oui/non)")
		if(!$?){throw $error[0].Exception}
		
		if($Choice -eq [Windows.Forms.DialogResult]::Yes)
		{
			restart-Computer
			if(!$?){throw $error[0].Exception}
		}
		if(!$?){throw $error[0].Exception}
		
		InformationBox("The Name of The Computer Has been changed sucessfully!")
	}
	catch [Exception]
	{
		$CodeErreur = ("There was an error trying to change the name of the computer!" + $_.Exception.Message)
		WriteToLog "There was an error trying to change the name of the computer!" $_.Exception.Message
		ErrorBox($CodeErreur) 
	}
	
}

#//////////////////////////////////////////////////////////////////////////
# INSTALLATION DU MODULE LOCAL ACCOUNTS
#/////////////////////////////////////////////////////////////////////////
function InstallLocalAccounts() #Gère l'installation du Module LocalAccounts, les fichiers du module doivent se trouver ;a la racine du J:\
{
	try
	{
		#%PSModulePath% == "C:\Windows\System32\WindowsPowerShell\v1.0\Modules\"
		New-Item  -Name "LocalAccounts" -Path "C:\Windows\System32\WindowsPowerShell\v1.0\Modules\" -Type "Directory"
		if(!$?){throw $error[0].Exception}
		
		Copy-Item "J:\LocalAccounts\*"  "C:\Windows\System32\WindowsPowerShell\v1.0\Modules\LocalAccounts"
		if(!$?){throw $error[0].Exception}
		
		InformationBox("Local Account Module for Powershell has been installed successfully!")
		if(!$?){throw $error[0].Exception}
	}
	catch [Exception]
	{
		$CodeErreur = ("There was an error during the Installation of Local Accounts Module!`n`r" + $_.Exception.Message)
		WriteToLog "There was an error during the Installation of Local Accounts Module!`n`r" $_.Exception.Message
		ErrorBox($CodeErreur) 
	}
}

import-module LocalAccounts #Module Utile à la fonction CreateUser
#//////////////////////////////////////////////////////////////////////////
# CRÉATION DES UTILISATEURS
#/////////////////////////////////////////////////////////////////////////
function CreateUser()
{
	try
	{
		New-LocalUser -Name Daniel -Fullname Daniel -Password AAAaaa111 -PasswordNeverExpire 
		New-LocalUser -Name Denise -Fullname Denise -Password AAAaaa111 -PasswordNeverExpire 
		New-LocalUser -Name Henri -Fullname Henri -Password AAAaaa111 -PasswordNeverExpire -IsDisabled 
		New-LocalUser -Name Marc -Fullname Marc -Password AAAaaa111 -PasswordNeverExpire
		New-LocalUser -Name Pierre -Fullname Pierre -Password AAAaaa111 -PasswordNeverExpire
		New-LocalUser -Name Samuel -Fullname Samuel -Password AAAaaa111 -PasswordNeverExpire
		if(!$?){throw $error[0].Exception}
		
		#Création des groupes
		New-LocalGroup -Name gCAISSIERS 
		New-LocalGroup -Name gVENDEURS
		if(!$?){throw $error[0].Exception}
		
		#Ajout d'utilisateurs au groupe gCAISSIERS
		$user = Get-LocalUser -Name Daniel
		Get-LocalGroup -Name gCAISSIERS | Add-LocalGroupMember -Members $user
		$user = Get-LocalUser -Name Denise
		Get-LocalGroup -Name gCAISSIERS | Add-LocalGroupMember -Members $user
		$user = Get-LocalUser -Name Henri
		Get-LocalGroup -Name gCAISSIERS | Add-LocalGroupMember -Members $user
		if(!$?){throw $error[0].Exception}
		
		
		#Ajout d'utilisateurs au groupe gVENDEURS
		$user = Get-LocalUser -Name Marc
		Get-LocalGroup -Name gVENDEURS | Add-LocalGroupMember -Members $user
		$user = Get-LocalUser -Name Pierre
		Get-LocalGroup -Name gVENDEURS | Add-LocalGroupMember -Members $user
		$user = Get-LocalUser -Name Samuel
		Get-LocalGroup -Name gVENDEURS | Add-LocalGroupMember -Members $user
		if(!$?){throw $error[0].Exception}
		
		#Ajout d'utilisateurs au groupe Administrateurs
		$user = Get-LocalUser -Name Denise
		Get-LocalGroup -Name Administrateurs | Add-LocalGroupMember -Members $user
		$user = Get-LocalUser -Name Marc
		Get-LocalGroup -Name Administrateurs | Add-LocalGroupMember -Members $user
		if(!$?){throw $error[0].Exception}
		
		InformationBox("Directory Structure Sucessfully created!")
	}
	catch [Exception]
	{
		$CodeErreur = ("There was an error creating the users and groups:" + $_.Exception.Message)
		WriteToLog "There was an error creating the users and groups:" $_.Exception.Message
		ErrorBox($CodeErreur) 
	}
	
	
	
	
	
}

#//////////////////////////////////////////////////////////////////////////
# CRÉATION DE LA STRUCTURE DE RÉPERTOIRE
#/////////////////////////////////////////////////////////////////////////

function CreationStructureDossier()
{
	try
	{
		$NumeroOrdinateur = GetComputerNumber
	 	if(!$?){throw $error[0].Exception}
		
		$caissier = "_$NumeroOrdinateur"+"Caissiers"
		$general  = "_$NumeroOrdinateur"+"General"
		$remise	  = "_$NumeroOrdinateur"+"Remise"
		if(!$?){throw $error[0].Exception}
		
		new-item -path c:\ -name $caissier -type directory
		new-item -path c:\ -name $general -type directory
		new-item -path ("c:\"+ $general) -name Caissiers -type directory
		new-item -path ("c:\"+ $general) -name Documentation -type directory
		new-item -path ("c:\"+ $general) -name Vendeurs -type directory
		new-item -path c:\ -name $remise -type directory
		if(!$?){throw $error[0].Exception}
	}
	catch [Exception]
	{	
		$CodeErreur = ("There was an error creating the Directory structure:" + $_.Exception.Message)
		WriteToLog "There was an error creating the Directory structure:" $_.Exception.Message
		ErrorBox($CodeErreur)
	
	}
	$global:OUTPUT = "Directory structure created successfuly!"
}

#//////////////////////////////////////////////////////////////////////////
# GESTION DES DROITS NTFS
#/////////////////////////////////////////////////////////////////////////
function NTFS()
{
	try
	{
		#Numero d'ordinateur
		$NumeroOrdinateur = GetComputerNumber
		
		#Location
		$c = "c:\_"
			
		#Nom de folder
		$Caissiers = "Caissiers"
		$Remise = "Remise"
		$General = "General"
			
		$folder1 = $c + $NumeroOrdinateur + $Caissiers
		$folder2 = $c + $NumeroOrdinateur + $Remise
		$folder3 = $c + $NumeroOrdinateur + $General
		Write-Host $folder1

		#Remove NTFS Permissions
		ICACLS $folder1 /inheritance:r 
		ICACLS $folder2 /inheritance:r 
		ICACLS $folder3 /inheritance:r 
		if(!$?){throw $error[0].Exception}
		
		#Droits Système et Administrateurs
		ICACLS $folder1 /grant "Administrateurs"":(OI)(CI)F"
		ICACLS $folder1 /grant "Système"":(OI)(CI)F"
		if(!$?){throw $error[0].Exception}
			
		
		ICACLS $folder2 /grant "Administrateurs"":(OI)(CI)F"
		ICACLS $folder2 /grant "Système"":(OI)(CI)F"
		if(!$?){throw $error[0].Exception}
		
		
		ICACLS $folder3 /grant "Administrateurs"":(OI)(CI)F"
		ICACLS $folder3 /grant "Système"":(OI)(CI)F"
		if(!$?){throw $error[0].Exception}
		
		
		#Autorisations sur Caissiers
		ICACLS $folder1 /grant "Daniel"":(OI)(CI)M"
		ICACLS $folder1 /grant "Denise"":(OI)(CI)M"
		ICACLS $folder1 /grant "Henri"":(OI)(CI)M"
		if(!$?){throw $error[0].Exception}
		
		#Autorisations sur Remise
		ICACLS $folder2 /grant "Utilisateurs"":(OI)(CI)M"
		if(!$?){throw $error[0].Exception}
		
		#Autorisations sur Général
		ICACLS $folder3 /grant "Utilisateurs"":(OI)(CI)(R,W)"
		if(!$?){throw $error[0].Exception}
		
		$GeneralDocumentation = "\Documentation"
		$GeneralCaissiers = "\Caissiers"
		$GeneralVendeurs = "\Vendeurs"
		
		$sousfolder1 = $folder3 + $GeneralDocumentation
		$sousfolder2 = $folder3 + $GeneralCaissiers
		$sousfolder3 = $folder3 + $GeneralVendeurs
		
			#Autorisations sur Documentation
			ICACLS $sousfolder1 /inheritance:r 
			ICACLS $sousfolder1 /grant "Utilisateurs"":(OI)(CI)RX"
			ICACLS $sousfolder1 /grant "Administrateurs"":(OI)(CI)F"
			ICACLS $sousfolder1 /grant "Système"":(OI)(CI)F"
			if(!$?){throw $error[0].Exception}
			
			#Autorisations sur Caissiers
			ICACLS $sousfolder2 /inheritance:r 
			ICACLS $sousfolder2 /grant "Administrateurs"":(OI)(CI)F"
			ICACLS $sousfolder2 /grant "Système"":(OI)(CI)F"
			ICACLS $sousfolder2 /grant "Daniel"":(OI)(CI)M"
			ICACLS $sousfolder2 /grant "Denise"":(OI)(CI)M"
			ICACLS $sousfolder2 /grant "Henri"":(OI)(CI)M"
			if(!$?){throw $error[0].Exception}
			
			#Autorisations sur Vendeurs
			ICACLS $sousfolder3 /inheritance:r 
			ICACLS $sousfolder3 /grant "Administrateurs"":(OI)(CI)F"
			ICACLS $sousfolder3 /grant "Système"":(OI)(CI)F"
			ICACLS $sousfolder3 /grant "Samuel"":(OI)(CI)M"
			ICACLS $sousfolder3 /grant "Pierre"":(OI)(CI)M"
			ICACLS $sousfolder3 /grant "Marc"":(OI)(CI)M"
			if(!$?){throw $error[0].Exception}
	}
	catch [Exception]
	{
		$CodeErreur = ("There was an error Attributing the NTFS rights:" + $_.Exception.Message)
		WriteToLog "There was an error Attributing the NTFS rights:" $_.Exception.Message
		ErrorBox($CodeErreur) 
	}
	
	
	
	
}

#//////////////////////////////////////////////////////////////////////////
# GESTIONS DES PARTAGES
#//////////////////////////////////////////////////////////////////////////

function Partages()
{
	try 
	{
		#Numero d'ordinateur
		$NumeroOrdinateur = GetComputerNumber
		
		#Location
		$c = "c:\_"
			
		#Nom de folder
		$Caissiers = "Caissiers"
		$Remise = "Remise"
		$General = "General"
			
		$folder1 = $c + $NumeroOrdinateur + $Caissiers
		$folder2 = $c + $NumeroOrdinateur + $Remise
		$folder3 = $c + $NumeroOrdinateur + $General
			
		NET SHARE Caissiers=$folder1 "/GRANT:Tout Le Monde,FULL" /cache:none
		NET SHARE Remise$=$folder2 "/GRANT:Tout Le Monde,FULL" /cache:none
		NET SHARE Corpo$=$folder3 "/GRANT:Tout Le Monde,FULL" /cache:none /users:1
		if(!$?){throw $error[0].Exception}
	}
	catch [Exception]
	{
		$CodeErreur = ("There was an error creating the Sharings:" + $_.Exception.Message)
		WriteToLog "There was an error creating the Sharings:" $_.Exception.Message
		ErrorBox($CodeErreur) 
	}
	
	
	
}

#//////////////////////////////////////////////////////////////////////////
# DÉMONTAGE DE PARTITION
#//////////////////////////////////////////////////////////////////////////

function UnmountPart() #Il y a un prompt
{
	
		do
		{
			try
			{

				$Lecteur  = Read-Host "Entrer le nom du lecteur à démonter (mettre les : après le nom de lecteur ex: `"C:`"), pour terminter taper «exit»"
				Write-Host $Lecteur
				if($Lecteur -eq "C:" -or $Lecteur -eq "c:")
				{
					ErrorBox("WTF Bro?!")
					ErrorBox("Noooooon!")
					ErrorBox("Tu peux juste pas faire ça!!!")
					ErrorBox("T'es con ou quoi?!!! O.o")
					ErrorBox("Si tu m'refais ça jm'AUTO DELETE au complet!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
					ErrorBox("J'ai un KILL.BAT INTÉGRÉ MOTHERFUCKER!!!!!")
				}
				elseif ($Lecteur -eq "exit")
				{
				
				}
				else
				{
					$Commande = "mountvol " + $Lecteur + " /D" 
					Invoke-Expression $Commande
					if(!$?){throw $error[0].Exception}
				}
				if(!$?){throw $error[0].Exception}
			}
			catch [Exception]
			{
				WriteToLog "There was an error during the Unmounting of Partition!" $_.Exception.Message
				InformationBox("There was an error during the Unmounting of Partition!")
			}
		}
		while($Lecteur -ne "exit")
		$global:OUTPUT = "Unmounting of PArtition was a Success"
}


#//////////////////////////////////////////////////////////////////////////
# CONFIGURATION DE LA CMD
#//////////////////////////////////////////////////////////////////////////

function CMDConfig()
{
	
	$RegKey ="HKCU:\Software\Microsoft\Command Processor"
	Set-ItemProperty -path $RegKey -name DefaultColor -value "0x1E"
	$global:OUTPUT = "CMD Color Success!"
	informationBox($global:OUTPUT)
	
	
}



function main()
{
    
	CMDConfig
	InformationBox("N'oubliez surtout pas de changer le nom de votre ordi et de REDÉMARRER!! Sinon le reste du script va fuck!")
    
    InformationBox("Ok! Préparez-vous au Démontage de partition, pour quitter le démontage TAPER EXIT!!!!")
    UnmountPart
    
    
    
    InformationBox("Ok! Maintenant On Installe LocalAccounts faut que le fichier LocalAccounts soit à la racine du J: !!!")
    InstallLocalAccounts
    
    InformationBox("On va lancer la création des Utilisateurs")
    CreateUser
    
    InformationBox("C'est partit pour la création de la structure de dossier!")
    CreationStructureDossier
    
    InformationBox("On se tape les NTFS")
    NTFS
    
    InformationBox("là c'est les Partage")
    Partages
    
    InformationBox("Damn!! On a fini! OUBLIEZ PAS DE REGARDER LE LOG D'ERREUR POUR VÉRIFIER SI TOUT C'EST PASSÉ!")
    InformationBox("Le LOG se nome Output.log il est dans le C:")
    
    InformationBox("Je répète juste au cas où: Le LOG se nome Output.log il est dans le C:")
    
}




















