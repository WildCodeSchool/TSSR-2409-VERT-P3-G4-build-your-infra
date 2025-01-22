### 1 Attribution des roles

| **Role** | **DC** |
| :--: | :----------: |
| contrôleur de schéma | SrvWin-ADDS-GUI  |
| Maître d'infrastructure | SrvWin-ADDS-GUI |
| Maître d'attribution des noms de domaine |  Srvwin-core-R  |
|  Maître RID |  srv-fichier  |
|  Émulateur PDC | SrvWin-ADDS-GUI   |

### 2 Procédures pour attribuer les roles

## I. Présentation
Ce tutoriel vous explique comment transférer les rôles FSMO d'un contrôleur de domaine vers un autre. On peut transférer un seul rôle ou plusieurs (maximum 5). Nous procéderons avec l'utilitaire ntdsutil.exe.  

## II. Comment exécuter NTDSUTIL ?  

Pour accéder à l'outil NTDSUTIL sur un contrôleur de domaine Active Directory, il suffit d'appeler "ntdsutil.exe" depuis une invite "Exécuter" ou de lancer l'outil à partir d'une Invite de commande ou une console PowerShell. C'est un outil qui s'utilise en mode interactif.  

   ` ntdsutil.exe ` 

Pour obtenir de l'aide quant à l'utilisation de ntdsutil, il suffit de saisir "?" et vous verrez les commandes disponibles. Toujours utile en cas d'oubli.

  ` ntdsutil ` 
  
III. Procédure pour transférer les rôles FSMO  

A. Activer le mode maintenance FSMO  

La première étape consiste à activer le mode maintenant FSMO. Pour passer en mode "fsmo maintenance" il faut saisir la commande suivante :  

 ` role ` 
Ensuite, pour voir les commandes disponibles, c'est le même principe que celui évoqué précédemment, il suffit de saisir un "?" pour afficher les commandes disponibles.

 ` ntdsutil2 `  
 
B. Connexion au second serveur  

Il faut établir une connexion avec le serveur sur lequel on veut transférer un ou des rôles. Pour cela, dans le mode « fsmo maintenance », tapez la commande :

  ` connections ` 
Vous êtes désormais en mode « server connections ». Pour établir la connexion avec le serveur, tapez la commande suivant en remplaçant par le nom du serveur :  

` connect to server <nom_serveur> `  

Patientez le temps que la connexion soit établie.  

Quand c'est fait, vous pouvez quitter le mode connexion pour revenir au mode précédent. Tapez simplement ceci :  

 ` q ` 
 
Vous voilà de retour en mode fsmo maintenance.  

C. Transférer les rôles FSMO  

Désormais, nous allons voir comment transférer les différents rôles FSMO, un par un.  

Transférer le rôle de Maître RID  

  ` transfer RID master ` 
  
Une boite de dialogue apparaît pour que vous confirmiez vouloir transférer le rôle sur le serveur avec lequel vous avez établie une connexion. Elle apparaîtra pour le transfert de chacun des rôles.  

![Capture d'écran 2025-01-22 144957](https://github.com/user-attachments/assets/b422ae35-553e-4ed9-9bec-06c55c919b21)  

Transfert du rôle de contrôleur de schéma  

Pour cela, saisissez cette commande afin de transférer le rôle :  

` transfer schema master`   

Transfert du rôle de Maître d'infrastructure  

Sur le même principe que la commande précédente, saisissez celle-ci :  

` transfer infrastructure master `   

Transfert du rôle de Maître d'attribution des noms de domaine  

` transfer domain naming master `  

Si la commande ci-dessus ne fonctionne pas, utilisez celle-ci :  
 
 ` transfer naming master `   
 
Transfert du rôle d’Émulateur PDC  

 ` transfer pdc `  
 
Remarque : À chaque fois que vous transférez un rôle, NTDSUTIL écrit le résumé sur l'appartenance des rôles, vous pouvez donc vérifier si le rôle a bien été transféré.

D. Fin de l'opération  

Voilà, l'opération est terminée ! Pour quitter correctement le programme ntdsutil, saisissez "q" dans le mode fsmo maintenance et quand vous êtes sur l'invite de commande ntdsutil.  

Enfin, vous pouvez vérifier si les rôles sont bien transférés grâce à la commande suivante (adaptez en indiquant le nom de votre domaine) :  

NETDOM QUERY /Domain:pharmgreen.com FSMO

![Capture d'écran 2025-01-22 145454](https://github.com/user-attachments/assets/1ab4cd21-9dda-41a3-9d6a-567dfb9b2cba)

fsmo1



