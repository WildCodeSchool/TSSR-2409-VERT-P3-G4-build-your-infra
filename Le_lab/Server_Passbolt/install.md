# Guide d'installation de Passbolt en local sur Debian 12

Ce guide détaille toutes les étapes pour installer et configurer Passbolt sur un serveur Debian 12 en local.

---

## Prérequis

1. Un serveur Debian 12 sur Proxmox.
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

5. Si vous utilisez un routeur comme pfSense pour la gestion DNS locale :
   - Allez dans **Services > DNS Resolver > Overrides**.
   - Ajoutez une nouvelle entrée DNS Override :
     - **Host** : `passbolt`.
     - **Domain** : `pharmgreen.com`.
     - **IP Address** : L'adresse IP locale du serveur passbolt.
   - Sauvegardez et appliquez les changements.

---

## Étape 1 bis : Configuration DNS sur le serveur Debian

1. Éditez le fichier `/etc/resolv.conf` pour configurer le serveur DNS local :
   ```bash
   nano /etc/resolv.conf
   ```

2. Ajoutez ou modifiez les lignes suivantes :
   ```
   nameserver <IP-DU-SERVEUR-DNS-LOCAL>
   search pharmgreen.com
   ```
   - **<IP-DU-SERVEUR-DNS-LOCAL>** : Adresse IP du serveur DNS (par exemple, le serveur Active Directory ou pfSense).
   - `search pharmgreen.com` permet de compléter automatiquement les noms courts (par exemple, taper `passbolt` au lieu de `passbolt.pharmgreen.com`).

3. Sauvegardez et fermez le fichier.

4. Testez la résolution DNS avec le domaine local :
   ```bash
   ping passbolt.pharmgreen.com
   ```

5. Pour rendre les modifications permanentes si le fichier `/etc/resolv.conf` est géré dynamiquement (par exemple par **systemd-resolved**) :
   - Modifiez `/etc/systemd/resolved.conf` :
     ```bash
     nano /etc/systemd/resolved.conf
     ```
   - Ajoutez ou modifiez les lignes suivantes :
     ```ini
     [Resolve]
     DNS=<IP-DU-SERVEUR-DNS-LOCAL>
     Domains=pharmgreen.com
     ```
   - Redémarrez le service :
     ```bash
     systemctl restart systemd-resolved
     ```

# Etape 1 bis bis Configuration des DNS statiques via le client DHCP

Si votre machine utilise DHCP pour obtenir une adresse IP, les paramètres DNS sont souvent réécrits par le client DHCP. Cette méthode permet de configurer des DNS statiques sans modifier directement le fichier `/etc/resolv.conf`.

---

## Identifier le fichier de configuration DHCP
1. Recherchez le fichier de configuration utilisé par votre client DHCP. Les fichiers courants sont :
   - `/etc/dhcp/dhclient.conf` (client DHCP standard).
   - `/etc/dhcpcd.conf` (autre implémentation courante).

   Si vous utilisez `dhclient` :
   ```bash
   nano /etc/dhcp/dhclient.conf
   ```

   Si vous utilisez `dhcpcd` :
   ```bash
   nano /etc/dhcpcd.conf
   ```

---

## Ajouter une configuration DNS statique
1. Ouvrez le fichier correspondant (par exemple, `/etc/dhcp/dhclient.conf`).
2. Recherchez la section où vous pouvez ajouter les paramètres DNS.
3. Ajoutez ou modifiez les lignes suivantes :

   Pour **`dhclient.conf`** :
   ```
   supersede domain-name-servers <IP-DU-SERVEUR-DNS-LOCAL>;
   supersede domain-name "pharmgreen.com";
   ```

   Pour **`dhcpcd.conf`** :
   ```
   static domain_name_servers=<IP-DU-SERVEUR-DNS-LOCAL>
   static domain_name="pharmgreen.com"
   ```

   Remplacez `<IP-DU-SERVEUR-DNS-LOCAL>` par l'adresse IP de votre serveur DNS local.

---

## Redémarrer le service DHCP
1. Appliquez les changements en redémarrant le service DHCP ou les interfaces réseau :
   ```bash
   sudo systemctl restart networking
   ```

2. Vérifiez que les nouveaux paramètres DNS sont pris en compte :
   ```bash
   cat /etc/resolv.conf
   ```
   Vous devriez voir l'adresse IP définie dans `supersede domain-name-servers`.

---

## Tester la configuration
1. Testez la résolution DNS pour vérifier si le serveur DNS statique fonctionne :
   ```bash
   ping passbolt.pharmgreen.com
   nslookup passbolt.pharmgreen.com
   ```

Si les tests réussissent, vos paramètres DNS statiques sont correctement configurés ! 


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

1. Mettez à jour les paquets :
   ```bash
   apt update && apt upgrade -y
   ```
2. Installez les dépendances nécessaires :
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
   - **Configurer Nginx automatiquement ?** : Répondez **No**.
   - Configurez les autres paramètres (base de données, etc.) selon vos besoins.

---

## Étape 7 : Test et accès

1. Accédez à Passbolt depuis un navigateur à l'adresse :
   ```
   https://passbolt.pharmgreen.com
   ```
2. Acceptez le certificat auto-signé si nécessaire.

---

## Étape 8 : Création de l'utilisateur administrateur

1. Une fois Passbolt accessible, suivez les instructions pour créer le premier utilisateur administrateur via l'interface web.

---


