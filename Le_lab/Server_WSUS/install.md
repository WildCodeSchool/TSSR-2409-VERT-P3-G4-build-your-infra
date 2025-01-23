# Tutoriel : Installation de WSUS 

## Introduction
Ce tutoriel vous guidera à travers l'installation et la configuration de base de Windows Server Update Services (WSUS). Nous commencerons par la création d'un disque de stockage dédié (D:) avec un dossier pour les fichiers WSUS.

---

## Étape 1 : Préparation du disque de stockage D:
1. **Ajout du disque** :
   - Ajoutez un nouveau disque à votre serveur .

2. **Initialisation et formatage du disque** :
   - Connectez-vous au serveur.
   - Ouvrez la console "Gestion des disques" :
     - `Windows + R` -> tapez `diskmgmt.msc` -> OK.
   - Identifiez le nouveau disque (non alloué).
   - Cliquez avec le bouton droit sur le disque et sélectionnez **Initialiser le disque**.
     - Sélectionnez le style de partition : **GPT** (recommandé).
   - Cliquez avec le bouton droit sur l'espace non alloué et sélectionnez **Nouveau volume simple**.
     - Suivez l'assistant pour :
       - Attribuer la lettre **D:**.
       - Formater en **NTFS** avec un nom de volume (ex. : "Stockage_WSUS").

3. **Création du dossier WSUS** :
   - Une fois le disque formaté et monté, ouvrez l'explorateur de fichiers.
   - Accédez au disque **D:**.
   - Créez un dossier nommé **WSUS**.

---

## Étape 2 : Installation de WSUS

1. **Ajout du rôle WSUS** :
   - Ouvrez le Gestionnaire de serveur (`Server Manager`).
   - Cliquez sur **Ajouter des rôles et des fonctionnalités**.
   - Dans l'assistant, sélectionnez :
     - **Type d'installation** : Installation basée sur un rôle ou une fonctionnalité.
     - **Serveur de destination** : Sélectionnez votre serveur.
     - **Rôle** : Cochez **Windows Server Update Services**.
       - Acceptez l'ajout des fonctionnalités requises.
       - 
![Capture d'écran 2025-01-23 104730](https://github.com/user-attachments/assets/6dc289d6-0b60-4ee9-bb2e-ff6825241698)

2. **Configuration du rôle WSUS** :
   - Lors de l'installation du rôle :
     - **Services de rôle** : Laissez les options par défaut.
     - **Chemin d'accès au stockage** :
       - Sélectionnez le dossier créé précédemment : `D:\WSUS`.
   - Lancez l'installation et patientez jusqu'à la fin du processus.

3. **Démarrer les tâches de post-installation**
   
![Capture d'écran 2025-01-23 105126](https://github.com/user-attachments/assets/1d7375e0-ef21-400b-871c-fb0f0cdcec8f)

---

## Étape 3 : Configuration post-installation de WSUS
1. **Lancement de la console WSUS** :
   - Une fois l'installation terminée, ouvrez la console WSUS :
     - `Outils` -> **Windows Server Update Services**.
     - 
![Capture d'écran 2025-01-23 111324](https://github.com/user-attachments/assets/4c00215c-c13b-4f86-88c5-06437f8f16c7)

2. **Assistant de configuration de WSUS** :
   - Dans la console, suivez les étapes de l'assistant de configuration initiale :
     - **Choisir le serveur de mise à jour en amont** :
       - Sélectionnez "Synchroniser à partir de Microsoft Update".
       - 
   ![Capture d'écran 2025-01-23 111338](https://github.com/user-attachments/assets/d576c164-7e73-45ff-ab81-0d83cf62dd5d)

     - **Paramètres de connexion** : Laissez vide (sauf si vous utilisez un proxy) puis cliquez sur Start Connecting.
       
    ![Capture d'écran 2025-01-23 111409](https://github.com/user-attachments/assets/34223bb1-c973-4359-aed8-c82403a567f6)

     - **Choisir les langues** : Sélectionnez les langues nécessaires.
     - **Choisir les produits** : Cochez les produits à mettre à jour (ex. : Windows Server 2022, Windows 10).
     - **Choisir les classifications** : Sélectionnez les types de mises à jour (ex. : Mises à jour critiques, Définitions de sécurité).
  
   ![Capture d'écran 2025-01-23 113059](https://github.com/user-attachments/assets/0d9eb778-4373-49b0-96d5-799c79498faf)

     - **Planifier la synchronisation** : Configurez la fréquence de synchronisation (ex. : quotidienne).
   
   ![Capture d'écran 2025-01-23 113138](https://github.com/user-attachments/assets/4b4bd548-3e63-489b-8bfd-d5df484927df)

     - Lancez une première synchronisation.
   
![Capture d'écran 2025-01-23 113534](https://github.com/user-attachments/assets/a6d41cc4-41d8-4132-8ca8-14c34bcb3ac5)

3. **Validation** :
   - Pour voir l'état de la synchronisation, tu clic sur le nom de ton serveur dans la fenêtre, et tu as l'état de la synchronisation avec le widget Synchronization Status.

    - Va dans Options, puis Automatic Approvals.
    Dans l'onglet Update Rules, cocher Default Automatic Approval Rule.
![Capture d'écran 2025-01-23 113457](https://github.com/user-attachments/assets/1e32a6fe-427f-459b-98c6-c1d88de43dff)

    - Cela permet d'approuver automatiquement les mises à jour suivant les règles de la section Rule Properties se trouvant en dessous. Par défaut, une mise à jour Critique ou de Sécurité sont Approuvées sur tout les ordinateurs.

    - Cliquer sur Run Rules
    - Cliquer sur Apply et OK
    - 
![Capture d'écran 2025-01-23 113511](https://github.com/user-attachments/assets/9e1a90fa-d54b-4a3f-9695-7c54e87be3be)

---

## Étape 4 : Configuration des clients WSUS
1. **Configuration via stratégie de groupe (GPO)** :
   - Ouvrez la console de gestion des stratégies de groupe (GPMC).
   - Créez ou modifiez une stratégie appliquée aux ordinateurs cibles.
   - Configurez les paramètres suivants :
     - **Emplacement du serveur WSUS** :
       - `http://NomDuServeurWSUS` (remplacez par le nom ou l'IP de votre serveur).
     - **Planification des mises à jour automatiques** :
       - Activez les mises à jour automatiques et définissez un planning.

2. **Application de la stratégie** :
   - Appliquez la stratégie sur les clients.
   - Exécutez `gpupdate /force` sur un client pour valider l'application.
   - Vérifiez la connectivité avec le serveur WSUS :
     - Commande : `wuauclt /detectnow`.

---

## Conclusion
Vous avez maintenant installé et configuré un serveur WSUS de base avec un disque de stockage dédié pour les fichiers WSUS. Vous pouvez gérer les mises à jour et surveiller leur distribution à vos clients depuis la console WSUS.
