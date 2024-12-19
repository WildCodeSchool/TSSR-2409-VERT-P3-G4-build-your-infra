# Plan des VLANs pour Pharmgreen

## Liste des VLANs

| **VLAN**                 | **ID** | **Description**                                                                                                                                          |
|--------------------------|--------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| **VLAN Administration**  | **10** | Pour les administrateurs réseau et systèmes (accès aux équipements comme serveurs, routeurs, switchs).                                                  |
| **VLAN Serveurs**        | **20** | Hébergeant le serveur ADDS, le serveur Core, le serveur Debian avec  GLPI.                                                                               |
| **VLAN Téléphonie**      | **30** | Pour les téléphones VoIP                                                                    |
| **VLAN Utilisateurs**    | **40** | Pour les postes de travail des employés.                                                                                                                |
| **VLAN Wi-Fi Entreprise**| **50** | Pour le  Wi-Fi des employés.                                                                                                                      |
| **VLAN Wi-Fi Invités**   | **51** | Pour le WIFI des visiteurs ou appareils personnels. Limite l'accès aux ressources internes.                                                           |
| **VLAN IoT**             | **60** | Pour les équipements spécifiques  (ex. caméras IP).                                                                   |
| **VLAN Impressions**     | **70** | Pour les imprimantes réseau.                                                                                                                            |
| **VLAN Services annexes 1** | **80** | Réservé pour un service futur ou spécifique.                                                                                                           |
| **VLAN Services annexes 2** | **81** | Même usage que le précédent                                                                           |
| **VLAN de secours 1**    | **90** | Réserve pour un futur service ou pour basculer un service en cas de défaillance.                                                                        |
| **VLAN de secours 2**    | **91** | Même raison que ci-dessus.                                                                                                                              |

## Logique d'attribution des IDs

- **10-19** : Administration et services critiques.
- **20-29** : Serveurs et infrastructure centrale.
- **30-39** : Téléphonie et services spécifiques liés à la communication.
- **40-49** : Utilisateurs (postes de travail).
- **50-59** : Wi-Fi (différenciation entreprise/invités).
- **60-69** : IoT et équipements connectés.
- **70-79** : Impressions et périphériques spécifiques.
- **80-89** : Services annexes.
- **90-99** : VLAN de secours ou pour extensions futures.