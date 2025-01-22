### I. Les rôles FSMO, ça sert à quoi ?  

Lorsque nous mettons en place un environnement Active Directory, il y a de très fortes chances (car c’est conseillé) que nous installations plusieurs contrôleurs de domaine. De ce fait, tous les contrôleurs de domaine disposent d’un accès en écriture sur l’annuaire.

Cependant, certaines tâches sont plus sensibles que d’autres. Il serait alors dangereux d’autoriser la modification de certaines données sur deux contrôleurs de domaine différents, en même temps. De ce fait et pour minimiser les risques de conflits, Microsoft a décidé d’implémenter les rôles FSMO qui permettent de limiter la modification de certaines données internes à l’annuaire Active Directory.

Au sein d’un environnement, nous attribuerons la notion de « rôle FSMO » à « maître d’opération ». Le maitre d’opération est le contrôleur de domaine qui détient un ou plusieurs rôles FSMO. Détenir un rôle signifie pour un contrôleur de domaine qu’il est capable de « réaliser une action particulière au sein de l’annuaire ».

Il est à noter qu’il ne peut pas y avoir plusieurs maîtres d’opérations pour le même rôle FSMO, au sein d’un domaine ou d’une forêt (selon le rôle concerné).

Voici les cinq rôles que nous allons étudier :

cours-active-directory-23
### II. Rôle « Maître d’attribution des noms de domaine »
Le maître d’opération qui détient ce rôle est unique au sein de la forêt. Il est aussi le seul autorisé à distribuer des noms de domaine aux contrôleurs de domaine, lors de la création d’un nouveau domaine.

De ce fait, il est notamment utilisé lors de la création d’un nouveau domaine. Le contrôleur de domaine à l’initiative de la création doit impérativement être en mesure de contacter le contrôleur de domaine disposant du rôle FSMO « Maître d’attribution des noms de domaine » sinon la procédure échouera. Enfin, je tiens à préciser qu’il a également pour mission de renommer les noms de domaine.

En résumé, il est unique au sein d’une forêt et attribue les noms de domaine.

### III. Rôle « Contrôleur de schéma »
Pour rappel, le schéma désigne la structure de l’annuaire Active Directory, le schéma est donc un élément critique au sein de l’environnement Active Directory. Cela implique l’unicité au sein de la forêt de ce maître d’opération, qui sera le seul – contrôleur de domaine – à pouvoir initier des changements au niveau de la structure de l’annuaire (schéma). Comme le schéma est unique, son gestionnaire est unique également.

En résumé, il est unique au sein d’une forêt et gère la structure du schéma.

IV. Rôle « Maître RID »
Comme vous le savez déjà, les objets créés au sein de l’annuaire Active Directory disposent de plusieurs identifiants uniques. Parmi eux, il y a notamment l'"objectGUID" et le "DistinguishedName" mais aussi l’identifiant de sécurité « objectSID » (SID). C’est ce dernier qui nous intéresse dans le cadre du maître RID.

Pourquoi RID ?
Le RID est un identifiant relatif qui est unique au sein de chaque SID, afin d’être sûr d’avoir un SID unique pour chaque objet de l’annuaire. Le SID étant constitué d’une partie commune qui correspond au domaine, le RID est essentiel pour rendre unique chaque SID. C’est là que le "Maître RID" intervient...

Unique au sein d’un domaine, ce maître d’opération devra allouer des blocs d’identificateurs relatifs (pools de 500 RID) à chaque contrôleur de domaine du domaine. Ainsi, chaque contrôleur de domaine aura un bloc (pool) de RID unique qu’il pourra attribuer aux futurs objets créés dans l’annuaire, tout en s'assurant qu'il n'y ait pas de SID en doublon. À chaque fois, le RID sera incrémenté de "1" au fur et à mesure que le DC consomme son bloc de RID.

Bien sûr, tous les contrôleurs de domaine ne vont pas épuiser le pool de RID au même rythme… Un contrôleur de domaine qui atteindra un certain niveau d’épuisement de son stock de RID disponible contactera le "Maître RID" pour en obtenir des nouveaux. Cela implique que la création d’un objet est impossible si le "Maître RID" du domaine n’est pas disponible.

En résumé, il est unique au sein d’un domaine et attribue des blocs de RID aux contrôleurs de domaine pour s'assurer que les SID des objets soient uniques.

L'Active Directory et les notions de SID, RID et SID History
### V. Rôle « Maître d’infrastructure »
Unique au sein d’un domaine, le contrôleur de domaine qui dispose du rôle de "Maître d’infrastructure" gère les références entre plusieurs objets.

Prenons un exemple pour mieux comprendre ce que cela signifie. Imaginons qu’un utilisateur d’un "domaine A" soit ajouté au sein d’un groupe de sécurité du "domaine B". Le contrôleur de domaine « Maître d’infrastructure » deviendra responsable de cette référence et devra s’assurer de la réplication de cette information sur tous les contrôleurs de domaine du domaine.

Ces références d’objets sont également appelées « objets fantômes » et permettent au contrôleur de domaine de faciliter les liens entre les différents objets. Un objet fantôme contiendra peu d’information au sujet de l’objet auquel il fait référence (DN, SID et GUID). Dans le cas de l’exemple ci-dessus, un objet fantôme sera créé sur le "domaine B" afin de faire référence à l’utilisateur du "domaine A".

De ce fait, si l’objet est modifié ou supprimé à l’avenir, le "Maître d’infrastructure" devra se charger de déclencher la mise à jour de l’objet fantôme auprès des autres contrôleurs de domaine. Il accélère les processus de réplication et la communication entre les contrôleurs de domaine.

En résumé, il est unique au sein d’un domaine et doit gérer les références d’objets au sein du domaine.

### VI. Rôle « Émulateur PDC »
L’émulateur PDC (Primary Domain Controller) est unique au sein d’un domaine et se doit d’assurer cinq missions principales :

Modification des stratégies de groupe du domaine (éviter les conflits et les écrasements).
Synchroniser les horloges sur tous les contrôleurs de domaine (date et heure), il assure la fonction de serveur de temps (NTP).
Gérer le verrouillage des comptes d’utilisateurs (en cas de tentatives de connexion échouées).
Faciliter le changement des mots de passe, en assurant que les nouveaux mots de passe sont répliqués immédiatement.
Assurer la compatibilité avec les anciens contrôleurs de domaine Windows NT pour les environnements mixtes.
En résumé, il est unique au sein d’un domaine et assure diverses missions liées à la sécurité. Par défaut, il assure la fonction de serveur de temps pour l’ensemble du domaine.
