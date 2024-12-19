# Guide de Déploiement et de Configuration du Lab Complet

## Le Serveur Active Directory (AD)

Le serveur Active Directory est déployé sur une machine virtuelle exécutant Windows Server 2022. Voici les spécifications minimales et la configuration initiale requises :

- **Configuration minimale** :
  - 4 Go de RAM minimum.
  - Un disque dur de 50 Go minimum.
  - Connexion réseau via une carte liée au serveur pfSense, permettant l'accès à Internet sur le bon VLAN.

- **Étapes de configuration** :
  1. Attribuer une adresse IP fixe au serveur.
  2. Installer les services Active Directory Domain Services (ADDS).
  3. Créer le domaine `pharmgreen.com` et configurer le service DNS.

- **Gestion et configuration** :
  - Configuration et importation des [Unités d'Organisation (OU)](Server_AD/OU).
  - Importation et création des [utilisateurs](Server_AD/Utilisateur).
  - Mise en place des [stratégies de groupe (GPO)](Server_AD/GPO).
  - Gestion des [logs](Server_AD/Logs).

---

## Le Serveur de Fichiers

### À définir
(Compléter avec les étapes et les configurations spécifiques pour ce serveur.)

---

## Le Serveur GLPI

Le serveur GLPI est installé sur une machine virtuelle à base de Debian. Voici les étapes pour sa configuration :

- **Connexion réseau** :
  - Connecter le serveur GLPI au réseau via une carte réseau liée au serveur pfSense pour un accès Internet sur le bon VLAN.

- **Intégration et installation** :
  1. Intégrer le serveur GLPI au [domaine](#).
  2. Installer GLPI manuellement en suivant ce [guide](#).
  3. Option alternative : Installer GLPI via un [script dédié](Server_GLPI/USER_GUIDE_GLPI_SCRIPT.md).

- **Configuration** :
  - Configurer GLPI en suivant les instructions disponibles ici : [installation de GLPI](Server_GLPI/install_glpi.md).

---

## Le Serveur Core Redondance

Ce serveur est déployé sur une machine virtuelle exécutant Windows Server 2022 en mode Core. Voici les éléments essentiels à prendre en compte :

- **Connexion réseau** :
  - Connecter le serveur au réseau via une carte liée au serveur pfSense pour un accès Internet sur le bon VLAN.

- **Configuration** :
  - Intégrer et installer en suivant ce [lien](Server_Core_Redondance).

---

## Le Serveur pfSense

Le serveur pfSense est pré-installé et pré-configuré pour les besoins du lab. Voici les points principaux à vérifier ou ajuster :

- **Configuration du réseau** :
  - Paramétrer les VLANs et configurer les règles de pare-feu en suivant ce [guide](Server_pfsense).

---
