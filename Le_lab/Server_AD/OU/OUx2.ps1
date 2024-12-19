# Importer le module Active Directory pour manipuler les objets dans l'AD
Import-Module ActiveDirectory

# Chemin vers votre fichier CSV contenant les départements et services => A adapter
$csvPath = "C:\Path\To\VotreFichier.csv"

# Vérifier si le fichier CSV existe
if (-Not (Test-Path $csvPath)) {
    Write-Error "Le fichier CSV n'existe pas à l'emplacement spécifié : $csvPath"
    exit
}

# Importer les données du fichier CSV
$data = Import-Csv -Path $csvPath

# Récupérer les listes uniques de départements et services
$departments = $data | Select-Object -ExpandProperty Département -Unique
$services = $data | Select-Object -ExpandProperty Service -Unique

# Spécifier les OUs parents pour les départements et services => A adapter à votre infrastructure AD DS
$departmentsParentOU = "OU=Departments,DC=test,DC=lan"
$servicesParentOU = "OU=Services,DC=test,DC=lan"

# Fonction pour vérifier et créer une OU parent si elle n'existe pas
function CreateParentOU {
    param (
        [string]$ouDN,  # Chemin distingué de l'OU
        [string]$ouName,  # Nom de l'OU
        [string]$parentPath  # Chemin du conteneur parent
    )

    # Vérifier si l'OU existe déjà
    if (-Not (Get-ADOrganizationalUnit -Filter { DistinguishedName -eq $ouDN } -ErrorAction SilentlyContinue)) {
        try {
            # Créer l'OU parent si elle n'existe pas
            New-ADOrganizationalUnit -Name $ouName -Path $parentPath -ErrorAction Stop
            Write-Host "L'OU parent '$ouName' créée avec succès."
        }
        catch {
            Write-Error "Erreur lors de la création de l'OU parent '$ouName'. Détails de l'erreur : $_"
        }
    } else {
        Write-Host "L'OU parent '$ouName' existe déjà."
    }
}

# Fonction pour désactiver la protection contre la suppression accidentelle sur une OU
function Remove-DeletionProtection {
    param ([string]$ouDN)  # Chemin distingué de l'OU

    try {
        # Désactiver la protection contre la suppression accidentelle
        Set-ADOrganizationalUnit -Identity $ouDN -ProtectedFromAccidentalDeletion $false
    }
    catch {
        Write-Warning "Impossible de supprimer la protection contre la suppression accidentelle pour l'OU '$ouDN'. Détails de l'erreur : $_"
    }
}

# Créer les OUs parents pour les départements et services si nécessaire
CreateParentOU -ouDN $departmentsParentOU -ouName "Departments" -parentPath "DC=test,DC=lan"
CreateParentOU -ouDN $servicesParentOU -ouName "Services" -parentPath "DC=test,DC=lan"

# Créer les OUs pour chaque département
foreach ($department in $departments) {
    Write-Host "Traitement du département : '$department'"

    # Vérifier que le nom du département n'est pas vide
    if ([string]::IsNullOrWhiteSpace($department)) {
        Write-Warning "Le département est vide, il sera ignoré."
        continue
    }

    # Construire le DN complet pour l'OU du département
    $newOUDN = "OU=$department,$departmentsParentOU"

    # Vérifier si l'OU existe déjà
    if (Get-ADOrganizationalUnit -Filter { DistinguishedName -eq $newOUDN } -ErrorAction SilentlyContinue) {
        Write-Host "L'OU '$department' existe déjà sous $departmentsParentOU."
    } else {
        try {
            # Créer l'OU pour le département
            New-ADOrganizationalUnit -Name $department -Path $departmentsParentOU -ErrorAction Stop
            Write-Host "OU '$department' créée avec succès sous '$departmentsParentOU'."

            # Supprimer la protection contre la suppression accidentelle
            Remove-DeletionProtection -ouDN $newOUDN
        }
        catch {
            Write-Error "Erreur lors de la création de l'OU '$department'. Détails de l'erreur : $_"
        }
    }
}

# Créer les OUs pour chaque service
foreach ($service in $services) {
    Write-Host "Traitement du service : '$service'"

    # Vérifier que le nom du service n'est pas vide
    if ([string]::IsNullOrWhiteSpace($service)) {
        Write-Warning "Le service est vide, il sera ignoré."
        continue
    }

    # Construire le DN complet pour l'OU du service
    $newOUDN = "OU=$service,$servicesParentOU"

    # Vérifier si l'OU existe déjà
    if (Get-ADOrganizationalUnit -Filter { DistinguishedName -eq $newOUDN } -ErrorAction SilentlyContinue) {
        Write-Host "L'OU '$service' existe déjà sous $servicesParentOU."
    } else {
        try {
            # Créer l'OU pour le service
            New-ADOrganizationalUnit -Name $service -Path $servicesParentOU -ErrorAction Stop
            Write-Host "OU '$service' créée avec succès sous '$servicesParentOU'."

            # Supprimer la protection contre la suppression accidentelle
            Remove-DeletionProtection -ouDN $newOUDN
        }
        catch {
            Write-Error "Erreur lors de la création de l'OU '$service'. Détails de l'erreur : $_"
        }
    }
}
