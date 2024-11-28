## REDONDANCE
* ### 1) Script
* ### 2) Windows 2022 + rôles
* ### 3) windows Core + rôles
* ### 4) ADDS 
  * ### 4.1) OU et Groupes
  * ### 4.2) Utilisateurs
* ### 5) Debian


1) # INSTALL GUIDE SCRIPT CREATION OU "Create_OU.ps1"

## Prérequis

Avant d'exécuter le script, assurez-vous que votre environnement est correctement configuré et que les éléments suivants sont en place :

1. **PowerShell** : Le script est conçu pour être exécuté dans PowerShell, qui est installé par défaut sur les systèmes Windows.
2. **Module Active Directory** : Vous devez avoir installé le module `ActiveDirectory` pour interagir avec Active Directory via PowerShell. Ce module est disponible dans les **Outils d'Administration de Serveur (RSAT)**.
3. **Accès à Active Directory** : Vous devez disposer des droits d'administrateur pour créer des OUs et modifier les objets dans Active Directory.

## Étapes d'Installation du Script

### 1. Télécharger le Script

Téléchargez le script `Create-OU.ps1` et placez-le dans un répertoire accessible sur votre serveur ou votre machine Windows.

- Vous pouvez créer un dossier nommé `Scripts` dans **C:\** ou **D:\** pour organiser vos scripts.
  
### 2. Préparer le Fichier CSV

Le script nécessite un fichier CSV contenant les informations sur les départements ou services à créer. Le format du fichier CSV doit correspondre aux colonnes utilisées dans le script. Par défaut, les colonnes attendues sont :

- **Nom** (Nom du département ou service)
- **Service** (Nom du service ou département)
  
Exemple de fichier CSV :

```csv
Nom,Service
Département A,Développement
Département B,Marketing
```

### 3. Modifier les Paramètres du Script

Avant d'exécuter le script, vous devrez peut-être ajuster certains paramètres dans le fichier `Create-OU.ps1` pour qu'ils correspondent à votre environnement Active Directory. Les principaux paramètres à vérifier sont :

- **$csvPath** : Le chemin d'accès au fichier CSV.
  ```powershell
  $csvPath = "C:\chemin\vers\votre\fichier.csv"
  ```

- **$parentOU** : Le chemin d'accès à l'OU parent sous laquelle les nouvelles OUs seront créées.
  ```powershell
  $parentOU = "OU=Departments,DC=monDomaine,DC=com"
  ```

- **$ouProtection** : Si vous souhaitez désactiver la protection contre la suppression accidentelle, laissez cette option activée :
  ```powershell
  $ouProtection = $true
  ```

### 4. Exécuter le Script

Une fois les étapes précédentes complétées, ouvrez **PowerShell** en tant qu'administrateur et exécutez le script en utilisant la commande suivante :

```powershell
cd C:\cheminers\le\script
.\Create-OU.ps1
```

Cela exécutera le script, créera les OUs spécifiées dans le fichier CSV et supprimera la protection contre la suppression accidentelle des OUs créées.

### 5. Vérification des Résultats

Après l'exécution du script, vous pouvez vérifier si les OUs ont été correctement créées dans Active Directory en utilisant la console **Utilisateurs et ordinateurs Active Directory** (Active Directory Users and Computers). Les nouvelles OUs devraient apparaître sous l'OU parent spécifiée.

## Résolution des Problèmes

### Problème : **Accès refusé**

Si vous obtenez une erreur d'accès refusé, assurez-vous que vous exécutez PowerShell avec des droits d'administrateur et que votre compte dispose des autorisations nécessaires pour créer des OUs dans Active Directory.

### Problème : **Erreur de syntaxe dans le fichier CSV**

Si le script rencontre des erreurs liées au format du fichier CSV, assurez-vous que les colonnes sont bien nommées et qu'il n'y a pas de cellules vides ou de caractères invalides dans les données.

## Conclusion

Une fois ces étapes terminées, vous devriez être en mesure de créer et gérer des unités organisationnelles dans votre Active Directory de manière automatisée. Ce script est flexible et peut être facilement adapté pour répondre à vos besoins spécifiques en matière de gestion des OUs.

Si vous avez besoin d'aide supplémentaire ou souhaitez personnaliser davantage le script, n'hésitez pas à consulter la documentation ou à me contacter pour plus d'assistance.

### 2) Windows 2022 + rôles

### :one: Installation des roles 

### Le détails des instalations des différents role n'est pas détaillé, dans ce document INSTALL.md , mais ici ⬇️

* #### [DHCP](https://github.com/NALSED/R-vision/blob/main/Fichier%20de%20r%C3%A9vision.md#4422-windows-22) 
* #### [DNS](https://github.com/NALSED/R-vision/blob/main/Fichier%20de%20r%C3%A9vision.md#414-windows-1)
* #### [ADDS](https://github.com/NALSED/R-vision/blob/main/Fichier%20de%20r%C3%A9vision.md#368-cr%C3%A9er-un-adds-) 


* ### 4) Debian
### Intégration du serveur débian => ADDS maitre
### Configurer les deuxcarte réseaux(interne, bridge)
### Se connecter en root
  nano /etc/network/interfaces
![ad1](https://github.com/user-attachments/assets/d41a5c11-5144-4c96-a981-31732f3580a3)
  systemctl restart networking
![ad2](https://github.com/user-attachments/assets/880a767b-fc37-4026-b9b8-b82d75e64e79)
### Ici le mieux est de se connecter en ssh depuis le serveur maitre( le commande sont longue)
   
    apt -y install realmd sssd sssd-tools libnss-sss libpam-sss adcli samba-common-bin oddjob oddjob-mkhomedir packagekit

### Editer le fichier de résolution DNS
    nano /etc/resolv.conf
![ad1](https://github.com/user-attachments/assets/42811358-c13a-4a5b-90c3-86c9405814c3)
![ad1](https://github.com/user-attachments/assets/b8f9846f-5a96-4e8d-ac81-084e76e88302)
![ad1](https://github.com/user-attachments/assets/f3fd9c7d-3252-4d07-89a5-907fa5019514)
### Connection au dommaine
    realm join --user=administrator <NomDeDomaine>
![ad1](https://github.com/user-attachments/assets/2d948447-8964-41a6-8d0f-ba20d8a0f973)
### Vérifier que le serveur est bien là
![image](https://github.com/user-attachments/assets/9f6f5fe1-5865-42a4-90e9-5efd7838df24)






























### 2) windows Core + rôles
### 3) ADDS 
  ### 3.1) OU et Groupes
  ### 3.2) Utilisateurs
### 4) Debian
















