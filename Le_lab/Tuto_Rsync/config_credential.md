# Tutoriel Complet : Sauvegarde Incrémentielle (Credential-Based Backup) avec Rsync

## **Introduction**
Ce tutoriel explique comment configurer une sauvegarde incrémentielle (basée sur les différences entre la source et la destination) en utilisant **rsync** sur un serveur Linux Debian. Cette méthode repose sur le comportement par défaut d'rsync pour les sauvegardes incrémentielles, qui permet de copier uniquement les fichiers modifiés ou nouveaux depuis la dernière sauvegarde.

---

## **1. Préparation sur le Client Windows**

### 1.1 Création et partage d’un dossier
1. Sur le client Windows, créez le dossier que vous souhaitez sauvegarder, par exemple : `C:\Partage`.
2. Faites un clic droit sur le dossier > **Propriétés** > Onglet **Partage** > **Partager…**.
3. Ajoutez un utilisateur ou choisissez "Tout le monde".
4. Donnez des droits **Lecture/\u00c9criture** à l'utilisateur.
5. Notez le chemin réseau du partage, par exemple : `\\10.15.0.34\Partage`.

### 1.2 Vérification du partage
1. Testez l'accès à partir d'un autre ordinateur avec les identifiants configurés.

---

## **2. Préparation sur le Serveur Debian**

### 2.1 Installer les outils nécessaires
1. Installez rsync et les outils pour monter les partages Windows :
   ```bash
   apt update && apt install -y cifs-utils rsync
   ```

### 2.2 Configuration du répertoire de sauvegarde
1. Créez un répertoire pour stocker les sauvegardes incrémentielles :
   ```bash
   mkdir -p /mnt/backup/windows-client
   ```
2. Attribuez les permissions :
   ```bash
   chown root:root /mnt/backup
   chmod 755 /mnt/backup
   ```

### 2.3 Création d’un utilisateur pour la sauvegarde
1. Créez un utilisateur dédié :
   ```bash
   adduser rsyncuser
   ```
   - Définissez un mot de passe.

2. Assurez-vous que l’utilisateur a accès au répertoire de sauvegarde :
   ```bash
   chown rsyncuser:rsyncuser /mnt/backup/windows-client
   chmod 750 /mnt/backup/windows-client
   ```

---

## **3. Monter le partage Windows**

### 3.1 Monter le partage réseau
1. Créez un point de montage :
   ```bash
   mkdir -p /mnt/windows-share
   ```
2. Montez le partage Windows :
   ```bash
   mount -t cifs //10.15.0.34/Partage /mnt/windows-share -o username=Administrator,password=Azerty1*,uid=rsyncuser,gid=rsyncuser
   ```
   - Remplacez `10.15.0.34` et `Partage` par les valeurs appropriées.

3. Testez le montage :
   ```bash
   ls -l /mnt/windows-share
   ```

### 3.2 Automatiser le montage
Ajoutez une ligne dans `/etc/fstab` pour monter automatiquement au démarrage :
```plaintext
//10.15.0.34/Partage /mnt/windows-share cifs username=Administrator,password=Azerty1*,uid=rsyncuser,gid=rsyncuser 0 0
```

---

## **4. Configuration de la sauvegarde incrémentielle**

### 4.1 Commande manuelle
1. Exécutez la commande suivante pour effectuer une sauvegarde incrémentielle :
   ```bash
   rsync -avz /mnt/windows-share/ /mnt/backup/windows-client/
   ```
   - Cette commande copie uniquement les fichiers nouveaux ou modifiés depuis la dernière exécution.

### 4.2 Options supplémentaires
- **Exclure certains fichiers ou dossiers** :
  Créez un fichier `exclude.txt` :
  ```plaintext
  fichier-temporaire.txt
  dossier-a-exclure/
  ```
  Utilisez l'option `--exclude-from` :
  ```bash
  rsync -avz --exclude-from=/chemin/exclude.txt /mnt/windows-share/ /mnt/backup/windows-client/
  ```
- **Conserver les logs** :
  ```bash
  rsync -avz /mnt/windows-share/ /mnt/backup/windows-client/ >> /var/log/rsync.log 2>&1
  ```

---

## **5. Automatisation avec Cron**

### 5.1 Configuration de cron
1. Ouvrez crontab :
   ```bash
   crontab -e
   ```
2. Ajoutez une tâche planifiée pour la sauvegarde incrémentielle, par exemple :
   - Tous les jours à minuit :
     ```plaintext
     0 0 * * * rsync -avz /mnt/windows-share/ /mnt/backup/windows-client/ >> /var/log/rsync.log 2>&1
     ```

   Autre exemple:
   
   - Toutes les 6 heures :
     ```plaintext
     0 */6 * * * rsync -avz /mnt/windows-share/ /mnt/backup/windows-client/ >> /var/log/rsync.log 2>&1
     ```

### 5.2 Vérification
1. Assurez-vous que la tâche est ajoutée :
   ```bash
   crontab -l
   ```
2. Consultez les logs pour vérifier l’exécution :
   ```bash
   cat /var/log/rsync.log
   ```

---

## **6. Restaurer une sauvegarde**
Pour restaurer une sauvegarde incrémentielle :
1. Montez le partage Windows cible.
2. Exécutez rsync pour restaurer les fichiers :
   ```bash
   rsync -avz /mnt/backup/windows-client/ /mnt/windows-share/
   ```

---

## **Conclusion**
Vous avez configuré une sauvegarde incrémentielle avec rsync, qui permet une synchronisation efficace des données en ne transférant que les modifications. Cette solution est idéale pour des sauvegardes fréquentes tout en minimisant l’utilisation des ressources. Vous pouvez ajuster la fréquence et les options selon vos besoins.

