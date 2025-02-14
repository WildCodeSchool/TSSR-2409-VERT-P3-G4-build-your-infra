# Tutoriel : Configurer un pare-feu avec respect du tiering sur pfSense

Ce tutoriel explique comment configurer un pare-feu sur pfSense pour respecter une architecture en tiers avec les VLANs suivants :

- **VLAN 5** : Domaine Contrôleur (DC) - Réseau `10.15.0.0/30`
- **VLAN 10** : Administrateurs - Réseau `10.15.0.16/28`
- **VLAN 20** : Autres serveurs - Réseau `10.15.0.32/27`
- **VLAN 40** : Utilisateurs - Réseau `10.15.2.0/24`

Les règles de pare-feu respecteront les principes suivants :

- **VLAN 5** (DC) peut communiquer avec tous les VLANs.
- **VLAN 10** (Admins) peut accéder aux VLANs 5 et 20.
- **VLAN 20** (Serveurs) peut uniquement accéder au VLAN 5 (DC) et aux services critiques tel que LDAP.
- **VLAN 40** (Utilisateurs) peut uniquement accéder au VLAN 20 (Serveurs) sur des services spécifiques.
- Tous les VLANs peuvent accéder à Internet selon les règles configurées.
- **VLAN 40 (Utilisateurs)** peut accéder au **VLAN 5 (DC)** uniquement pour les services critiques comme l'authentification Active Directory et DNS.

---

## Étapes de configuration

### 1. Identifier vos VLANs et leurs rôles
| VLAN  | Nom              | Rôle                 | Réseau            |
|-------|------------------|----------------------|-------------------|
| VLAN5 | Domaine Contrôleur | Contrôle des domaines | `10.15.0.0/30`  |
| VLAN10| Administrateurs    | Gestion réseau       | `10.15.0.16/28` |
| VLAN20| Serveurs          | Services applicatifs | `10.15.0.32/27` |
| VLAN40| Utilisateurs       | Réseau client        | `10.15.2.0/24`  |

---

### 2. Configurer les interfaces VLAN

1. Accédez à **Interfaces > Assignments**.
2. Assurez-vous que chaque VLAN est configuré avec une interface dédiée et les adresses IP suivantes :
   - **VLAN 5** : `10.15.0.0/30`
   - **VLAN 10** : `10.15.0.16/28`
   - **VLAN 20** : `10.15.0.32/27`
   - **VLAN 40** : `10.15.2.0/24`
3. Appliquez les changements.

---

### 3. Règles de pare-feu pour chaque VLAN

#### Règles pour **VLAN 5 (DC)**
1. Accédez à **Firewall > Rules > VLAN5**.
2. Ajoutez les règles suivantes :
   - **Permettre la communication avec tous les VLANs** :
     - **Action** : Pass
     - **Protocol** : Any
     - **Source** : `VLAN5 net`
     - **Destination** : Any.
   - **Permettre l'accès à Internet** :
     - **Action** : Pass
     - **Protocol** : Any
     - **Source** : `VLAN5 net`
     - **Destination** : Any (ou choisissez `WAN net` si disponible).
3. Cliquez sur **Save** et **Apply Changes**.

#### Règles pour **VLAN 10 (Administrateurs)**
1. Accédez à **Firewall > Rules > VLAN10**.
2. Ajoutez les règles suivantes :
   - **Permettre la communication avec VLAN 5 (DC)** :
     - **Action** : Pass
     - **Protocol** : Any
     - **Source** : `VLAN10 net`
     - **Destination** : `VLAN05 subnet`.
   - **Permettre la communication avec VLAN 20 (Serveurs)** :
     - **Action** : Pass
     - **Protocol** : Any
     - **Source** : `VLAN10 net`
     - **Destination** : `10.15.0.32/27`.
   - **Permettre l'accès à Internet** :
     - **Action** : Pass
     - **Protocol** : Any
     - **Source** : `VLAN10 net`
     - **Destination** : Any (ou choisissez `WAN net` si disponible).
   - **Bloquer tout autre trafic** :
     - **Action** : Block
     - **Source** : `VLAN10 net`
     - **Destination** : Any.
3. Cliquez sur **Save** et **Apply Changes**.

#### Règles pour **VLAN 20 (Serveurs)**
1. Accédez à **Firewall > Rules > VLAN20**.
2. Ajoutez les règles suivantes :
   - **Permettre la communication avec VLAN 5 (DC)** :
     - **Action** : Pass
     - **Protocol** : Any
     - **Source** : `VLAN20 net`
     - **Destination** : `VLAN05 subnet`.
   - **Permettre un accès limité au VLAN 5 (DC)** pour les services critiques :
     - **Action** : Pass
     - **Protocol** : TCP/UDP
     - **Source** : `VLAN40 net`
     - **Destination** : `VLAN05 subnet`
     - **Ports** :
       - **LDAP** : 389 (TCP/UDP)
   - **Permettre l'accès à Internet** :
     - **Action** : Pass
     - **Protocol** : Any
     - **Source** : `VLAN20 net`
     - **Destination** : Any 
   - **Bloquer tout autre trafic** :
     - **Action** : Block
     - **Source** : `VLAN20 net`
     - **Destination** : Any.
3. Cliquez sur **Save** et **Apply Changes**.

#### Règles pour **VLAN 40 (Utilisateurs)**
1. Accédez à **Firewall > Rules > VLAN40**.
2. Ajoutez les règles suivantes :
   - **Permettre l'accès à VLAN 20 (Serveurs)** :
     - **Action** : Pass
     - **Protocol** : TCP/UDP (ou spécifique, comme HTTP/HTTPS).
     - **Source** : `VLAN40 net`
     - **Destination** : `10.15.0.32/27`.
   - **Permettre un accès limité au VLAN 5 (DC)** pour les services critiques :
     - **Action** : Pass
     - **Protocol** : TCP/UDP
     - **Source** : `VLAN40 net`
     - **Destination** : `VLAN05 subnet`
     - **Ports** :
       - **Kerberos** : 88 (TCP/UDP)
       - **LDAP** : 389 (TCP/UDP)
       - **LDAPS** : 636 (TCP)
       - **DNS** : 53 (TCP/UDP)
       - **NTP** : 123 (UDP)
     - **Description** : "Accès limité des utilisateurs au DC".
   - **Permettre l'accès à Internet** :
     - **Action** : Pass
     - **Protocol** : Any
     - **Source** : `VLAN40 net`
     - **Destination** : Any (ou choisissez `WAN net` si disponible).
   - **Bloquer tout autre trafic** :
     - **Action** : Block
     - **Source** : `VLAN40 net`
     - **Destination** : Any.
3. Cliquez sur **Save** et **Apply Changes**.

---

### 4. Configurer les règles NAT pour Internet

1. Accédez à **Firewall > NAT > Outbound**.
2. Si le mode NAT est "Automatic Outbound NAT rule generation", pfSense gère automatiquement le NAT pour permettre l'accès à Internet depuis tous les VLANs.
3. Si le mode NAT est "Manual Outbound NAT rule generation" :
   - Ajoutez une règle pour chaque VLAN :
     - **Interface** : WAN
     - **Source** : Réseau du VLAN (par exemple, `192.168.0.0/30` pour VLAN 5).
     - **Destination** : Any.
   - Répétez pour chaque VLAN.
   - Cliquez sur **Save** et **Apply Changes**.

---

### 5. Tester la configuration
Pour vérifier que les règles fonctionnent comme prévu :

1. Depuis un client dans **VLAN 40** (Utilisateurs) :
   - Vérifiez que vous pouvez accéder aux serveurs dans **VLAN 20** (selon les services autorisés).
   - Vérifiez que vous pouvez accéder aux services critiques du **DC** (exemple : authentification, DNS).
   - Vérifiez que vous pouvez accéder à Internet.

2. Depuis un client dans **VLAN 10** (Administrateurs) :
   - Vérifiez que vous pouvez accéder aux VLANs 5 (DC) et 20 (Serveurs).
   - Vérifiez que vous pouvez accéder à Internet.

3. Depuis un client dans **VLAN 20** (Serveurs) :
   - Vérifiez que vous pouvez accéder au VLAN 5 (DC).
   - Vérifiez que vous pouvez accéder à Internet.

---

## Résumé des communications autorisées
| Source VLAN  | Destination VLAN | Communication | Notes                          |
|--------------|------------------|---------------|--------------------------------|
| VLAN 5 (DC)  | Tous             | Oui           | Accès complet.                |
| VLAN 10 (Admins) | VLAN 5, VLAN 20 | Oui           | Administration.               |
| VLAN 20 (Serveurs) | VLAN 5 (DC)   | Oui           | Dépendance serveur/DC.        |
| VLAN 40 (Users) | VLAN 20 (Serveurs) | Limité       | Services spécifiques (HTTP).  |
| VLAN 40 (Users) | VLAN 5 (DC)      | Limité       | Services critiques (auth, DNS).|
| Tous les VLANs | Internet         | Oui           | Accès configuré via NAT.      |

Avec cette configuration, vous respectez l’architecture en tiers et limitez les accès non nécessaires entre les VLANs tout en permettant un accès sécurisé à Internet et aux services essentiels du DC. Si vous avez besoin d’ajouter des règles spécifiques ou de tester davantage, faites-le-moi savoir !

