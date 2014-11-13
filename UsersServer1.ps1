function SetUpServeur1
{
    #Creation des utilisateurs
    NET USER "Pierre Kiroule" "AAAaaa111" /ADD
    NET USER "Jean Revien" "AAAaaa111" /ADD
    NET USER "Guy Tard" "AAAaaa111" /ADD

    #Affiche les utilisateur membres du groupe Utilisateurs
    NET LOCALGROUP "Utilisateurs"

    #Configuration du CMD
    Set-ItemProperty –path “HKCU:\Console” –name ScreenColors –value 0F
    Set-ItemProperty –path “HKCU:\Console” –name QuickEdit –value 1

    #Il faut Set-Up le buffer size manuelement dans les propriétés du CMD
    "N'oubliez pas de changer la grosseur du buffer du CMD 800 x 3000"
}




