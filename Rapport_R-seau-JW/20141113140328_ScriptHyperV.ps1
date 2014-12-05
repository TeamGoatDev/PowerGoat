#################################################
# TITRE: R2 Script HyperV
#
# AUTEUR: Jean-William Perreault
#
# DATE: 13 novembere 2014
#
# OBJECTIF: Renommer les cartes réseaux
# après l'installation du
#
# SERVERUR D'ÉXÉCUTION: SERVEUR RÉEL
#
#################################################

# RENOMMER CARTE APRÈS HYPER-V
$hyperV = Get-WindowsFeature -Name Hyper-V
if($hyperV -eq $true){

    $cardName_1 = "Ext"
    $newCardName_1 = "Ext Gestion"

    $cardName_2 = "vEthernet"
    $newCardName_2 = "Ext Config"


    Rename-NetAdapter -Name $cardName_1  -NewName $newCardName_1
    Rename-NetAdapter -Name $cardName_2 -NewName $newCardName_2

}



# CRÉATION COMMUTATEUR VIRTUEL PRIVÉ 

New-VMSwitch -Name "ResPrivé" -SwitchType Private

# CRÉATION DOSSIER
New-Item C:\_VirOrdi -type directory

# MODIFICATION CHEMIN DOSSIER ORDINATEURS VIRTUELS ET DISQUES DURS VIRTUELS
Set-VmHost -VirtualHardDiskPath "C:\_VirDisque" -VirtualMachinePath "C:\_VirOrdi"