# Configuration d'une Entrée (Input) dans Graylog

Une **Input** dans Graylog est un point d'entrée permettant de collecter des logs provenant de diverses sources. Voici comment configurer une entrée pour recevoir des logs.

---

## Étape 1 : Accéder à l'interface de gestion des Inputs
1. Connectez-vous à l'interface web de Graylog :
   ```
   http://<IP_DU_SERVEUR>:9000
   ```
2. Naviguez vers **System / Inputs** dans le menu principal.

---

## Étape 2 : Choisir le type d'Input
1. Dans le menu **Select Input**, choisissez le type d'Input que vous souhaitez créer.
   - Exemple : **Syslog UDP** (souvent utilisé pour les logs système).
2. Cliquez sur **Launch new input**.

---

## Étape 3 : Configurer l'Input
1. Dans la fenêtre qui s'ouvre :
   - **Node** : Choisissez le nœud où l'entrée doit être active (éventuellement "Local node").
   - **Title** : Donnez un nom à l'entrée (exemple : `Syslog UDP Input`).
   - **Bind address** :
     - Laissez `0.0.0.0` pour que Graylog écoute sur toutes les interfaces.
     - Vous pouvez aussi spécifier une adresse IP particulière si nécessaire.
   - **Port** : Indiquez un port disponible (par exemple, `514` pour Syslog).
2. Cliquez sur **Save**.

---

## Étape 4 : Vérifier que l'Input est active
1. Retournez à la page **System / Inputs**.
2. Assurez-vous que l’Input apparaît avec le statut **running**.

---

## Conseils
- Si plusieurs clients doivent envoyer des logs à cette entrée, utilisez le **même port** pour tous.
- Pour organiser les logs par client, utilisez les **streams** et **extracteurs** disponibles dans Graylog.

---

Vous avez maintenant configuré une entrée pour recevoir des logs dans Graylog ! Vous pouvez passer à la configuration des expéditeurs de logs (serveurs, routeurs, etc.).
