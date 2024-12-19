# Objectifs de la semaine

## Avancement en fin de semaine

![mettre image tableau]()

## Principaux 

1. GPO de sécurité - Création d'au moins 5 GPO dont au moins 3 dans la liste ci-dessous :
	1. Politique de mot de passe (complexité, longueur, etc.)
	2. Verrouillage de compte (blocage de l'accès à la session après quelques erreur de mot de passe)
	3. Restriction d'installation de logiciel pour les utilisateurs non-administrateurs
	4. Gestion de Windows update (heure, délai avant installation, etc.)
	5. Blocage de l'accès à la base de registre
	6. Blocage complet ou partiel au panneau de configuration
	7. Restriction des périphériques amovible
	8. Gestion d'un compte du domaine qui est administrateur local des machines
	9. Gestion du pare-feu
	10. Écran de veille avec mot de passe en sortie
	11. Forçage du type d'utilisation sécurisée du bureau à distance
	12. Limitation des tentatives d'élévation de privilèges
	13. Définition de scripts de démarrage pour les machines et/ou les utilisateurs
	14. Politique de sécurité PowerShell
2. GPO standard - Création d'au moins 5 GPO dont 3 dans la liste ci-dessous :
	1. Fond d'écran
	2. Mappage de lecteurs
	3. Gestion de l'alimentation
	4. Déploiement (publication) de logiciels
	5. Redirection de dossiers (Documents, Bureau, etc.)
	6. Configuration des paramètres du navigateur (Firefox ou Chrome)
3. Serveur de gestion de parc - Installation de Glpi
	1. Sur un serveur Debian (CLI) VM ou CT
	2. Synchronisation AD
	3. Gestion de parc : Inclusion des objets AD (utilisateurs, groupes, ordinateurs)
	4. Gestion des incidents : Mise en place d'un système de ticketing
	5. Accès et gestion à partir d'un client


4. Nota Documentation

Si un objectifs de GPO est choisi, la configuration de chacune des GPO doit être clairement expliquée.

## Secondaires

5. Automatisation par script shell - Installation de Glpi
	1. Sur un serveur Debian (CLI) déjà installé (VM ou VT)
	2. Utilisation d'un fichier de configuration (contient le nom de la base de donnée, le nom du compte, etc.)


## Optionnels

6. Automatisation par script PowerShell - Installation d'un AD-DS
	1. Sur un Windows Server Core (CLI) déjà installé
	2. Installation du rôle AD-DS et ajout à un domaine existant
	3. Utilisation d'un fichier de configuration (contient le nom du serveur, l'adresse IP du DNS, le nom du domaine, etc.)

