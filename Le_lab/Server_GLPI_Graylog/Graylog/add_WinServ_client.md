# Configuration d'un client Windows Server pour envoyer des logs vers Graylog

Ce tutoriel explique comment configurer un serveur Windows pour envoyer ses logs à Graylog en utilisant **NXLog Community Edition** ou **WinSyslog**. Ces outils permettent de transmettre les journaux d'événements Windows au serveur Graylog.

---

## **Prérequis**

- Un serveur Graylog fonctionnel avec une entrée configurée (par exemple, Syslog TCP/UDP ou GELF TCP/UDP).
- L'adresse IP et le port de l'entrée configurée dans Graylog.
- Accès administrateur sur le client Windows.

---

## **Option 1 : Utiliser NXLog Community Edition**

### **Étape 1 : Télécharger et installer NXLog**

1. Téléchargez NXLog Community Edition depuis le site officiel :
   [https://nxlog.co/products/nxlog-community-edition](https://nxlog.co/products/nxlog-community-edition).

2. Installez le logiciel en suivant les instructions.
   - Lors de l'installation, utilisez les paramètres par défaut.

3. Une fois installé, ouvrez le fichier de configuration NXLog :
   ```
   C:\Program Files\nxlog\conf\nxlog.conf
   ```

---

### **Étape 2 : Configurer NXLog pour envoyer les logs à Graylog**

1. **Modifiez la section `output` dans `nxlog.conf`** :
   - Configurer une section Input pour capturer les logs Windows : Ajoutez cette section au fichier
   ```
   <Input eventlog>
    Module      im_msvistalog
   </Input>
   ```

   - Trouvez ou ajoutez une section similaire à ceci :
     ```
     <Output graylog>
         Module      om_udp
         Host        <IP_DU_SERVEUR_GRAYLOG>
         Port        <PORT_DE_L_INPUT>
         Exec        to_syslog_snare()
     </Output>
     ```
     - Remplacez `<IP_DU_SERVEUR_GRAYLOG>` par l'adresse IP du serveur Graylog.
     - Remplacez `<PORT_DE_L_INPUT>` par le port configuré dans Graylog (par exemple, `514` pour UDP).

   

2. **Ajoutez une section `route` pour connecter les logs Windows** :
   ```
   <Route 1>
       Path        internal, eventlog => graylog
   </Route>
   ```

3. **Sauvegardez le fichier de configuration** et redémarrez le service NXLog :
   ```
   net stop nxlog
   net start nxlog
   ```

---

## **Étape 3 : Tester l'envoi des logs**

1. **Générez un événement Windows pour test** :
   - Par exemple, arrêtez et redémarrez un service via **services.msc**.

2. **Vérifiez sur Graylog** :
   - Connectez-vous à l'interface web de Graylog.
   - Allez dans **Search**.
   - Recherchez les logs émis par le client Windows (vous pouvez filtrer par IP ou par message).

---

## **Étape 4 : Dépannage**

1. **Vérifiez les logs de l'agent** :
   - Pour NXLog, consultez les journaux ici :
     ```
     C:\Program Files (x86)\nxlog\data\nxlog.log
     ```
   - Pour WinSyslog, vérifiez les journaux dans l'application elle-même.

2. **Tester la connectivité** :
   - Utilisez `telnet` pour vérifier la connexion au serveur Graylog :
     ```
     telnet <IP_DU_SERVEUR_GRAYLOG> <PORT_DE_L_INPUT>
     ```

3. **Vérifier les Inputs dans Graylog** :
   - Assurez-vous que l'entrée configurée dans Graylog est active.

---

Votre client Windows est maintenant configuré pour envoyer ses logs vers Graylog. 
