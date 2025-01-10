# Guide utilisateur pour le script PowerShell

## Objectif
Ce script PowerShell automatise la gestion des horaires d'accès des utilisateurs.

---

## Prérequis
Avant d'exécuter le script, assurez-vous que :

 **Chemin de l'OU dans AD :**
   - L'unité organisationnelle (“OU”) spécifiée dans le script doit exister dans votre Active Directory.

---

## Déroulement du script

 Il faut savoir que :

  -TimeIn24Format permet de définir les heures pour autoriser l'ouverture de session. Le fait d'indiquer "6", permet d'autoriser le créneau de 6h à 7h.

  -Monday -Tuesday -Wednesday -Thursday permet de spécifier tous les jours sur lesquels ajouter cette autorisation

  -NonSelectedDaysare NonWorkingDays permet de déterminer une politique pour les jours non spécifiés (dans la liste précédente). Avec la valeur "NonWorkingDays", on considère que ce sont des jours non travaillés, et donc, que l'on refuse l'ouverture de session. Sinon, vous pouvez utiliser la valeur "WorkingDays"

---






