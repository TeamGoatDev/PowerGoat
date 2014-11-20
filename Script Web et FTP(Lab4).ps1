#Nom : Xavier Hudon-Dansereau
#But de ce script : Mise en place des éléments nécéssaire à la création du serveur ftp et WEB
#Ordinateur cible : Serveur 1

#Ajout d'addresse IP
New-NetIPAddress -IPAddress "10.57.154.113" -InterfaceAlias "Ext" -PrefixLength 16

#Création de users
net user "Jean Revien" "AAAaaa111" /ADD
net user "Pierre Kiroule" "AAAaaa111" /ADD
net user "Guy Tard" "AAAaaa111" /ADD

#Check la création des users
net localgroup "Utilisateurs"

#Crée les dossiers
New-Item -Name "_WEB" -Path "c:\" -type directory
New-Item -Name "_WEBA1" -Path "c:\" -type directory
New-Item -Name "_WEBA2" -Path "c:\" -type directory

New-Item -Name "_FTP\Public" -Path "c:\" -type directory
New-Item -Name "doc.txt" -Path "c:\_FTP\Public\" -type file

New-Item -Name "_FTP\Intranet\Pierre" -Path "c:\" -type directory
New-Item -Name "_FTP\Intranet\Jean" -Path "c:\" -type directory
New-Item -Name "_FTP\Intranet\Default" -Path "c:\" -type directory

New-Item -Name "_FTP\Perso\LocalUser\Administrateur" -Path "c:\" -type directory
New-Item -Name "_FTP\Perso\LocalUser\Guy" -Path "c:\" -type directory
New-Item -Name "_FTP\Perso\LocalUser\Jean" -Path "c:\" -type directory
New-Item -Name "_FTP\Perso\LocalUser\Public" -Path "c:\" -type directory

#Remove NTFS Permissions
ICACLS "c:\_FTP" /inheritance:r

#Ajout de permission
ICACLS "c:\_FTP" /grant "Administrateurs:(OI)(CI)F"
ICACLS "c:\_FTP" /grant "Système:(OI)(CI)F"

ICACLS "c:\_FTP\Intranet" /grant "Administrateurs:(OI)(CI)F"
ICACLS "c:\_FTP\Intranet" /grant "Système:(OI)(CI)F"
ICACLS "c:\_FTP\Intranet" /grant "Utilisateurs:RX"

ICACLS "c:\_FTP\Intranet\Jean" /grant "Jean Revien:M"
ICACLS "c:\_FTP\Intranet\Pierre" /grant "Pierre Kiroule:M"
ICACLS "c:\_FTP\Intranet\Default" /grant "Default:M"

ICACLS "c:\_FTP\Perso" /grant "Administrateurs:(OI)(CI)F"
ICACLS "c:\_FTP\Perso" /grant "Système:(OI)(CI)F"
ICACLS "c:\_FTP\Perso" /grant "Utilisateurs:RX"

ICACLS "c:\_FTP\Perso\LocalUser\Jean" /grant "Jean Revien:M"
ICACLS "c:\_FTP\Perso\LocalUser\Guy" /grant "Guy Tard:M"
ICACLS "c:\_FTP\Perso\LocalUser\Public" /grant "Default:R"