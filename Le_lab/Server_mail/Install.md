#  Étape 1 - Prérequis 
 - un serveur dédié Debian 12
 - un nom de domaine
 - une connexion internet
 - minimun 4 Go de RAM

## 1. Installation du serveur Debian
 - Mise à jour du système  
   ` apt update && apt upgrade -y `
   
 - Configuration du nom
   Sous Debian/Ubuntu Linux, le nom d'hôte est défini dans deux fichiers : /etc/hostname et /etc/hosts.

    - /etc/hostname: nom d'hôte court, pas FQDN.  
    `Srvmail `
    - /etc/hosts:  indiquer le nom d'hôte FQDN comme premier élément.  
    `10.15.0.40 localhost Srvmail.pharmgreen.com.`

Vérifiez le nom d'hôte FQDN. S'il n'a pas été modifié après la mise à jour des deux fichiers ci-dessus, veuillez redémarrer le serveur pour le faire fonctionner.  
    `# hostname -f`  
    `Srvmail.pharmgreen.com`  

  ## 2. Installer IRedMail  
   - Visitez la page de téléchargement pour obtenir la dernière version stable d'iRedMail, ici 1.7.1  
   - Décompresser l'archive tar iRedMail :  
    `cd /root/ `  
    `tar zxf iRedMail-x.y.z.tar.gz`
   - Démarrer l'installateur d'iRedMail :
  Il est maintenant prêt à démarrer l'installateur d'iRedMail, il vous posera plusieurs questions simples, tout ce qui est nécessaire pour configurer un serveur de messagerie complet.
    `cd /root/iRedMail-x.y.z/`
    `bash iRedMail.sh`

   -Captures d'écran de l'installation :
Bienvenue et merci pour votre utilisation

![image](https://github.com/user-attachments/assets/e34cda06-85b6-4d90-9e72-1bc033adf2f1)
    Spécifiez l'emplacement où stocker toutes les boîtes aux lettres. La valeur par défaut est /var/vmail/.  
    ![image](https://github.com/user-attachments/assets/3ee60594-ca65-4028-9e11-4e51a5d15997)  
    Choisissez le backend utilisé pour stocker les comptes de messagerie. Vous pouvez gérer les comptes de messagerie avec iRedAdmin, notre panneau d'administration iRedMail basé sur le Web.  
 ![image](https://github.com/user-attachments/assets/6bccd787-29ff-428a-85df-b0a00f6d283c)  
   Si vous choisissez de stocker les comptes de messagerie dans OpenLDAP, le programme d'installation d'iRedMail vous demandera de définir le suffixe LDAP.  
   ![image](https://github.com/user-attachments/assets/d1d24644-1b83-468a-947d-332c7cd84e7c)  
   Ajoutez votre premier nom de domaine de messagerie  
   ![image](https://github.com/user-attachments/assets/3fa31c0b-1652-4b8d-943a-ece179bfc480)  
   Définissez le mot de passe du compte administrateur de votre premier domaine de messagerie.  
   Remarque : ce compte est un compte administrateur et un utilisateur de messagerie. Cela signifie que vous pouvez vous connecter à la messagerie Web et au panneau d'administration (iRedAdmin) avec ce compte. Le nom d'utilisateur de connexion est l'adresse e-mail complète.  
   ![image](https://github.com/user-attachments/assets/949750ba-af24-447b-8647-2e7be9bc65cd)  
   Choisissez les composants optionnels  
   ![image](https://github.com/user-attachments/assets/ca0429be-a50d-498e-bf73-75df4e495742)  
 Après avoir répondu aux questions ci-dessus, l'installateur d'iRedMail vous demandera de vérifier et de confirmer pour démarrer l'installation. Il installera et configurera automatiquement les packages requis. Tapez you Yet appuyez sur Enterpour démarrer.  
 ![image](https://github.com/user-attachments/assets/414372a7-05c6-4a6a-b77f-7927d35133c5)  

 ## 3. Configuration du server DNS 


###  Ajoutez les enregistrements nécessaires:
       
Enregistrement MX:   

    - Clic droit sur votre domaine -> "Nouvel enregistrement...".  
    - Choisissez "Échangeur de courrier (MX)" et cliquez sur "Créer un enregistrement...". 
    - Dans "Nom de l'hôte de l'échangeur de courrier", entrez le nom d'hôte de votre serveur iredmail (ex: mail).  
    - Dans "Priorité", entrez une valeur faible (ex: 10).  
    - Cliquez sur "OK".   
    
Enregistrement A:  

    - Clic droit sur votre domaine -> "Nouvel enregistrement...".  
    - Choisissez "Hôte (A)" et cliquez sur "Créer un enregistrement...".  
    - Dans "Nom", entrez le nom d'hôte de votre serveur Iredmail (ex: mail).  
    - Dans "Adresse IP", entrez l'adresse IP de votre serveur iredmail.  
    - Cliquez sur "OK".  
    
Enregistrement CNAME (optionnel):  

    - Clic droit sur votre domaine -> "Nouvel enregistrement...".  
    - Choisissez "Alias (CNAME)" et cliquez sur "Créer un enregistrement...".  
    - Dans "Nom d'alias", entrez un alias pour votre serveur iredmail (iredmail)).  
    - Dans "Nom de domaine complet de la cible", entrez le nom de domaine complet de votre serveur iredmail (ex: mail.tssr.lab).  
    - Cliquez sur "OK".  

   ## 4. Configuration initiale d'iRedMail    

   Depuis le client  
   - Accès à l'administration: https://srvmail.pharmgreen.com/iredadmin  
   - Connexion: Avec postmaster@pharmgreen.com et le mot de passe.  
   - Configuration:  
      - Vérifier la configuration du domaine existant : Nom de domaine, adresse

   ## 5. Gestion des domaines et des comptes
   
Cette étape vous permet de créer des comptes utilisateurs sur votre domaine.
1. Créez un compte utilisateur :

Cliquez sur le bouton "Add" puis user.

Exemple de configuration :

Email: utilisateur1@pharmgreen.com  
Password: Un mot de passe fort (au moins 8 caractères avec des lettres majuscules et minuscules, des chiffres et des symboles).  
Name: Utilisateur Un  
Quota: 1024 (quota de 1 Go)  
Active: Cochez la case pour activer le compte.  
Cliquez sur "Add" pour créer le compte utilisateur.    

  ## 6.  Accès à la messagerie via webmail  
  
Webmail: https://srvmail.pharmgreen.com/mail (Roundcube)
