# Le Labo

Ce document sert de guide pour la mise en place, la configuration et la gestion des différents éléments du laboratoire informatique. Il détaille l'infrastructure mise en place, les adresses IP associées, les mots de passe utilisés, ainsi que les procédures de configuration pour chaque composant clé. Ce guide est conçu pour centraliser toutes les informations nécessaires au bon fonctionnement et à l'administration du labo.

## Infrastructure du Labo

Voici les composants mis en place pour le laboratoire :

- **Serveur Active Directory (AD)** : Gestion des utilisateurs et des politiques de groupe.
- **Serveur GLPI sous Debian** : Gestion de parc informatique et helpdesk.
- **Serveur Windows Core** : Assure la redondance du système.
- **Serveur pfSense** : Configure les fonctionnalités de routeur et de switch (via une VM sur Proxmox).
- **Client** : Utilisé pour paramétrer pfSense.

## Adresse IP de nos Serveurs

- **Serveur pfSense** : 10.15.255.254 ???
- **Serveur AD** : 10.15.0.36/27
- **Serveur GLPI** : 10.15.0.35/27
- **Serveur Core** (redondance) : 10.15.0.36/27
- **Serveur fichier** : 10.15.0.34/27

### Mots de passe

Les mots de passe utilisés pour les différentes machines :

- **Client** : `@zerty1*`
- **Serveurs** : `Azerty1*`

---

## Configurations

### Serveur Active Directory (AD)

<details>
<summary><b>Configuration du Serveur AD</b></summary>

- [Configuration des GPO]()
- [Création des utilisateurs]()
  - [Guide Utilisateur]()
  - [Script]()
- [Création des Unités Organisationnelles (OU)]()
  - [Guide Utilisateur]()
  - [Script]()
- [Gestion des journaux d’événements]()

</details>

### Serveur Windows Core

<details>
<summary><b>Configuration du Serveur Core</b></summary>

- [Mise en place de la redondance]()

</details>

### Serveur GLPI

<details>
<summary><b>Configuration du Serveur GLPI</b></summary>

- [Installation et configuration de GLPI]()
- [Installation automatisée par script]()

</details>

### Serveur pfSense

<details>
<summary><b>Configuration du Serveur pfSense</b></summary>

- [Configuration des VLANs]()

</details>

