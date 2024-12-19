# Guide utilisateur pour le script PowerShell

## Objectif
Ce script PowerShell automatise la création d'utilisateurs Active Directory (AD) à partir d'un fichier CSV. Il vérifie si un utilisateur existe déjà dans AD avant de créer un nouveau compte avec des informations fournies dans le fichier CSV.

---

## Prérequis
Avant d'exécuter le script, assurez-vous que :

1. **Le fichier CSV est préparé correctement :**
   - Le fichier doit contenir les colonnes suivantes :
     - `Prenom` : Prénom de l'utilisateur.
     - `Nom` : Nom de famille de l'utilisateur.
     - `fonction` : Fonction de l'utilisateur.
     - `Département` : Département ou unité organisationnelle de l'utilisateur.
     - `Managernom` : Nom du manager.
   - Le fichier doit être enregistré au format CSV avec une virgule comme délimiteur.
   - Le chemin vers le fichier CSV doit être correctement renseigné dans la variable `$CSVFile`.

2. **Les permissions sont en place :**
   - L'utilisateur qui exécute le script doit avoir les permissions nécessaires pour créer des comptes utilisateurs dans Active Directory.

3. **Le module Active Directory est installé :**
   - Ce module est requis pour utiliser les commandes comme `Get-ADUser` et `New-ADUser`.

4. **Chemin de l'OU dans AD :**
   - L'unité organisationnelle (“OU”) spécifiée dans le script doit exister dans votre Active Directory.

---

## Déroulement du script
1. **Importation des données du fichier CSV :**
   - Le script lit le fichier CSV défini dans la variable `$CSVFile` en utilisant la commande `Import-CSV`.

2. **Parcours des lignes CSV :**
   - Pour chaque ligne du fichier, le script :
     - Extrait les informations comme le prénom, le nom, la fonction, etc.
     - Crée des variables pour gérer ces données.

3. **Vérification de l'existence de l'utilisateur :**
   - Le script utilise la commande `Get-ADUser` pour vérifier si un compte avec le même `SamAccountName` existe déjà dans Active Directory.
   - Si l'utilisateur existe, un avertissement est affiché dans la console.

4. **Création de l'utilisateur :**
   - Si l'utilisateur n'existe pas, la commande `New-ADUser` est utilisée pour créer un nouveau compte utilisateur avec les informations suivantes :
     - **Nom complet** : `Nom` suivi de `Prénom`.
     - **Identifiant de connexion** : Formaté comme `nom.prenom`.
     - **Email professionnel** : `nom.prenom@Pharmgreen.com`.
     - **Mot de passe** : “P@ssword123456789”.
     - **Unité organisationnelle** : Basée sur la valeur dans le champ « Département ».
     - **Autres champs** : Fonction, email, manager, etc.
   - Le compte utilisateur est activé et l’option pour changer le mot de passe à la première connexion est activée.

---

## Paramètres du script
- **Fichier CSV :** Le chemin est défini dans la variable `$CSVFile`. Modifiez cette variable pour correspondre à l’emplacement de votre fichier CSV.
- **Mot de passe par défaut :** Défini dans `$UtilisateurMotDePasse`. Vous pouvez le personnaliser selon vos besoins.
- **Structure de l'OU :** La valeur à renseigner dans « Path » doit refléter la structure de votre Active Directory.

---

## Exemple de fichier CSV
```csv
Prenom,Nom,fonction,Département,Managernom
Jean,Dupont,Ingénieur,IT,Paul Martin
Marie,Curie,Scientifique,R&D,Albert Einstein
```

