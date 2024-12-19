# Guide de déploiement et de configuration du Lab complet


## Le serveur AD

Le serveur est installé sur une Vm Windows server 2022 équipé de 4go de ram minimum, un DD de 50Go minimum et connecté sur le réseau via une carte réseau relié au serveur pfsense lui donnant accés à internet via le bon Vlan.

- Configuration IP fixe + installation Service ADDS et création du DC pharmgreen.com et service DNS

- Configuration et importation [OU](Le_lab/Server_AD/OU)
- Importation et création des [Utilisateurs](Le_Lab/Server=AD/Utilisateur)
- Configurations des [GPO]()
- Gestion des [Logs]()

## Le serveur de Fichier

## Le serveur GLPI

Le serveur GLPI est installer sur une Vm Débian et il est connecté sur le réseau via une carte réseau relié au serveur pfsense lui donnant accés à internet via le bon Vlan.

- On intègre le serveur au [Domaine]()
- On installe le serveur [GLPI en manuel] ou on installe [GLPI via script]
- On configure le serveur [GLPI]()

## Le serveur Core Redondance

Le serveur pour la redondance est installer sur une vm windows serveur 2022 en mode CORE et il est connecté sur le réseau via une carte réseau relié au serveur pfsense lui donnant accés à internet via le bon Vlan.

- Intégration et installation en suivant ce [lien]()

## Le serveur Pfsense

Le serveur Pfsense nous est livré déjà installé et paramétré.

- [Paramétrage des Vlan et configuration des Firewalls]()