## Installation et Configuration de Graylog avec Elasticsearch sur Debian 12 (Bookworm)

### I. Préparatifs



**Prérequis machine** :
* Mémoire: prévoir suffisament de ram (8go environ)
* Prévoir surffisament de stockage (50go ernviron pour notre configuration)
* Prévoir suffisament de core pour le procésseur (2 pour nous)
* Pour Mongod, si vous travailler sur VM modifier le processuer en suivant cette procédure:
    - Clique sur "Edit" ou "Modifier" pour ajuster les paramètres du processeur.
    - Dans la section "CPU Model", sélectionne host comme modèle de CPU. Ce paramètre permet à la VM d'utiliser exactement le même modèle de processeur que celui de l'hôte physique,
      ce qui donne accès aux instructions avancées du processeur (comme AVX).

**Avant de commencer, mettez à jour la liste des paquets et installez les outils essentiels** :

```bash
apt update
apt install curl lsb-release ca-certificates gnupg2 pwgen -y
```

---

### II. Installation de Java (OpenJDK17)

1. **Installez OpenJDK 17** :

```bash
apt install openjdk-17-jre-headless -y
```

2. **Vérifiez que Java est installé correctement** :

```bash
java -version
```

### III. Installation de MongoDB

1. **Ajouter la clé GPG du dépôt MongoDB** :

```bash
curl -fsSL https://www.mongodb.org/static/pgp/server-6.0.asc |  gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg --dearmor
```

2. **Ajouter le dépôt MongoDB** :

```bash
echo "deb [signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg] http://repo.mongodb.org/apt/debian bullseye/mongodb-org/6.0 main" > /etc/apt/sources.list.d/mongodb-org-6.0.list
```

3. **Installer MongoDB** :

Mettez à jour la liste des paquets et installez MongoDB :

```bash
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.23_amd64.deb
dpkg -i libssl1.1_1.1.1f-1ubuntu2.23_amd64.deb
apt update
apt install -y mongodb-org
```

4. **Activer et démarrer MongoDB** :

```bash
systemctl daemon-reload
systemctl enable mongod.service
systemctl start mongod.service
systemctl --type=service --state=active | grep mongod
systemctl status mongod.service
```

MongoDB est maintenant installé et fonctionnel.

---

### III. Installation d’Elasticsearch

1. **Ajouter la clé GPG d'Elasticsearch** :

```bash
curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
```

2. **Ajouter le dépôt Elasticsearch** :

```bash
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" > /etc/apt/sources.list.d/elasticsearch-7.x.list
```

3. **Installer Elasticsearch** :

```bash
apt update
apt install -y elasticsearch
```

4. **Configurer Elasticsearch** :

Modifiez le fichier de configuration :

```bash
nano /etc/elasticsearch/elasticsearch.yml
```

Ajoutez ou modifiez les lignes suivantes :

```yaml
cluster.name: graylog
node.name: ${HOSTNAME}
discovery.type: single-node
network.host: 127.0.0.1
```

5. **Configurer la JVM** :

Modifiez le fichier de configuration :

```bash
nano /etc/elasticsearch/jvm.options
```

Adaptez les paramètres mémoire selon votre machine (exemple : 4 Go de RAM) :

```bash
-Xms4g
-Xmx4g
```

6. **Démarrer Elasticsearch** :

```bash
systemctl enable elasticsearch
systemctl start elasticsearch
```

---

### IV. Installation de Graylog

1. **Ajouter le dépôt Graylog** :

```bash
wget https://packages.graylog2.org/repo/packages/graylog-6.1-repository_latest.deb
apt install ./graylog-6.1-repository_latest.deb
apt update
```

2. **Installer Graylog** :

```bash
apt install -y graylog-server
```

3. **Configurer Graylog** :

Générez une clé secrète pour le stockage des mots de passe :

```bash
pwgen -N 1 -s 96
```

Copiez la clé générée, puis modifiez le fichier de configuration :

```bash
nano /etc/graylog/server/server.conf
```

Configurez les options suivantes :

```properties
password_secret = VOTRE_CLÉ_GÉNÉRÉE

```

Pour générer le hash du mot de passe admin :

```bash
echo -n "VotreMotDePasse" | shasum -a 256
```

Copiez le hash obtenu dans `root_password_sha2` et compléter:

```bash
nano /etc/graylog/server/server.conf
```

Configurez les options suivantes :

```properties
root_password_sha2 = HASH_SHA256_DE_VOTRE_MOT_DE_PASSE
http_bind_address = 0.0.0.0:9000
elasticsearch_hosts = http://127.0.0.1:9200
```

4. **Démarrer Graylog** :

```bash
systemctl enable graylog-server
systemctl start graylog-server
```

5. **Accéder à l’interface Web** :

Ouvrez un navigateur et accédez à :

```
http://<IP_DU_SERVEUR>:9000
```

Connectez-vous avec l’utilisateur `admin` et le mot de passe configuré.

---

### V. Vérifications Finales

- Assurez-vous que tous les services fonctionnent correctement :

```bash
systemctl status mongod
systemctl status elasticsearch
systemctl status graylog-server
```

- Consultez les journaux pour déboguer si nécessaire :

```bash
tail -f /var/log/graylog-server/server.log
```

Graylog est maintenant installé et fonctionnel sur votre serveur Debian 12 avec Elasticsearch !

