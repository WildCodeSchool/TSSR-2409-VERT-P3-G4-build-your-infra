# REDONDANCE

## Sommaire

1. [Windows 2022 + Rôles](#1-windows-2022--rôles)
   1. [Installation des Rôles](#11-installation-des-rôles)
   2. [Redondance DHCP](#12-redondance-dhcp)
   3. [Redondance DNS](#13-redondance-dns)
   4. [Redondance ADDS](#14-redondance-adds)
2. [Windows Core + Rôles](#2-windows-core--rôles)
   1. [Installation du serveur](#21-installation-du-serveur)
   2. [Installation et Configuration des Services AD-DS](#22-installation-et-configuration-des-services-ad-ds)
3. [ADDS](#3-adds)
   1. [OU et Groupes](#31-ou-et-groupes)
   2. [Utilisateurs](#32-utilisateurs)
4. [Debian](#4-debian)

---

## 1) Windows 2022 + Rôles

### 1.1) Installation des Rôles
Le détail des installations des différents rôles n’est pas précisé dans ce document INSTALL.md, mais ici :

- [DHCP](https://github.com/NALSED/R-vision/blob/main/Fichier%20de%20r%C3%A9vision.md#4422-windows-22)
- [DNS](https://github.com/NALSED/R-vision/blob/main/Fichier%20de%20r%C3%A9vision.md#414-windows-1)
- [ADDS](https://github.com/NALSED/R-vision/blob/main/Fichier%20de%20r%C3%A9vision.md#368-cr%C3%A9er-un-adds-)

---

### 1.2) Redondance DHCP

#### Vérifier les serveurs autorisés :
- Clic droit DHCP => Manage authorized servers...  
  ![ad1](https://github.com/user-attachments/assets/2eb6d9e9-f246-4b1b-b7bb-fb9c22b64c2a)

#### Le serveur est bien autorisé :
![ad1](https://github.com/user-attachments/assets/fceacffe-6cca-4e83-ac71-8bd87b173318)

#### Pour démarrer la redondance :
- Clic droit sur Scope => Configure Failover...  
  ![ad1](https://github.com/user-attachments/assets/62037b97-0528-4b3a-92d3-1981d5f5d4bf)

#### Rentrer l'IP du serveur de secours :
![ad1](https://github.com/user-attachments/assets/364c975c-8db4-4039-b49e-83128d96cada)
![ad1](https://github.com/user-attachments/assets/4554e99b-d527-40b4-90e4-2aa32818c854)

#### Configuration :
- Lien entre serveurs.
- Choisir Hot standby,  
  _(L’autre option permet de partager la charge dans l’attribution des adresses IP.)_  
  ![ad1](https://github.com/user-attachments/assets/86ca4878-0616-4f7a-9858-1a4c002d48a6)

#### Pour la suite :
- Diminuer l’intervalle de 60 min par défaut à 5 min.  
  _(Temps pour que le serveur de secours prenne le relais.)_
- Cocher la case **Enable Message Authentication**.  
  _(Cela permet de chiffrer les échanges au niveau de la trame.)_  
  ![ad1](https://github.com/user-attachments/assets/264bc16d-07d9-480b-b259-462e80e1040e)

#### Finaliser :
- Clic sur Finish.
- Vérifier que tout est en Successful partout.  
  ![ad1](https://github.com/user-attachments/assets/1cc9be01-dcd4-475f-a45c-841d3d4717a2)

---

### 1.3) Redondance DNS

#### Autoriser le transfert au niveau du serveur primaire :
```powershell
Set-DnsServerPrimaryZone Pharmgreen.com -SecureSecondaries TransferAnyServer -Notify Notify
```

#### Sur le serveur core, créer une secondary zone :
```powershell
Add-DnsServerSecondaryZone -Name Pharmgreen.com -ZoneFile Pharmgreen.com.dns -MasterServers @192.168.40.5
```

#### Retourner sur le serveur principal (master) :
- Créer un nouvel enregistrement de type A ou AAAA.  
  ![ad1](https://github.com/user-attachments/assets/319f5b87-5730-466d-9d20-86d8bc3764b1)

#### Ajouter l’hôte :
- Vérifier que le serveur secondaire est présent.  
  ![ad1](https://github.com/user-attachments/assets/dd3bfbc1-2a02-468b-9391-ec12052cf44e)

#### Configurer les transferts de zone :
- Aller dans **Zone Transfers**.
- Cocher **Only to servers listed on the Name Server tab**.  
  ![ad1](https://github.com/user-attachments/assets/e095a4eb-faa1-40f8-8105-719b68d17287)

---

### 1.4) Redondance ADDS

---

## 2) Windows Core + Rôles

### 2.1) Installation du serveur
- [Détails sur l'installation d'un serveur Windows Server en mode CORE](https://www.it-connect.fr/chapitres/installer-windows-server-en-mode-core/)

### 2.2) Installation et Configuration des Services AD-DS

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
- Choisissez Other user  
![6](https://github.com/user-attachments/assets/2c7971e3-37a2-4af6-9f78-66226dc657ba)  
- Choisissez Local or Domain account password  
![7](https://github.com/user-attachments/assets/b63f677d-e202-4bc0-bd2c-a703707590ba)  
- Entrez votre nom d'utilisateur dans le domaine et votre mot de passe  
![8](https://github.com/user-attachments/assets/beb86c59-da0b-4cd8-b284-43f1e3ce7a95)

---

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

---

## 3) ADDS

### 3.1) OU et Groupes

### 3.2) Utilisateurs

---

## 4) Debian

- Configurer les deux cartes réseaux (interne, bridge).
- Se connecter en root et modifier les interfaces réseau :  
  ```bash
  nano /etc/network/interfaces
  ```
  ![ad1](https://github.com/user-attachments/assets/593cf91c-d977-4e20-a742-0250ff14c349)

- Installer les paquets nécessaires :
  ```bash
  apt -y install realmd sssd sssd-tools libnss-sss libpam-sss adcli samba-common-bin oddjob oddjob-mkhomedir packagekit
  ```

- Modifier le fichier de résolution DNS :
  ```bash
  nano /etc/resolv.conf
  ```
  ![ad1](https://github.com/user-attachments/assets/8f5040da-7b95-4d11-82c9-84970cbb2fd6)

- Rejoindre le domaine :
  ```bash
  realm join --user=administrator <NomDeDomaine>
  ```
  ![ad1](https://github.com/user-attachments/assets/73431a49-1520-4ea1-a2d7-6f4299b48c10)
