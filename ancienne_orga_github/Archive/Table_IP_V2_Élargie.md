# Table d'adressage élargie pour la société Pharmgreen

## Outil pour le calcul de notre table de routage:

| **2^0** | **2^1** | **2^2** | **2^3** | **2^4** | **2^5** | **2^6** | **2^7** | **2^8** | **2^9** | **2^10** | **2^11** |
|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|----------|----------|
| 1       | 2       | 4       | 8       | 16      | 32      | 64      | 128     | 256     | 512     | 1024     | 2048     |

## Réseau: 

> **Suite erreurs de documents, le réseau devra être sur cette plage :**  
**Adresse IP de réseau** : 10.15.0.0/16  
**Adresse de passerelle** : 10.15.255.254  
**Adresse IP DNS** : 10.15.255.254  

> **On réserve une adresse IP dans chaque sous-réseau pour une adresse de routeur**

## Nouvelle table d'adressage (avec plages élargies)
```
Sous-réseau 01: Ventes et Développement Commercial
100 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.0.0/25 => 128 adresses (2^7)
Adresse IP du routeur : 10.15.0.1
Début de plage IP disponible : 10.15.0.2
Fin de plage IP disponible : 10.15.0.126
Adresse de broadcast : 10.15.0.127
```
```
Sous-réseau 02: R&D
60 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.0.128/26 => 64 adresses (2^6)
Adresse IP du routeur : 10.15.0.129
Début de plage IP disponible : 10.15.0.130
Fin de plage IP disponible : 10.15.0.190
Adresse de broadcast : 10.15.0.191
```
```
Sous-réseau 03: RH
50 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.0.192/26 => 64 adresses (2^6)
Adresse IP du routeur : 10.15.0.193
Début de plage IP disponible : 10.15.0.194
Fin de plage IP disponible : 10.15.0.254
Adresse de broadcast : 10.15.0.255
```
```
Sous-réseau 04: Direction Marketing
40 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.1.0/26 => 64 adresses (2^6)
Adresse IP du routeur : 10.15.1.1
Début de plage IP disponible : 10.15.1.2
Fin de plage IP disponible : 10.15.1.62
Adresse de broadcast : 10.15.1.63
```
```
Sous-réseau 05: Communication
35 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.1.64/26 => 64 adresses (2^6)
Adresse IP du routeur : 10.15.1.65
Début de plage IP disponible : 10.15.1.66
Fin de plage IP disponible : 10.15.1.126
Adresse de broadcast : 10.15.1.127
```
```
Sous-réseau 06: Direction Financière
30 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.1.128/26 => 64 adresses (2^6)
Adresse IP du routeur : 10.15.1.129
Début de plage IP disponible : 10.15.1.130
Fin de plage IP disponible : 10.15.1.190
Adresse de broadcast : 10.15.1.191
```
```
Sous-réseau 07: Services Généraux
25 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.1.192/27 => 32 adresses (2^5)
Adresse IP du routeur : 10.15.1.193
Début de plage IP disponible : 10.15.1.194
Fin de plage IP disponible : 10.15.1.222
Adresse de broadcast : 10.15.1.223
```
```
Sous-réseau 08: Direction Générale
20 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.1.224/27 => 32 adresses (2^5)
Adresse IP du routeur : 10.15.1.225
Début de plage IP disponible : 10.15.1.226
Fin de plage IP disponible : 10.15.1.254
Adresse de broadcast : 10.15.1.255
```
```
Sous-réseau 09: Juridique
15 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.2.0/27 => 32 adresses (2^5)
Adresse IP du routeur : 10.15.2.1
Début de plage IP disponible : 10.15.2.2
Fin de plage IP disponible : 10.15.2.30
Adresse de broadcast : 10.15.2.31
```
```
Sous-réseau 10: Systèmes d'Information
10 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.2.32/28 => 16 adresses (2^4)
Adresse IP du routeur : 10.15.2.33
Début de plage IP disponible : 10.15.2.34
Fin de plage IP disponible : 10.15.2.46
Adresse de broadcast : 10.15.2.47
```
## Tableau d'adressage:


# Nouvelle Table d'Adressage

| Sous-réseau                 | Hôtes prévus | Masque CIDR | Adresse réseau | Adresse routeur | Début plage IP | Fin plage IP   | Adresse broadcast |
|-----------------------------|--------------|-------------|----------------|-----------------|----------------|---------------|-------------------|
| Ventes et Développement     | 100          | /25         | 10.15.0.0      | 10.15.0.1       | 10.15.0.2      | 10.15.0.126   | 10.15.0.127       |
| R&D                         | 60           | /26         | 10.15.0.128    | 10.15.0.129     | 10.15.0.130    | 10.15.0.190   | 10.15.0.191       |
| RH                          | 50           | /26         | 10.15.0.192    | 10.15.0.193     | 10.15.0.194    | 10.15.0.254   | 10.15.0.255       |
| Direction Marketing         | 40           | /26         | 10.15.1.0      | 10.15.1.1       | 10.15.1.2      | 10.15.1.62    | 10.15.1.63        |
| Communication               | 35           | /26         | 10.15.1.64     | 10.15.1.65      | 10.15.1.66     | 10.15.1.126   | 10.15.1.127       |
| Direction Financière        | 30           | /26         | 10.15.1.128    | 10.15.1.129     | 10.15.1.130    | 10.15.1.190   | 10.15.1.191       |
| Services Généraux           | 25           | /27         | 10.15.1.192    | 10.15.1.193     | 10.15.1.194    | 10.15.1.222   | 10.15.1.223       |
| Direction Générale          | 20           | /27         | 10.15.1.224    | 10.15.1.225     | 10.15.1.226    | 10.15.1.254   | 10.15.1.255       |
| Juridique                   | 15           | /27         | 10.15.2.0      | 10.15.2.1       | 10.15.2.2      | 10.15.2.30    | 10.15.2.31        |
| Systèmes d'Information      | 10           | /28         | 10.15.2.32     | 10.15.2.33      | 10.15.2.34     | 10.15.2.46    | 10.15.2.47        |



- Il nous reste donc des adresses de dispo pour une évolution futur et pour d'éventuels serveurs, périphériques, intervenants extérieurs, etc.
