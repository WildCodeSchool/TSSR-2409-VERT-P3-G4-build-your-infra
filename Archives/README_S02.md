# Objectifs de la semaine

## Avancement en fin de semaine

![S2](https://github.com/user-attachments/assets/ffe34a18-58c0-49fc-93ac-c902926ee059)


## Principaux 

1. AD-DS - Création d'un domaine AD
	1. Un serveur Windows Server 2022 GUI avec les rôles AD-DS, DHCP, DNS
	2. Un serveur Windows Server 2022 Core avec le rôle AD-DS
	3. Les 2 serveurs sont des DC du domaine et ont une réplication complète gérée
2. AD-DS - Gestion de l'arborescence AD
	1. Création des OU
		1. Gestion manuelle / automatique par script PowerShell
	2. Création des groupes
		1. Gestion manuelle / automatique par script PowerShell
3. AD-DS - Intégration des utilisateurs
	1. Selon le fichier des utilisateurs :
		1. Création des comptes
		2. Placement dans les groupes correspondant
		3. Placement dans les OU de departements/services
		4. Gestion des managers
	2. Gestion manuelle / automatique par script PowerShell
4. Création d'une VM Serveur Linux Debian
	1. VM ou CT en CLI
	2. Sur le domaine AD-DS
	3. Accessible en SSH par un groupe d'administrateurs du domaine
	4. Gestion manuelle / automatique par script shell Bash

# 2. Réseau (sous Proxmox)

Suite erreurs de documents, le réseau devra être sur cette plage :
Adresse IP de réseau : 10.15.0.0/16
Adresse de passerelle : 10.15.255.254
Adresse IP DNS : 10.15.255.254
