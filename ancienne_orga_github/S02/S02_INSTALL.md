## REDONDANCE
* ### 1) Script
* ### 2) Windows 2022 + rôles
  * ### 2.2) Redondance DHCP 
  * ### 2.3) Redondance DNS
  * ### 2.4) Redondance ADDS
* ### 3)windows Core + rôles
* ### 4) ADDS 
  * ### 4.1) OU et Groupes
  * ### 4.2) Utilisateurs
* ### 5) Debian


# 1)  `INSTALL GUIDE SCRIPT CREATION OU "Create_OU.ps1"`

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

# `2) Windows 2022 + rôles`
   ### `2.1) Installation des roles` 
### Le détails des instalations des différents role n'est pas détaillé, dans ce document INSTALL.md , mais ici ⬇️
* #### [DHCP](https://github.com/NALSED/R-vision/blob/main/Fichier%20de%20r%C3%A9vision.md#4422-windows-22) 
* #### [DNS](https://github.com/NALSED/R-vision/blob/main/Fichier%20de%20r%C3%A9vision.md#414-windows-1)
* #### [ADDS](https://github.com/NALSED/R-vision/blob/main/Fichier%20de%20r%C3%A9vision.md#368-cr%C3%A9er-un-adds-) 
   # `2.2) Redondance DHCP`
  ### 🔷Vérifier les serveurs autorisés => clic droit DHCP (bleu) => Manage authorized servers...(rouge)
![ad1](https://github.com/user-attachments/assets/2eb6d9e9-f246-4b1b-b7bb-fb9c22b64c2a)
### 🔷 Le serveur est bien autorisé
![ad1](https://github.com/user-attachments/assets/fceacffe-6cca-4e83-ac71-8bd87b173318)
### 🔷 Pour démarer le redondance :
### Clic droit sur Scope => Configure Failover...
![ad1](https://github.com/user-attachments/assets/62037b97-0528-4b3a-92d3-1981d5f5d4bf)
### 🔷 Rentrer l'IP du serveur de secours
![ad1](https://github.com/user-attachments/assets/364c975c-8db4-4039-b49e-83128d96cada)
![image](https://github.com/user-attachments/assets/4554e99b-d527-40b4-90e4-2aa32818c854)
### 🔷 Configuration ⬇️
### Lien entre serveurs (bleu)
### Choisir Hot standby(rouge), 
##### (l'autre option permet de partager la charge dans l'attribution des adresses IP)
![ad1](https://github.com/user-attachments/assets/86ca4878-0616-4f7a-9858-1a4c002d48a6)
###  🔷Pour la suite diminuer l'intervale de 60 min par defaut à 5 min
##### (c'est le temps que va mettre le serveur deux à prendre le relais)
### 🔷 Et cocher le case Enable Message Authentification
#### (Cela permet de chiffrer le echange au niveau de la trame)
![ad1](https://github.com/user-attachments/assets/264bc16d-07d9-480b-b259-462e80e1040e)
### 🔷 Puis finish
### Vérifier d'être en Successful partout
![ad1](https://github.com/user-attachments/assets/1cc9be01-dcd4-475f-a45c-841d3d4717a2)
   * # `2.3) Redondance DNS`
### 🔷 Autoriser le tansfert au niveau du serveur primaire
    Set-DnsServerPrimaryZone Pharmgreen.com -SecureSecondaries TransferAnyServer -Notify Notify
### 🔷 Sur le serveur core créer une secondary zone
    Add-DnsServerSecondaryZone -Name Pharmgreen.com -ZoneFile Pharmgreen.com.dns -MasterServers @192.168.40.5
### ▶️ Retourner sur le serveur principale (master)
### 🏗️ Créer un nouvel enregistrement de type A ou AAAA.
### 🔷 Remplir le nom du nouvel enregistrement(peux importe le nom) (bleu)
##### ⚠️Une Reverse Lookup Zone doit être présente sur le serveur maitre, dans le cas contraire,la créer!⚠️
### 1️⃣ Ip du serveur secondaire (rouge)
### 2️⃣ la case Create associated (PTR) record (vert)
![ad1](https://github.com/user-attachments/assets/319f5b87-5730-466d-9d20-86d8bc3764b1)
### 🔷 Puis Add Host
### 🔷 Sur le serveur maitre Action => Properties
![ad1](https://github.com/user-attachments/assets/29a79308-804e-4a5e-90f2-402c9a37bdf6)
### 🔷  Vérifier que le serveur secondaire est présent
![ad1](https://github.com/user-attachments/assets/dd3bfbc1-2a02-468b-9391-ec12052cf44e)
### 1️⃣ Pour finir Zone Transfers (bleu) 
### 2️⃣ Cocher Only to servers listed on the Name Server tab (rouge)
![ad1](https://github.com/user-attachments/assets/e095a4eb-faa1-40f8-8105-719b68d17287)
# `2.4) Redondance ADDS`
* # `3) windows Core + rôles`
   ### `3.1) Installation du serveur` 
### Le détail de l'instalation d'un serveur Windows Server en mode CORE n'est pas détaillé dans ce document INSTALL.md, mais ici ⬇️
* #### [Instalation d'un serveur Windows Server en mode CORE](https://www.it-connect.fr/chapitres/installer-windows-server-en-mode-core/) 

   ### `3.2) Installation et Configuration des Services AD-DS sur Windows Server 2022 Core`

#### Étape 1 : Préparer le serveur Windows Server Core

##### 1.1 Configurer un nom d’hôte
1. Connectez-vous à votre serveur.

2. Taper 2 sur la page de gestion :  
![1](https://github.com/user-attachments/assets/5884ced1-46d1-4dab-afb0-0335372696cb)

3. Changez le nom du serveur :  
![2](https://github.com/user-attachments/assets/fef20715-8b1a-425a-b210-d242ff50cd92)


5. Le serveur redémarrera automatiquement.

---

##### 1.2 Configurer une adresse IP statique
1. Taper 8 sur la page de gestion :
 
![3](https://github.com/user-attachments/assets/22e46eab-3fe5-4ebd-b75f-924090f200d9)
   
2. Choisissez le network que vous souhaitez configurer :

![4](https://github.com/user-attachments/assets/65fccbcf-f5ab-41da-b4ed-699ddabbb67d)

3. Entrez les différentes données pour chaque ligne :
   
![5](https://github.com/user-attachments/assets/51f530d2-1bfd-4623-bf6b-2ed29a1b7ed9)

---

#### Étape 2 : Joindre le serveur au domaine
1. Joignez le serveur au domaine existant (exemple : `pharmgreen.com`) :

![2](https://github.com/user-attachments/assets/13a7ddc4-9812-4f8b-8e68-9626d07d6e92)
![3](https://github.com/user-attachments/assets/2b8a7ef5-6cdb-4422-a53e-3216171d6451)


2. Facultatif : Tapez 15 sur l'écran d'accueil et vérifiez si le serveur a bien rejoint le domaine :
   ```powershell
   Get-ComputerInfo | Select-Object CsDomain
   ```

---


#### Étape 3 : Se connecter au domaine

##### 3.1 Déconnectez-vous :

![1 - Copie - Copie](https://github.com/user-attachments/assets/bbfbfd90-3f9a-450c-b01d-228c44eed5d2)

##### 3.2 Connectez-vous sur le domaine en suivant les étapes suivantes :

- Appuyez sur ECHAP  
![4](https://github.com/user-attachments/assets/82a8c52f-6339-4a55-9d24-3da62bb85f79)  
- Appuyez sur ECHAP  
![5](https://github.com/user-attachments/assets/69f056dc-d824-43fb-98d3-93a1a8528cc0)  
- Choissiez Other user  
![6](https://github.com/user-attachments/assets/2c7971e3-37a2-4af6-9f78-66226dc657ba)  
- Choisissez Local or Domain account password  
![7](https://github.com/user-attachments/assets/b63f677d-e202-4bc0-bd2c-a703707590ba)  
- Entrez votre nom d'utilisateur dans le domaine et votre mot de passe  
![8](https://github.com/user-attachments/assets/beb86c59-da0b-4cd8-b284-43f1e3ce7a95)  


#### Étape 4 : Installer le rôle AD-DS

1. Installez le rôle **Active Directory Domain Services** :
   ```powershell
   Install-WindowsFeature AD-Domain-Services
   ```

- Attendez pendant l'installation  
![10](https://github.com/user-attachments/assets/ec5a2346-8ec5-44c3-a357-ee9bb3b9da2d)  
- Une fois le processus terminé vous devriez obtenir cet écran  
![11](https://github.com/user-attachments/assets/0b093d2b-a037-4bb5-8cc4-46a17655073b)


2. Vérifiez que l'installation est terminée avec succès :
   ```powershell
   Get-WindowsFeature AD-Domain-Services
   ```
![Capture d’écran 2024-12-06 134509](https://github.com/user-attachments/assets/b313e281-2cd5-4bc4-b067-d95d12f857d3)

---

#### Étape 5 : Promouvoir le serveur en contrôleur de domaine

##### 5.1 Lancer la promotion
1. Exécutez la commande suivante pour promouvoir le serveur en tant que contrôleur de domaine :
   ```powershell
   Install-ADDSDomainController -DomainName "pharmgreen.com" -Credential (Get-Credential) -InstallDns:$true -SafeModeAdministratorPassword (ConvertTo-SecureString "MotDePasseDS" -AsPlainText -Force)
   ```
   - Remplacez `pharmgreen.com` par le nom de votre domaine.
   - Remplacez `MotDePasseDS` par un mot de passe sécurisé pour le mode de restauration AD.  
![12](https://github.com/user-attachments/assets/d5cb9bbc-9771-43d1-bc36-90c78326b7de)  


2. Attendez que la configuration soit terminée. Le serveur redémarrera automatiquement.  
![13](https://github.com/user-attachments/assets/6adb7bba-26c7-4c9e-bef8-072c48af4f50)  
![14](https://github.com/user-attachments/assets/075cc29b-1d3c-4cad-a601-067313247417)



---

##### 5.2 Vérifiez la promotion
1. Confirmez que le serveur est devenu un contrôleur de domaine :
   ```powershell
   Get-ADDomainController -Filter *
   ```
   Le serveur doit apparaître dans la liste des contrôleurs de domaine.
![15](https://github.com/user-attachments/assets/75b19533-57cf-4a8c-8574-6641bf86e0b6)  

2. Vérifiez que le serveur est dans l’OU **Domain Controllers** :
   - Ouvrez **Active Directory Users and Computers** sur un autre contrôleur de domaine.
   - Assurez-vous que l'objet du serveur se trouve dans l'OU **Domain Controllers**.
![16](https://github.com/user-attachments/assets/2f7baf1a-ca9d-4e5f-93a6-0bf19fa77bd2)  

---

##### Résultat attendu
À la fin de ce tutoriel, votre serveur Windows Server Core sera configuré comme un contrôleur de domaine fonctionnel et intégré au domaine existant.

- Le serveur pourra gérer les authentifications et participer à la réplication AD.
- Les services DNS seront correctement configurés pour assurer la résolution des noms dans le domaine.
 
* # `4) ADDS` 
  * # `4.1) OU et Groupes`
  * # `4.2) Utilisateurs`
* # `5) Debian`
### Intégration du serveur débian => ADDS maitre
### Configurer les deuxcarte réseaux(interne, bridge)
### Se connecter en root
  
     nano /etc/network/interfaces

![ad1](https://github.com/user-attachments/assets/593cf91c-d977-4e20-a742-0250ff14c349)
  
     systemctl restart networking

### Ici le mieux est de se connecter en ssh depuis le serveur maitre( les commande sont longue)
     apt -y install realmd sssd sssd-tools libnss-sss libpam-sss adcli samba-common-bin oddjob oddjob-mkhomedir packagekit
### Editer le fichier de résolution DNS
    nano /etc/resolv.conf
![ad1](https://github.com/user-attachments/assets/8f5040da-7b95-4d11-82c9-84970cbb2fd6)
![image](https://github.com/user-attachments/assets/4c270260-7308-467c-b9ee-529469d28cda)
### Connection au dommaine
    realm join --user=administrator <NomDeDomaine>
### Vérifier que le serveur est bien là
![ad1](https://github.com/user-attachments/assets/73431a49-1520-4ea1-a2d7-6f4299b48c10)

















