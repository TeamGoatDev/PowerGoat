#Nom : Xavier Hudon-Dansereau
#But de ce script : Mise en place des éléments nécéssaire à la création du serveur ftp et WEB
#Ordinateur cible : Serveur 1

#Ajout d'addresse IP
New-NetIPAddress -IPAddress "10.57.154.113" -InterfaceAlias "Ext" -PrefixLength 16

#Création de users
net user "Jean" "AAAaaa111" /ADD
net user "Pierre" "AAAaaa111" /ADD
net user "Guy" "AAAaaa111" /ADD

#Check la création des users
net localgroup "Utilisateurs"

#Crée les dossiers
New-Item -Name "_WEB\Corpo" -Path "c:\" -type directory
New-Item -Name "Vendeur" -Path "c:\_WEB\" -type directory
New-Item -Name "Achat" -Path "c:\_WEB\" -type directory
New-Item -Name "ww1" -Path "c:\_WEB\" -type directory
New-Item -Name "ww2" -Path "c:\_WEB\" -type directory
New-Item -Name "_WEBA1" -Path "c:\" -type directory
New-Item -Name "_WEBA2" -Path "c:\" -type directory

New-Item -Name "_FTP\Public" -Path "c:\" -type directory
New-Item -Name "doc.txt" -Path "c:\_FTP\Public\" -type file

New-Item -Name "Intranet\Pierre" -Path "c:\_FTP\" -type directory
New-Item -Name "Jean" -Path "c:\_FTP\Intranet\" -type directory
New-Item -Name "Default" -Path "c:\_FTP\Intranet\" -type directory

New-Item -Name "_FTP\Perso\LocalUser\Administrateur" -Path "c:\" -type directory
New-Item -Name "Guy" -Path "c:\_FTP\Perso\LocalUser\" -type directory
New-Item -Name "Jean" -Path "c:\_FTP\Perso\LocalUser\" -type directory
New-Item -Name "Public" -Path "c:\_FTP\Perso\LocalUser\" -type directory

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

ICACLS "c:\_FTP\Perso" /grant "Administrateurs:(OI)(CI)F"
ICACLS "c:\_FTP\Perso" /grant "Système:(OI)(CI)F"
ICACLS "c:\_FTP\Perso" /grant "Utilisateurs:RX"

ICACLS "c:\_FTP\Perso\LocalUser\Jean" /grant "Jean Revien:M"
ICACLS "c:\_FTP\Perso\LocalUser\Guy" /grant "Guy Tard:M"