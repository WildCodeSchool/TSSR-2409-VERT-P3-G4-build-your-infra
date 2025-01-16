# Guide d'installation de Passbolt en local sur Debian 12

Ce guide détaille toutes les étapes pour installer et configurer Passbolt sur un serveur Debian 12 en local.

---

## Prérequis

1. Un serveur Debian 12.
2. Un serveur DNS Active Directory avec une entrée DNS configurée pour le domaine.
3. Accès root au serveur Debian 12.

---

### Étape 1 : Configuration DNS locale
1. Accédez à votre serveur DNS local (par exemple, Active Directory ou un autre gestionnaire DNS).
2. Ajoutez une **entrée DNS A** pour le domaine local de passbolt :
   - **Nom** : `passbolt` (ou un autre nom, selon vos conventions).
   - **IP** : Adresse IP locale du serveur Debian où passbolt sera installé.

3. Si votre DNS prend en charge les enregistrements PTR (résolution inverse) :
   - Configurez une entrée PTR pour associer l'adresse IP locale au domaine `passbolt.pharmgreen.com`.

4. Vérifiez la résolution DNS depuis le serveur Debian :
   ```bash
   nslookup passbolt.pharmgreen.com
   ```
   - La sortie doit afficher l'adresse IP configurée pour le domaine `passbolt.pharmgreen.com`.

---

## Étape 2 : Configuration réseau sur le serveur Debian

1. Éditez le fichier `/etc/resolv.conf` :
   ```bash
   nano /etc/resolv.conf
   ```
2. Assurez-vous qu'il contient :
   ```
   domain pharmgreen.com
   search pharmgreen.com home.arpa
   nameserver <IP-DU-SERVEUR-DNS-AD>
   ```
3. Testez la résolution DNS :
   ```bash
   ping -c 4 passbolt.pharmgreen.com
   ```

---

## Étape 3 : Génération d'un certificat auto-signé

1. Créez un certificat auto-signé pour HTTPS :
   ```bash
   openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/passbolt-selfsigned.key -out /etc/ssl/certs/passbolt-selfsigned.crt -subj "/CN=passbolt.pharmgreen.com"
   ```
2. Configurez Nginx pour utiliser le certificat :
   ```bash
   apt install nginx
   nano /etc/nginx/sites-available/passbolt
   ```
   Ajoutez ou modifiez les lignes suivantes dans le fichier :
   ```nginx
   server {
       listen 443 ssl;
       server_name passbolt.pharmgreen.com;

       ssl_certificate /etc/ssl/certs/passbolt-selfsigned.crt;
       ssl_certificate_key /etc/ssl/private/passbolt-selfsigned.key;

       # Autres configurations...
   }
   ```
3. Testez et rechargez Nginx :
   ```bash
   nginx -t
   systemctl reload nginx
   ```

---

## Étape 4 : Mise à jour du système Debian

 Installez les dépendances nécessaires :
   ```bash
   apt install -y wget gnupg2 ca-certificates lsb-release software-properties-common curl
   ```

---

## Étape 5 : Configuration du dépôt Passbolt

1. Téléchargez le script d'installation des dépendances :
   ```bash
   curl -LO https://download.passbolt.com/ce/installer/passbolt-repo-setup.ce.sh
   ```
2. Téléchargez le fichier SHA512SUM pour vérifier l'intégrité du script :
   ```bash
   curl -LO https://github.com/passbolt/passbolt-dep-scripts/releases/latest/download/passbolt-ce-SHA512SUM.txt
   ```
3. Vérifiez l'intégrité du script et exécutez-le :
   ```bash
   sha512sum -c passbolt-ce-SHA512SUM.txt && sudo bash ./passbolt-repo-setup.ce.sh || echo "Bad checksum. Aborting" && rm -f passbolt-repo-setup.ce.sh
   ```
4. Mettez à jour les paquets :
   ```bash
   apt update
   ```
5. Installez Passbolt :
   ```bash
   apt install -y passbolt-ce-server
   ```

---

## Étape 6 : Configuration de Passbolt

1. Lancez le script de configuration de Passbolt :
   ```bash
   passbolt-ce-server-configure
   ```
2. Lorsque le script demande :
   - **Nom de domaine** : Entrez `passbolt.pharmgreen.com`.
   - **Configurer Nginx automatiquement ?** : Répondez **OUI** puis **NO** pour le certificat et entrer votre domaine.

---

## Étape 7 : Test et accès

1. Accédez à Passbolt depuis un navigateur à l'adresse :
   ```
   http://passbolt.pharmgreen.com
   ```
2. Acceptez le certificat auto-signé si nécessaire.

---

## Étape 8 : Configuration

1. Entrer les informations de la "Database" renseigné lors de l'installation:
   
![Capture d'écran 2025-01-15 164534](https://github.com/user-attachments/assets/91d517b4-bcac-4821-a21b-e8db546eef2e)

2. Entrer l'identifiant de la boîte mail dédié:

![Capture d'écran 2025-01-15 164643](https://github.com/user-attachments/assets/3bba5e99-661b-48c9-aa07-a09e59024fa5)

3. Entrer l'adresse de votre serveur:

![Capture d'écran 2025-01-15 164720](https://github.com/user-attachments/assets/c34dc844-42ee-492c-a50a-65db7ce1e725)

4. Vos coordonnées:

![Capture d'écran 2025-01-15 171625](https://github.com/user-attachments/assets/6c00c3d8-4222-4122-a452-62e25d9c42d0)

5. Les informations de la boîte mail dédié (configuration smtp):

![Capture d'écran 2025-01-15 171648](https://github.com/user-attachments/assets/4d131c2d-3891-4704-b123-6429bac5e650)

6. Il faut maintenant créer le premier utilisateur:
   
![Capture d'écran 2025-01-15 171729](https://github.com/user-attachments/assets/02a4a185-4094-4387-a52b-d8a866b7e652)

7. Il faut ensuite créer la phrase de sécurité:

![Capture d'écran 2025-01-15 172033](https://github.com/user-attachments/assets/71a34f46-3109-4700-bcbb-65c35b2b2fbb)

8. Et nous voilà connecté:

![Capture d'écran 2025-01-15 172123](https://github.com/user-attachments/assets/77f5c9dc-6356-46a2-bed1-871856175185)

---


