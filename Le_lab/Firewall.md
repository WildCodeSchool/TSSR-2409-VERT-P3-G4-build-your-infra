

## Règles de pare-feu pour les VLAN

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
   - **Ajoutez une règle pour autoriser les réponses DHCP** :
     - **Action** : Pass
     - **Protocol** : UDP
     - **Source** : `192.168.0.2`
     - **Source Port** : 67-68
     - **Destination** : Any ou les sous-réseaux des VLANs clients (`192.168.10.0/24`, `192.168.20.0/24`, etc.).
     - **Destination Port** : 68
     - **Description** : "Autoriser les réponses DHCP depuis le serveur AD".
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
     - **Destination** : `192.168.0.32/27`.
   - **Permettre l'accès à Internet** :
     - **Action** : Pass
     - **Protocol** : Any
     - **Source** : `VLAN10 net`
     - **Destination** : Any (ou choisissez `WAN net` si disponible).
   - **Bloquer tout autre trafic** :
     - **Action** : Block
     - **Source** : `VLAN10 net`
     - **Destination** : Any.
   - **Ajoutez une règle pour autoriser les réponses DHCP** :
     - **Action** : Pass
     - **Protocol** : UDP
     - **Source** : `192.168.0.2`
     - **Source Port** : 67-68
     - **Destination** : Any ou les sous-réseaux des VLANs clients (`192.168.10.0/24`, `192.168.20.0/24`, etc.).
     - **Destination Port** : 68
     - **Description** : "Autoriser les réponses DHCP depuis le serveur AD".
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
   - **Ajoutez une règle pour autoriser les réponses DHCP** :
     - **Action** : Pass
     - **Protocol** : UDP
     - **Source** : `192.168.0.2`
     - **Source Port** : 67-68
     - **Destination** : Any ou les sous-réseaux des VLANs clients (`192.168.10.0/24`, `192.168.20.0/24`, etc.).
     - **Destination Port** : 68
     - **Description** : "Autoriser les réponses DHCP depuis le serveur AD".
3. Cliquez sur **Save** et **Apply Changes**.

#### Règles pour **VLAN 40 (Utilisateurs)**
1. Accédez à **Firewall > Rules > VLAN40**.
2. Ajoutez les règles suivantes :
   - **Permettre l'accès à VLAN 20 (Serveurs)** :
     - **Action** : Pass
     - **Protocol** : TCP/UDP (ou spécifique, comme HTTP/HTTPS).
     - **Source** : `VLAN40 net`
     - **Destination** : `192.168.0.32/27`.
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
   - **Ajoutez une règle pour autoriser les réponses DHCP** :
     - **Action** : Pass
     - **Protocol** : UDP
     - **Source** : `192.168.0.2`
     - **Source Port** : 67-68
     - **Destination** : Any ou les sous-réseaux des VLANs clients (`192.168.10.0/24`, `192.168.20.0/24`, etc.).
     - **Destination Port** : 68
     - **Description** : "Autoriser les réponses DHCP depuis le serveur AD".
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