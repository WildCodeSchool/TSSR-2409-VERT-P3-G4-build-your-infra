# Configuration d'un client Linux pour envoyer des logs vers Graylog

Ce tutoriel explique comment configurer un client Linux pour envoyer ses logs à Graylog en utilisant **rsyslog**. Ce processus inclut l'installation et la configuration de rsyslog, ainsi que la vérification des logs sur le serveur Graylog.

---

## **Prérequis**

- Un serveur Graylog fonctionnel avec une entrée configurée (par exemple, Syslog UDP/TCP).
- L'adresse IP et le port de l'entrée configurée dans Graylog.
- Un client Linux avec **rsyslog** installé (généralement préinstallé sur les distributions modernes).

---

## **Étape 1 : Installer rsyslog (si non installé)**

1. Vérifiez si rsyslog est déjà installé :
   ```bash
   rsyslogd -v
   ```
2. Si rsyslog n'est pas installé, installez-le :
   - **Debian/Ubuntu** :
     ```bash
     apt update && apt install -y rsyslog
     ```
   - **RedHat/CentOS** :
     ```bash
     yum install -y rsyslog
     ```

3. Activez et démarrez le service rsyslog :
   ```bash
   systemctl enable rsyslog
   systemctl start rsyslog
   ```

---

## **Étape 2 : Configurer rsyslog pour envoyer les logs à Graylog**

1. **Modifier la configuration rsyslog** :
   - Ouvrez le fichier de configuration principal de rsyslog :
     ```bash
     nano /etc/rsyslog.conf
     ```

2. **Ajouter une règle pour envoyer les logs à Graylog** :
   - Ajoutez cette ligne à la fin du fichier :
     ```bash
     *.* @<IP_DU_SERVEUR_GRAYLOG>:<PORT_DE_L_INPUT>
     ```
     - Pour **UDP**, utilisez `@`.
     - Pour **TCP**, utilisez `@@`.
     - Remplacez `<IP_DU_SERVEUR_GRAYLOG>` par l'adresse IP du serveur Graylog.
     - Remplacez `<PORT_DE_L_INPUT>` par le port configuré dans Graylog (par exemple, `514`).

3. **Sauvegarder et quitter** :
   - Sauvegardez le fichier avec `Ctrl + O`, puis quittez avec `Ctrl + X`.

4. **Redémarrer rsyslog** :
   ```bash
   systemctl restart rsyslog
   ```

---

## **Étape 3 : Tester l'envoi des logs**

1. **Envoyer un message de test** :
   ```bash
   logger -n <IP_DU_SERVEUR_GRAYLOG> "Ceci est un message de test depuis le client Linux"
   ```

2. **Vérifier sur Graylog** :
   - Connectez-vous à l'interface web de Graylog.
   - Allez dans **Search**.
   - Recherchez le message de test envoyé (éventuellement en filtrant par source avec l'adresse IP du client).

---

## **Étape 4 : Personnalisation de la configuration rsyslog**

Vous pouvez affiner les logs envoyés à Graylog en modifiant les filtres rsyslog.

1. **Envoyer uniquement certains types de logs** :
   - Par exemple, pour envoyer uniquement les logs de niveau "error" :
     ```bash
     *.error @<IP_DU_SERVEUR_GRAYLOG>:<PORT_DE_L_INPUT>
     ```

2. **Envoyer les logs d’un fichier spécifique** :
   - Par exemple, pour envoyer les logs d’Apache :
     ```bash
     if $programname == 'apache2' then @<IP_DU_SERVEUR_GRAYLOG>:<PORT_DE_L_INPUT>
     & stop
     ```

3. **Redémarrer rsyslog après chaque modification** :
   ```bash
   systemctl restart rsyslog
   ```

---

## **Étape 5 : Surveillance et dépannage**

1. **Vérifier les logs de rsyslog (sur le client)** :
   ```bash
   tail -f /var/log/syslog
   ```

2. **Vérifier les logs sur Graylog** :
   - Allez dans **System / Inputs** pour vous assurer que l’entrée est active.
   - Consultez les logs dans **Search**.

3. **Tester avec tcpdump (optionnel)** :
   - Vérifiez si les logs sont envoyés au serveur Graylog :
     ```bash
     tcpdump -i eth0 host <IP_DU_SERVEUR_GRAYLOG> and port <PORT_DE_L_INPUT>
     ```

---

Votre client Linux est maintenant configuré pour envoyer ses logs à Graylog. Vous pouvez personnaliser davantage la configuration selon vos besoins. 😊
