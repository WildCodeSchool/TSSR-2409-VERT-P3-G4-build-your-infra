# Objectifs de la semaine

## Avancement en fin de semaine

![Capture d'écran 2025-01-31 104701](https://github.com/user-attachments/assets/7b6604ed-cd9d-4779-aa14-40fd8cc9627a)

## Principaux 

1. DOSSIERS PARTAGES - Mettre en place des dossiers réseaux pour les utilisateurs
	1. Stockage des données sur un volume spécifique
	2. Sécurité de partage des dossiers par groupe AD
	3. Mappage des lecteurs sur les clients (au choix) :
		1. GPO
		2. Script PowerShell/batch
		3. Profil utilisateur AD
	4. Chaque utilisateur a accès à :
		1. Un **dossier individuel** , avec une lettre de mappage réseau **I**, accessible uniquement par cet utilisateur
		2. Un **dossier de service**, avec une lettre de mappage réseau **J**, accessible par tous les utilisateurs d'un même service.
		3. Un **dossier de département**, avec une lettre de mappage **K**, accessible par tous les utilisateurs d'un même département.

2. STOCKAGE AVANCÉ - Mettre en place du RAID 1 sur un serveur et/ ou Mettre en place LVM sur un serveur Debian

3. SAUVEGARDE - Mettre en place une sauvegarde de données
	1. Faire le bon choix des données à sauvegarder (ex.: dossiers partagés des utilisateurs)
	2. Emplacement de la sauvegarde sur un disque différents de celui des données d'origine
	3. Mettre en place une planification de sauvegarde (script, AT, GPO, logiciel, etc.)

4. Optimisation de l'infrastructure réseau
Chaque éléments de l'infrastructure :
- Doit disposer d'une documentation fonctionnelle et à jour :
	- Prérequis matériel/logiciel
	- Version d'OS, de logiciel, ...
	- Installation :
		- Suivi pas-à-pas avec copie d'écran
		- Copie d'écran du résultat attendu
	- Configuration/Utilisation :
		- Cible
		- Suivi pas-à-pas avec copie d'écran
- Doit être optimisé :
	- Optimisation dans le choix du hardware
	- MAJ système régulière
- Doit pouvoir être restauré rapidement en cas de défaillance :
	- Clone miroir
	- Script de restauration complet ou partiel d'OS
	- Script de restauration de configuration
	- Doc à jour

## Secondaires

5. MOT DE PASSE ADMINISTRATEUR LOCAL - Mise en place de LAPS
	1. Console de gestion sur un AD (GUI)
	2. Installation sur au moins 1 client (GPO ou script PS)

6. GESTION DES OBJETS AD - Déplacement automatique des ordinateurs dans les bonnes OU
	1. Suivant le nom d'une machine et/ou la valeur d'un attribut AD
	2. Automatisation par script PS exécuté par une tâches AT


## Optionnels

7. SÉCURITÉ D'ACCÈS - Restriction d'utilisation
	1. Pour les utilisateurs standard : connexion autorisée de 8h à 18h, du lundi au vendredi sur les clients (bloquée le reste du temps)
	2. Pour les administrateurs : bypass
	3. Gestion des exceptions : prévoir un groupe bypass
