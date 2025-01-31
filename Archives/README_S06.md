# Objectifs de la semaine

## Principaux 
1. JOURNALISATION - Mise en place d'une gestion des logs centralisée
	1. Utilisation de l'un des systèmes suivants :
		1. **Graylog** (https://github.com/Graylog2/graylog2-server)
		2. **Syslog-ng** (https://github.com/syslog-ng/syslog-ng)
	2. Mise en production :
		1. Installation sur VM (non-dédié) ou CT
		2. Gestion des logs des serveurs

2. SUPERVISION - Mise en place d'une supervision de l'infrastructure réseau
	1. Utilisation d'au moins un des logiciels suivant :
		1. **ZABBIX** (https://www.zabbix.com/)
		2. **M/MONIT** (https://mmonit.com/)
		3. **PRTG** (https://www.paessler.com/)
		4. **NAGIOS Core** (https://www.nagios.org/projects/nagios-core/)
	2. Mise en production :
		1. Installation sur VM/CT dédié
		2. Supervision des éléments de l'infrastructure (actuels et à venir)
		3. Mise en place de dashboard

3. AD - Nouveau fichier RH pour les utilisateurs de l'entreprise
	1. Intégration des nouveaux utilisateurs
	2. Modifications de certaines informations
	3. Fourniture d'un fichier `S06_Pharmgreen.xlsx` :
		1. Le département "RH" change de nom et devient la "Direction des Ressources Humaines"
		2. Le service "Marketing Digital" s'appelle désormais "e-Marketing"
		3. Le service "Recrutement" s'appelle désormais "Gestion des recrutements", et les collaborateurs de ce service ont désormais la fonction de "Recruteur RH"
		4. Plusieurs collaborateurs ont quitté la société à la fin du mois dernier. Traiter leurs comptes AD ainsi que leurs données associées (s'il y en a)
		5. Des collaborateurs se sont marié. Traiter correctement leur nouveau nom.

## Secondaires

4. SUPERVISION - Surveillance du pare-feu pfsense
	1. Mise en place de dashboard
	2. Ajout et modification de widget

## Optionnels

2. JOURNALISATION - Mise en place d'une journalisation des scripts PowerShell
	1. Les logs seront construit pour pouvoir être lu par l'un des systèmes suivants :
		1. **Observateur d’événements Windows**
		2. Logiciel **CMTRACE** (https://www.tech2tech.fr/cmtrace-lire-vos-fichiers-logs-facilement/)
	2. Modifier ou ajouter cette gestion de logs dans les scripts PowerShell utilisés (actuels et à venir)
	3. Utiliser un répertoire spécifique pour les logs (à définir)
	4. Un seul log par script