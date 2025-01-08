# Tutoriel Complet : Mise en Place d'un RAID 1 et LVM sur un Serveur Debian

Ce guide détaille les étapes pour configurer un RAID 1 (redondance) et un système de gestion de volumes logiques (LVM) sur un serveur Debian. Cette configuration offre une meilleure tolérance aux pannes et une gestion flexible de l'espace disque.

---

## **1. Configuration du RAID 1 sur Debian**

### 1.1 Préparer les Disques

1. Identifiez les disques à utiliser pour le RAID :
   ```bash
   lsblk
   ```
   - Notez les noms des disques (par exemple, `/dev/sdb` et `/dev/sdc`).

2. Supprimez les partitions existantes (si nécessaire) :
   ```bash
   fdisk /dev/sdb
   ```
   - Tapez `d` pour supprimer une partition.
   - Répétez l’opération pour toutes les partitions.
   - Répétez pour le disque `/dev/sdc`.

### 1.2 Installer les Outils RAID

Installez l’outil MDADM :
```bash
apt update && apt install -y mdadm
```

### 1.3 Créer un RAID 1

1. Créez le RAID 1 avec les disques :
   ```bash
   mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdb /dev/sdc
   ```
   - `/dev/md0` : le périphérique RAID créé.
   - `--level=1` : configuration en miroir (RAID 1).
   - `--raid-devices=2` : nombre de disques dans le RAID.

2. Vérifiez l'état du RAID :
   ```bash
   cat /proc/mdstat
   ```
   - La synchronisation peut prendre du temps selon la taille des disques.

3. Sauvegardez la configuration RAID :
   ```bash
   mdadm --detail --scan >> /etc/mdadm/mdadm.conf
   ```

4. Mettre à jour l'initramfs pour que la configuration soit prise en charge au démarrage :
   ```bash
   update-initramfs -u
   ```

---

## **2. Configuration de LVM sur le RAID**

### 2.1 Installer les Outils LVM

Installez le package LVM2 :
```bash
apt install -y lvm2
```

### 2.2 Créer un Volume Physique LVM

1. Initialisez le RAID comme un volume physique LVM :
   ```bash
   pvcreate /dev/md0
   ```

2. Vérifiez que le volume physique a été créé :
   ```bash
   pvdisplay
   ```

### 2.3 Créer un Groupe de Volumes

1. Créez un groupe de volumes nommé `vg_backup` :
   ```bash
   vgcreate vg_backup /dev/md0
   ```

2. Vérifiez le groupe de volumes :
   ```bash
   vgdisplay
   ```

### 2.4 Créer un Volume Logique

1. Créez un volume logique nommé `lv_backup` d'une taille de 100 Go :
   ```bash
   lvcreate -L 100G -n lv_backup vg_backup
   ```
   - Remplacez `100G` par la taille souhaitée 

2. Vérifiez le volume logique :
   ```bash
   lvdisplay
   ```

### 2.5 Formater et Monter le Volume Logique

1. Formatez le volume logique en ext4 :
   ```bash
   mkfs.ext4 /dev/vg_backup/lv_backup
   ```

2. Créez un point de montage :
   ```bash
   mkdir -p /mnt/backup
   ```

3. Montez le volume logique :
   ```bash
   mount /dev/vg_backup/lv_backup /mnt/backup
   ```

4. Ajoutez le point de montage au fichier `/etc/fstab` pour qu’il soit monté automatiquement au démarrage :
   ```plaintext
   /dev/vg_backup/lv_backup /mnt/backup ext4 defaults 0 0
   ```

5. Vérifiez que le volume est monté :
   ```bash
   df -h
   ```

---

## **3. Vérification Finale**

1. Vérifiez l'état du RAID :
   ```bash
   mdadm --detail /dev/md0
   ```

2. Vérifiez les volumes LVM :
   ```bash
   lvdisplay
   ```

3. Vérifiez le montage automatique :
   Redémarrez le serveur et assurez-vous que le volume est monté :
   ```bash
   df -h
   ```

---

## **Conclusion**

Avec ce tutoriel, vous avez configuré un RAID 1 pour la redondance des données et LVM pour une gestion flexible de l’espace disque. Cette configuration peut servir de base pour des systèmes de sauvegarde robustes ou d’autres applications nécessitant fiabilité et évolutivité.

