$hyperV = Get-WindowsFeature -Name Hyper-V

#Set-ExecutionPolicy Unrestricted

# Outils contrôle Hyper-V Powershell
#Add-WindowsFeature RSAT-Hyper-V-Tools –IncludeAllSubFeature



# CREATION MACHINE VIRTUALLE
$nom = "Serveur1"
$emplacement = "C:\_VirOrdi"
$memoire = 1024
$connexion = "Respublic"
$emplacementVHDX = "C:\_VirOrdi\Serv1.vhdx"
New-VM –Name $nom  –NewVHDPath $emplacementVHDX -NewVHDSizeBytes $memoire  -Generation 1 -Confirm -SwitchName "ResPublic"

