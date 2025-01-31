# Le Labo

Ce document sert de guide pour la mise en place, la configuration et la gestion des différents éléments du laboratoire informatique. Il détaille l'infrastructure mise en place, les adresses IP associées, les mots de passe utilisés, ainsi que les procédures de configuration pour chaque composant clé. Ce guide est conçu pour centraliser toutes les informations nécessaires au bon fonctionnement et à l'administration du labo.

## Infrastructure du Labo

Voici les composants mis en place pour le laboratoire :

- **Serveur Active Directory (AD)** : Gestion des utilisateurs, des GPO, des OUs, du DNS et du DHCP
- **Serveur Windows Core** : Assure la redondance du système.
- **Serveur WSUS**: Automatisation des MAJ sur les machines (serveur et pc) du domaine
- **Serveur GLPI** : Gestion de parc informatique et helpdesk.
- **Serveur Graylog** : Centralisation des logs de nos serveurs
- **Serveur pfSense** : Configure les fonctionnalités de routeur et de switch (via une VM sur Proxmox).
- **Serveur de fichier** : Centralise tous les dossiers partagés des utilisateurs et donne accés aux utilisateurs en fonctions des règles de sécurité.
- **Serveur Rsync** : Permet de sauvegarder tous les dossier utilisateurs (personnel, départements et services).
- **Serveur ZABBIX** : Permet la surveillance de pfsense.
- **Serveur Mail**: Permet l'envoi et la reception de courrier électronique.
- **Serveur Freepbx**: Gère la VOIP.
- **Serveur PASSBOLT**: Protège et stock les MDP
- **Serveur Guacamole**: Permet de centraliser la connexion distante à nos serveur et ceux de notre partenaire.
- **Clients** : Permet de simulés des utilisateurs.

## Adresse Ip de nos Serveurs

- **Serveur pfsense**: 10.15.255.254 ???
- **Serveur fichier**: 10.15.0.34/27
- **Serveur GLPI - GRAYLOG**: 10.15.0.35/27
- **Serveur AD**: 10.15.0.36/27
- **Serveur Zabbix**: 10.15.0.37/27
- **Serveur Rsync**: 10.15.0.38/27
- **Serveur Core**(redondance): 10.15.0.39/27
- **Serveur Mail**: 10.15.0.40/27
- **Serveur Freepbx**: 10.15.0.41/27
- **Serveur WSUS**: 10.15.0.42/27
- **Serveur PASSBOLT**: 10.15.0.43/27

- **Serveur Web**: 10.15.6.2/24
- **Serveur Guacamole**: 10.15.7.2/24

### Mots de passe

Les mots de passe utilisés pour les différentes machines :

- **Client** : `@zerty1*` ou `@zerty` (1er mot de passe à changer au démarrage `Azerty1*`)
- **Serveurs** : `Azerty1*`

---
