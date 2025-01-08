# User Guide : Gestion des Dossiers pour Utilisateurs, Départements et Services

Ce guide explique comment utiliser trois scripts pour :
1. Créer des dossiers personnels pour chaque utilisateur et leur attribuer des permissions nécessaires.
2. Créer des dossiers pour les **départements** et attribuer les permissions nécessaires aux utilisateurs.
3. Créer des dossiers pour les **services** (sous-OUs des départements) dans un emplacement distinct et attribuer les permissions nécessaires aux utilisateurs.

---

## **Prérequis**

1. **Structure AD** :
   - Les utilisateurs doivent être organisés dans une OU spécifique pour les scripts utilisateurs.
   - Les départements doivent être organisés en OUs directement sous `OU=Departments`.
   - Les services doivent être organisés en sous-OUs des départements dans `OU=Departments`.
   - Les utilisateurs doivent être directement présents dans les OUs des départements ou des services.

2. **Chemins des dossiers** :
   - Les dossiers des utilisateurs seront créés dans `C:\Partage\Utilisateurs`.
   - Les dossiers des départements seront créés dans `C:\Partage\Departements`.
   - Les dossiers des services seront créés dans `C:\Partage\Services`.

3. **Permissions NTFS** :
   - Les utilisateurs présents dans les OUs recevront des permissions **Contrôle total** sur leurs dossiers respectifs.
   - Les administrateurs auront également **Contrôle total**.

4. **Compte Administrateur avec PowerShell** :
   - Les scripts doivent être exécutés avec un compte ayant les droits d’administrateur sur le serveur et dans Active Directory.

---

## **Script 1 : Création des Dossiers Personnels pour les Utilisateurs**

### **Objectif**
- Créer un dossier personnel pour chaque utilisateur dans `C:\Partage\Utilisateurs`.
- Attribuer des permissions NTFS pour que chaque utilisateur ait accès uniquement à son propre dossier.

### **Étapes**
1. Exécutez le script pour identifier tous les utilisateurs dans l’OU définie pour les utilisateurs.
2. Pour chaque utilisateur :
   - Créez un dossier avec son **SamAccountName**.
   - Appliquez les permissions suivantes :
     - L’utilisateur a **Contrôle total** sur son propre dossier.
     - Les administrateurs ont également **Contrôle total**.

3. **Validation** :
   - Connectez-vous avec un utilisateur pour vérifier qu’il peut accéder et modifier son propre dossier sans voir ceux des autres.

---

## **Script 2 : Création des Dossiers pour les Départements**

### **Objectif**
- Créer des dossiers pour chaque département dans `C:\Partage\Departements`.
- Attribuer des permissions NTFS aux utilisateurs présents dans les OUs des départements.

### **Étapes**
1. Identifiez toutes les OUs de départements directement sous `OU=Departments`.
2. Pour chaque OU :
   - Créez un dossier avec le nom de l’OU.
   - Récupérez les utilisateurs dans cette OU.
   - Appliquez les permissions suivantes :
     - Chaque utilisateur a **Contrôle total** sur le dossier du département.
     - Les administrateurs ont également **Contrôle total**.

3. **Validation** :
   - Connectez-vous avec un utilisateur pour vérifier qu’il peut accéder et modifier les fichiers dans le dossier de son département.

---

## **Script 3 : Création des Dossiers pour les Services**

### **Objectif**
- Créer des dossiers pour chaque service (sous-OU des départements) dans `C:\Partage\Services`.
- Attribuer des permissions NTFS aux utilisateurs présents dans les OUs des services.

### **Étapes**
1. Identifiez toutes les OUs de départements directement sous `OU=Deparments`.
2. Pour chaque département, identifiez les sous-OUs représentant les services.
3. Pour chaque service :
   - Créez un dossier avec le nom de l’OU du service.
   - Récupérez les utilisateurs dans cette OU.
   - Appliquez les permissions suivantes :
     - Chaque utilisateur a **Contrôle total** sur le dossier du service.
     - Les administrateurs ont également **Contrôle total**.

4. **Validation** :
   - Connectez-vous avec un utilisateur pour vérifier qu’il peut accéder et modifier les fichiers dans le dossier de son service.

---

## **Validation Globale**

1. **Exécutez les scripts** :
   - Vérifiez que les dossiers des utilisateurs, des départements et des services sont correctement créés.
   - Assurez-vous que les utilisateurs des OUs ont bien les permissions configurées.

2. **Testez les droits des utilisateurs** :
   - Connectez-vous avec différents utilisateurs pour vérifier qu’ils ont accès uniquement à leurs dossiers respectifs (personnel, département ou service).

3. **Commandes de vérification** :
   - Vérifiez les utilisateurs dans une OU spécifique :
     ```powershell
     Get-ADUser -Filter * -SearchBase "OU=<Nom>,OU=Depart
ments,DC=Pharmgreen,DC=com"
     ```
   - Vérifiez les permissions d’un dossier :
     ```powershell
     Get-Acl -Path "C:\Partage\<Type>\<NomDossier>" | Format-List
     ```

Ce guide vous permet de gérer efficacement la création et la configuration des dossiers pour les utilisateurs, départements et services en respectant la structure Active Directory. Si des ajustements sont nécessaires, contactez votre administrateur AD ou ajustez les scripts en conséquence.
