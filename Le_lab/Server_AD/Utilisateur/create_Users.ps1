# Importer les données
$CSVFile = "C:\Users\Administrator\Downloads\s01_Pharmgreen.xlsx - Feuille 1.csv"
$CSVData = Import-CSV -Path $CSVFile -Delimiter ","

# Boucle pour parcourir les lignes CSV
 Foreach($Utilisateur in $CSVData){

# Création de variable pour remplir les champs lors de la création des utilisateurs

  $UtilisateurPrenom = $Utilisateur.Prenom
  $UtilisateurNom = $Utilisateur.Nom
  $UtilisateurLogin = $UtilisateurNom.Replace(" ",".").ToLower() + "." + ($UtilisateurPrenom).Substring(0,1).Replace(" ",".").ToLower()
  $UtilisateurEmail = "$UtilisateurLogin@Pharmgreen.com"
  $UtilisateurMotDePasse = "P@ssword123456789"
  $UtilisateurFonction = $Utilisateur.fonction
  $UtilisateurDepartement = $Utilisateur.Département
  $UtilisateurManager = $Utilisateur.Managernom

# Vérification si l'utilisateur a déjà été créé

  if (Get-ADUser -Filter {SamAccountName -eq $UtilisateurLogin})
  { 
      Write-Warning "L'identifiant $UtilisateurLogin existe déjà dans l'AD"
  }
  else
  {

  #Création de chaque utilisateur avec les variables
  
      New-ADUser -Name "$UtilisateurNom $UtilisateurPrenom" `
                 -DisplayName "$UtilisateurNom $UtilisateurPrenom" `
                 -GivenName "$UtilisateurPrenom" `
                 -Surname $UtilisateurNom `
                 -SamAccountName $UtilisateurLogin `
                 -UserPrincipalName "$UtilisateurLogin@Pharmgreen.com" `
                 -EmailAddress $UtilisateurEmail `
                 -Title $UtilisateurFonction `
                 -Path "OU=$UtilisateurDepartement,OU=Utilisateurs,DC=Pharmgreen,DC=com" `
                 -AccountPassword(ConvertTo-SecureString $UtilisateurMotDePasse -AsPlainText -Force) `
                 -ChangePasswordAtLogon $true `
                 -Enabled $true 
}
}
