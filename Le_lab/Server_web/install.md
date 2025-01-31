### ✔️ Étape 1 - Prérequis

 - 1 VM nommée webserver Debian 12 installé et mise à jour  
 - Une configuration SSH fonctionnelle  

### 🔬 Étape 2 - Installation d’Apache  

Sur la VM webserver, exécute les lignes de commandes suivantes pour mettre à jour ton système et installer Apache :  

  ` apt update && apt upgrade -y ` 
  ` apt install apache2 -y `

Vérifie le statut du service avec systemctl status apache2  
  `systemctl status apache2`

### 🔬 Étape 3 - Configuration de la page d'accueil  

  -  La page d'accueil par défaut de ton serveur web est /var/www/html/index.html.
    
Maintenant, pour changer la structure de ton serveur web on remplace le contenu du fichier index.html par ceci :  

![Capture d'écran 2025-01-31 102338](https://github.com/user-attachments/assets/c4a0c198-f77c-4356-82ed-129f43c3161d)
![Capture d'écran 2025-01-31 102711](https://github.com/user-attachments/assets/282f61eb-e12d-41ca-9198-ab50ac025cf3)

Ajoute également dans le même dossier que le fichier index.html un fichier next.html avec ce contenu :  

![Capture d'écran 2025-01-31 102504](https://github.com/user-attachments/assets/01f6ad59-969a-47fd-ab7b-d3efe564d82b)
![Capture d'écran 2025-01-31 102636](https://github.com/user-attachments/assets/b80b020d-72aa-4575-bcf3-668252b5b1b6)

Redémarre le service apache2 et regarde la différence dans ton navigateur web.
