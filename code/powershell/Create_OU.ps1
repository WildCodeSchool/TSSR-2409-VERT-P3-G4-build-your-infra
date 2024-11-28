# Avant utilisation penser à : adapter le chemin du fichier csv, et adapter le / les DC en fonction de votre machine.

# Importer le module Active Directory
Import-Module ActiveDirectory

# Chemin vers votre fichier CSV => A adapter
$csvPath = "C:\Path\To\VotreFichier.csv"

# Vérifier si le fichier existe
if (-Not (Test-Path $csvPath)) {
    Write-Error "Le fichier CSV n'existe pas à l'emplacement spécifié : $csvPath"
    exit
}

# Importer les données du fichier CSV
$data = Import-Csv -Path $csvPath

# Récupérer les départements
$departments = $data | Select-Object -ExpandProperty Département -Unique

# Spécifiez l'OU parent => A adapter à l'AD DS
$parentOU = "OU=Departments,DC=test,DC=lan"

# Fonction pour vérifier et créer l'OU parent si elle n'existe pas
function CreateParentOU {
    param ([string]$ouDN)

    # Vérifier si l'OU parent existe déjà => adapter les DC
    if (-Not (Get-ADOrganizationalUnit -Filter { DistinguishedName -eq $ouDN } -ErrorAction SilentlyContinue)) {
        # Créer l'OU parent si elle n'existe pas
        try {
            New-ADOrganizationalUnit -Name "Departments" -Path "DC=test,DC=lan" -ErrorAction Stop
            Write-Host "L'OU parent 'Departments' créée avec succès."
        }
        catch {
            Write-Error "Erreur lors de la création de l'OU parent 'Departments'. Détails de l'erreur : $_"
        }
    } else {
        Write-Host "L'OU parent 'Departments' existe déjà."
    }
}

# Fonction pour supprimer la protection contre la suppression accidentelle => a supprimer pour le final ???
function Remove-DeletionProtection {
    param ([string]$ouDN)

    try {
        # Désactiver la protection contre la suppression accidentelle
        Set-ADOrganizationalUnit -Identity $ouDN -ProtectedFromAccidentalDeletion $false
            }
    catch {
        Write-Warning "Impossible de supprimer la protection contre la suppression accidentelle pour l'OU '$ouDN'. Détails de l'erreur : $_"
    }
}

# Créer l'OU parent si nécessaire
CreateParentOU -ouDN $parentOU

# Créer les OUs pour chaque département
foreach ($department in $departments) {
    # Afficher le département tel qu'il est dans le CSV
    Write-Host "Traitement du département : '$department'"

    # Vérifier que le nom n'est pas vide
    if ([string]::IsNullOrWhiteSpace($department)) {
        Write-Warning "Le département est vide, il sera ignoré."
        continue
    }

    # Construire le DN complet pour la nouvelle OU
    $newOUDN = "OU=$department,$parentOU"

    # Vérifier si l'OU existe déjà
    if (Get-ADOrganizationalUnit -Filter { DistinguishedName -eq $newOUDN } -ErrorAction SilentlyContinue) {
        Write-Host "L'OU '$department' existe déjà sous $parentOU."
    } else {
        # Tenter de créer la nouvelle OU et capturer les erreurs
        try {
            New-ADOrganizationalUnit -Name $department -Path $parentOU -ErrorAction Stop
            Write-Host "OU '$department' créée avec succès sous '$parentOU'."

            # Désactiver la protection contre la suppression accidentelle après la création
            Remove-DeletionProtection -ouDN $newOUDN
        }
        catch {
            Write-Error "Erreur lors de la création de l'OU '$department'. Détails de l'erreur : $_"
        }
    }
}

