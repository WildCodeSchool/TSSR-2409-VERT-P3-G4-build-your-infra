# Référentiel des Commandes Rsync et Leur Utilité

## **Introduction**
Ce document présente une liste des commandes et options disponibles avec Rsync, accompagnées d'une explication de leur utilité. Ce référentiel est conçu pour aider les administrateurs et utilisateurs à comprendre les fonctionnalités de Rsync et à les appliquer efficacement dans divers scénarios.

---

## **Commandes et Options Principales**

### 1. **Options de Base**

| Commande/Option        | Description                                                                                          |
|------------------------|------------------------------------------------------------------------------------------------------|
| `-a` (archive)         | Active un ensemble d'options pour préserver les permissions, les liens symboliques et les métadonnées. |
| `-v` (verbose)         | Affiche des informations détaillées pendant l'exécution.                                            |
| `-z` (compress)        | Compresse les fichiers pendant le transfert pour économiser la bande passante.                     |
| `-P`                   | Combine `--progress` et `--partial` pour afficher la progression et reprendre les transferts interrompus. |
| `--delete`             | Supprime les fichiers dans la destination qui n'existent plus dans la source.                       |
| `--dry-run`            | Simule l'exécution de Rsync sans effectuer de modifications. Utile pour tester une commande.        |
| `--progress`           | Affiche la progression des fichiers en cours de transfert.                                         |
| `--stats`              | Fournit un résumé détaillé des statistiques après l'exécution.                                     |

### 2. **Options Avancées**

| Commande/Option              | Description                                                                                     |
|------------------------------|-------------------------------------------------------------------------------------------------|
| `--exclude='pattern'`        | Exclut des fichiers ou répertoires correspondant au motif spécifié.                            |
| `--exclude-from=FILE`        | Exclut des fichiers ou répertoires listés dans un fichier.                                      |
| `--include='pattern'`        | Inclut uniquement les fichiers correspondant au motif spécifié.                                |
| `--bwlimit=RATE`             | Limite la bande passante utilisée par Rsync (en Kbps).                                         |
| `--checksum`                 | Compare les fichiers en utilisant leurs checksums au lieu des horodatages et tailles.          |
| `--link-dest=DIR`            | Utilisé pour les sauvegardes incrémentielles en créant des liens vers les fichiers inchangés.   |
| `--compare-dest=DIR`         | Compare les fichiers à un répertoire de référence pour les sauvegardes différentielles.        |
| `--backup`                   | Crée une copie de sauvegarde pour les fichiers qui seraient écrasés.                          |
| `--backup-dir=DIR`           | Définit un répertoire où seront stockées les copies de sauvegarde.                            |
| `--partial`                  | Garde les fichiers partiellement transférés pour pouvoir reprendre en cas d’interruption.      |
| `--hard-links`               | Préserve les liens physiques entre les fichiers.                                               |
| `--itemize-changes`          | Affiche une liste détaillée des changements effectués.                                         |

---

## **Exemples d'Utilisation**

### **1. Sauvegarde Locale**
Synchronisation entre deux répertoires sur la même machine :
```bash
rsync -avz /chemin/source/ /chemin/destination/
```
- Cette commande copie tous les fichiers du répertoire source vers le répertoire destination.

### **2. Transfert Distant avec SSH**
Transférer des fichiers vers ou depuis une machine distante :
- **Depuis un serveur distant vers local :**
  ```bash
  rsync -avz user@remote:/chemin/source/ /chemin/local-destination/
  ```
- **Depuis local vers un serveur distant :**
  ```bash
  rsync -avz /chemin/source/ user@remote:/chemin/destination/
  ```

### **3. Sauvegarde avec Suppression des Fichiers Obsolètes**
Synchroniser en supprimant les fichiers qui ne sont plus présents dans la source :
```bash
rsync -avz --delete /source/ /destination/
```

### **4. Exclusion de Fichiers**
Ignorer certains fichiers ou répertoires pendant la synchronisation :
```bash
rsync -avz --exclude='*.tmp' --exclude='cache/' /source/ /destination/
```

### **5. Sauvegarde Incrémentielle avec Versionnement**
Créer des sauvegardes incrémentielles en conservant un historique daté :
```bash
rsync -avz /source/ /destination/$(date +%Y-%m-%d)/
```

### **6. Limitation de la Bande Passante**
Limiter la vitesse du transfert à 1 Mbps :
```bash
rsync -avz --bwlimit=1000 /source/ /destination/
```

### **7. Test de Commande avec `--dry-run`**
Simuler une synchronisation sans modifier les fichiers :
```bash
rsync -avz --dry-run /source/ /destination/
```

### **8. Sauvegarde Différentielle**
Copier uniquement les fichiers modifiés depuis une sauvegarde complète :
```bash
rsync -avz --compare-dest=/chemin/backup-complete/ /source/ /destination/
```

---

## **Conseils pour l’Utilisation de Rsync**
1. **Toujours tester avec `--dry-run`** : Avant d’exécuter une commande critique, utilisez cette option pour éviter les erreurs.
2. **Créer des fichiers d’exclusion** : Facilitez la gestion des exclusions avec un fichier dédié (`exclude.txt`).
3. **Automatiser avec Cron** : Planifiez des sauvegardes régulières avec des tâches cron.
4. **Vérifier les logs** : Conservez un historique des opérations en redirigeant la sortie vers un fichier de log :
   ```bash
   rsync -avz /source/ /destination/ >> /var/log/rsync.log 2>&1
   ```

---

## **Conclusion**
Ce référentiel regroupe les commandes essentielles et leurs applications pratiques pour vous aider à maîtriser Rsync. Grâce à ses nombreuses options, Rsync s'adapte à une variété de scénarios, des sauvegardes simples aux synchronisations complexes. Prenez le temps d’expérimenter avec ces commandes pour en tirer le meilleur parti.

