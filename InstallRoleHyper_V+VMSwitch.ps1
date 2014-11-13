########################################################
#author: Xavier Hudon-Dansereau
#2.Installation du r�le Hyper-V
#
#
#
########################################################

#2.1 Setup de Hyper-V
Function setupHyperV
{
    try
    {
            Install-WindowsFeature �Name Hyper-V -IncludeManagementTools -Restart
            if(!$?){throw $Error[0].Exception}
    }
    catch [Exception]
    {
        $codeError = ("L'installation de Hyper-V a foir�"+$_.Exception.Message)
        writeToLog "L'installation de Hyper-V a foir�" $_.Exception.Message
    }
}

#2.2 Cr�ation de l'outils d'administration pour Hyper-V
Function setupAdminTool()
{
    try
    {
        Add-WindowsFeature RSAT-Hyper-V-Tools -IncludeAllSubFeature
        if(!$?){throw $Error[0].Exception}
    }
    catch [Exception]
    {
        $codeError = ("L'installation des Outils d'administration Hyper-V a foir�"+$_.Exception.Message)
        writeToLog "L'installation des Outils d'administration Hyper-V a foir�" $_.Exception.Message
    }
}

#2.3  Cr�ation des commutateurs virtuels
Function setupVMSwitch()
{
    try
    {
        New-VMSwitch -Name ResPublic -NetAdapterName Ext -AllowManagementOS $true
        if(!$?){throw $Error[0].Exception}
    }
    catch [Exception]
    {
        $codeError = ("L'installation de la switch virtuel a foir�"+$_.Exception.Message)
        writeToLog "L'installation de la switch virtuel a foir�" $_.Exception.Message
    }
}



#Pour les tests
Function writeToLog($var1,$var2)
{
    echo $var1
    echo $var2
}

#Important: � ajouter dans le main
Function main()
{
    if((Get-WindowsFeature -Name Hyper-V).Installed -eq $false)
    {
        setupHyperV
    }
    else
    {
        "Hyper-V est d�j� install�!"
        setupAdminTool
        setupVMSwitch
    }
}


main