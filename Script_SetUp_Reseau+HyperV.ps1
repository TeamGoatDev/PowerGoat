# 1 - Fonction qui set up le serveur réel au départ
function setUpSVRInitial()
{

    $computerName = Get-WmiObject Win32_ComputerSystem
    $name = Read-Host "Nom d'ordinateur desiré (Ex : 529R15)"

    #Rename des cartes réseau
    Rename-NetAdapter -Name "Ethernet 2" -NewName "NonUtilisée"
    Rename-NetAdapter -Name "Ethernet" -NewName "Ext"

    #Rename de la station
    $computerName.Rename($name)

    #Restart-Computer

    ncpa.cpl

}

# 3 - Fonction qui set up le serveur réel après l'installation de HyperV
function setUpSVRPostHyperV()
{
    #Rename de la carte Ext et du commutateur
    Rename-NetAdapter -Name "Ext" -NewName "Ext gestion"
    Rename-NetAdapter -Name "vEthernet (ResPublic)" -NewName "Ext Config"

    #Creation du commutateur ResPrive
    New-VMSwitch -Name ResPrive -SwitchType Private

    #Creation du folder C:\_VirOrdi
    New-Item -Path C:\_VirOrdi -type directory

    $computerName = Get-WmiObject Win32_ComputerSystem

    #Set Up du folder d'ordinateur virtuel
    Set-VMHost -VirtualHardDiskPath C:\_VirDisque -VirtualMachinePath C:\_VirOrdi

    #Affiche les commutateurs
    Get-VMSwitch
}

# 5 - Changer les paramètres de mémoire d'Hyper-V
function setUpMemoireHyperV()
{
    Set-VMMemory -VMName Serveur1 -DynamicMemoryEnabled $true -MinimumBytes 1GB -MaximumBytes 2GB
}

#Add-WindowsFeature RSAT-Hyper-V-Tools -IncludeAllSubFeature
#Get-Command -Module Hyper-V

#Set-VMMemory -VMName Serveur1 -DynamicMemoryEnabled $true -MinimumBytes 1GB -MaximumBytes 2GB
#Set-VMBios -VMName Serveur1 -StartupOrder @("IDE","LegacyNetworkAdapter","CD","Floppy")

