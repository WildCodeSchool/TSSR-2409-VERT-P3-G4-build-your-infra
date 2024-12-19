## 1 USER GUIDE SCRIPT CREATION OU "Create_OU.ps1"

## Introduction

Ce script PowerShell permet de créer des **unités organisationnelles (OU)** dans Active Directory de manière automatisée, en utilisant des informations provenant d'un fichier CSV. Il peut également être adapté pour répondre à une variété de besoins en matière de gestion des OUs dans un environnement Active Directory.

## Fonctionnalités du Script

1. **Création des OUs à partir d'un fichier CSV** : Le script lit un fichier CSV contenant des informations sur des départements ou d'autres types d'unités (ex. services, départements) et crée des OUs correspondantes dans Active Directory.
2. **Vérification et création d'un OU parent** : Le script vérifie si l'OU parent (par exemple, `Departments`) existe déjà. Si elle n'existe pas, elle sera automatiquement créée avant la création des OUs pour chaque département.
3. **Suppression de la protection contre la suppression accidentelle** : Une fois qu'une OU est créée, le script désactive la protection contre la suppression accidentelle de l'OU, ce qui permet une gestion plus souple des OUs.

## Adaptabilité du Script

Le script est conçu pour être facilement **adapté à différents cas d’utilisation** et peut être modifié pour répondre à vos besoins spécifiques.

### 1. Adaptation pour différents types d'unités organisationnelles
Le script peut être utilisé non seulement pour les départements, mais aussi pour d’autres types d’organisations comme des équipes, ou des services. Par exemple, au lieu de `Département`, vous pouvez utiliser une colonne intitulée **"Service"** ou **"Équipe"** dans votre fichier CSV.

**Exemple** : 
Au lieu de `Département`, remplacez-le par **"Service"** ou **"Équipe"** et ajustez le script pour qu’il prenne en compte cette colonne.

### 2. Modification du nom de l'OU parent
Par défaut, le script crée les OUs sous l'OU parent `Departments`. Vous pouvez facilement modifier cette valeur pour qu’elle corresponde à votre structure Active Directory.

**Exemple** :
Pour utiliser `Services` comme OU parent, modifiez cette ligne dans le script :
```powershell
$parentOU = "OU=Departments,DC=test,DC=lan"
```
en
```powershell
$parentOU = "OU=Services,DC=test,DC=lan"
```

### 3. Ajout ou modification des attributs des OUs
Si vous souhaitez ajouter des attributs spécifiques aux OUs lors de leur création (par exemple, description ou autres métadonnées), vous pouvez personnaliser le script pour inclure ces informations.

**Exemple pour ajouter une description** :
```powershell
New-ADOrganizationalUnit -Name $department -Path $parentOU -Description "OU pour le département $department"
```

### 4. Gestion des erreurs et validation
Le script contient déjà une gestion des erreurs pour les OUs qui ne peuvent pas être créées (en raison de noms invalides ou d’autres erreurs). Si nécessaire, vous pouvez personnaliser la gestion des erreurs en fonction de votre propre logique (par exemple, ignorer certaines erreurs, envoyer des notifications, etc.).


## Étapes de Personnalisation

1. **Préparer un fichier CSV adapté** :
   Le script utilise un fichier CSV avec des colonnes spécifiques, mais vous pouvez facilement ajuster le format du CSV selon vos besoins. Par exemple, vous pouvez ajouter des colonnes comme **"Service"**, **"Localisation"**, **"Responsable"**, etc., et adapter le script pour traiter ces informations.

   **Exemple de fichier CSV personnalisé** :
   ```csv
   Nom,Service,Responsable,Sous-division
   John,Développement,Marie,Backend
   Claire,Marketing,Paul,Publicité
   ```

2. **Modifier les paramètres du script** :
   - **Chemin du fichier CSV** : Assurez-vous de mettre à jour la variable `$csvPath` dans le script pour pointer vers le bon emplacement de votre fichier CSV sur votre système.
     ```powershell
     $csvPath = "C:\Path\To\VotreFichier.csv"
     ```

   - **Nom de l'OU parent** : Changez le chemin de l'OU parent dans la variable `$parentOU` pour correspondre à la structure Active Directory de votre organisation.
     ```powershell
     $parentOU = "OU=Services,DC=monDomaine,DC=com"
     ```

## Exemple de Personnalisation du Script

Supposons que vous souhaitiez créer des OUs sous un OU parent nommé `Projects`, ajouter une description à chaque OU, et gérer des erreurs spécifiques. Voici comment vous pourriez adapter le script :

```powershell
# Modifier le chemin de l'OU parent
$parentOU = "OU=Projects,DC=monDomaine,DC=com"

# Créer les OUs avec une description
foreach ($department in $departments) {
    # Nettoyer le nom du département
    $department = Remove-InvalidCharacters -input $department

    # Vérifier si l'OU existe déjà
    $newOUDN = "OU=$department,$parentOU"
    if (Get-ADOrganizationalUnit -Filter { DistinguishedName -eq $newOUDN } -ErrorAction SilentlyContinue) {
        Write-Host "L'OU '$department' existe déjà sous '$parentOU'."
    } else {
        try {
            # Créer l'OU avec une description personnalisée
            New-ADOrganizationalUnit -Name $department -Path $parentOU -Description "OU pour le projet $department"
            Write-Host "OU '$department' créée sous '$parentOU' avec succès."
        }
        catch {
            Write-Error "Erreur lors de la création de l'OU '$department'."
        }
    }
}
```

## Conclusion

Ce script est flexible et peut être facilement **adapté à différents besoins** pour la gestion des OUs dans Active Directory. Vous pouvez :
- **Modifier le nom de l'OU parent** en fonction de la structure de votre domaine.
- **Ajouter des attributs supplémentaires** (comme des descriptions) pour chaque OU.
- **Étendre la logique** pour effectuer des actions supplémentaires, comme l'attribution de permissions ou l'ajout d'utilisateurs dans les OUs.

En suivant ce guide, vous pourrez personnaliser ce script pour répondre aux exigences de votre organisation et l'intégrer facilement dans votre flux de travail quotidien.


## 2 USER GUIDE SCRIPT CREATION Utilisateur "Create_Users.ps1"

## Introduction

Ce script permet de créer des utilisateurs dans un activive directory grâce a un fichier csv

## Fonctionnalités du Script

1. **Création des utilsateurs à partir d'un fichier CSV** : Le script recupère les différentes informations pour pouvoir créer les utilisateurs et les placer dans les différents services.
2. **Vérification et création de chaque utilisateur** : Le script vérifie si l'utilisateur existe déjà. S'il n'existe pas, le script crée l'utilisateur avec les différents paramétres définis puis passe au suivant.
3. **Demande de changement de mot de passe** : Une fois qu'un compte utilsateur est créé, l'utilsateur devra rentrer ces identifiants et changer le mot de passe .

