# Conventions de nommage


1. Nom de domaine (DC)

Pour le nom de domaine il a été défini d’utiliser le domaine : 
      “Pharmgreen.com”

---

2. Les ordinateurs

Les ordinateurs seront nommés en fonction de leur caractéristique physique  (fixe/portable),
puis par service (COM/RD/SI) , suivi d’un numéro .
  exemple pour un ordinateur portable du service RH : P-RH-01

Pour les serveurs , le nom commencera par SRV suivi de sa fonction et d’un numéro
  exemple : SRV-ADDS-01  ou SRV-DHCP-01

  ---

3. OU

Pour l’architecture , voici le plan proposé: 

OU Serveurs

OU Ordinateurs
 
Com
DirFin
DirGen
DirMar
R&D
RH
SerJur
SerGen
SI
VDC
Ext

OU Utilisateurs
            
DirFin
   -Fin
   -SCom
   -CG
DirGen
DirMar
   -MS
   -MD
   -MO
   -MP
R&D
   -IS
   -LB
RH
   -RE
   -GP
   -SS
    -FO
SerJur
    -CX
    -CS
SerGen
    -LO
    -GI
SI
    -DA
    -DL
VDC
    -SA
    -BB
    -BC
    -DI
    -GC
    -SC
    -ADV
Com
    -Pub
    -RPP
 Ext

OU Administrateurs

---

4. Les groupes de sécurité

Les groupes de sécurité seront par type “Grp + “type”

Grp-Employés
Grp-Direction
Grp-PC
Grp-Admin

Les employés seront dans un groupe employé , la direction sera dans un groupe Direction , 
les administrateurs dans un groupe Admin

---

5. Les utilisateurs

Pour les utilisateurs ,nous allons faire des regroupements par département puis par services
 
Et pour la convention de nommage , on prendra le Nom et la 1er lettre du prénom , si besoin un chiffre 
	- Nom.”1er lettre du prénom”
    ex  :Joseph Poirier → POIRIER.J

---

6. Les GPO

 Les GPO commenceront par : 
     -U pour les configurations Utilisateur
     -O pour les configurations ordinateurs
A la suite on utilisera la fonction de la GPO : Sécurity , Settings , Software ….
Puis la cible de la GPO
Pour finir le nom de la fonction , du logiciel .
