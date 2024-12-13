# Table d'adressage pour la société Pharmgreen

## Outil pour le calcul de notre table de routage:

| **2^0** | **2^1** | **2^2** | **2^3** | **2^4** | **2^5** | **2^6** | **2^7** | **2^8** | **2^9** | **2^10** | **2^11** |
|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|----------|----------|
| 1       | 2       | 4       | 8       | 16      | 32      | 64      | 128     | 256     | 512     | 1024     | 2048     |

## Réseau: 

> **Le réseau `172.14.5.0/24` est complet et publique on doit donc changer le prefixe et passer à un réseau plus large et privé en `172.16.5.0/23`**

> **On réserve une adresse IP dans chaque sous-réseau pour une adresse de routeur**

## Table d'adressage
```
Sous-réseau 01: Ventes et Développement Commercial
46 hôtes + 3 adresses réservées
Adresse de réseau : 172.16.5.0/26 => 64 adresses (2^6) 32-6 = 26 pour le ss réseau
Adresse Ip du routeur : 172.16.5.1
Début de plage IP disponible : 172.16.5.2
Fin de plage IP disponible : 172.16.5.62
Adresse de broadcast : 172.16.5.63
```
```
Sous-réseau 02: R&D
29 hôtes + 3 adresses réservées
Adresse de réseau : 172.16.5.64/27  => 32 adresses (2^5) 32-5 = 27 pour le ss réseau
Adresse Ip du routeur : 172.16.5.65
Début de plage IP disponible : 172.16.5.66
Fin de plage IP disponible : 172.16.5.94
Adresse de broadcast : 172.16.5.95
```
```
Sous-réseau 03: RH
24 hôtes + 3 adresses réservées
Adresse de réseau : 172.16.5.96/27 => 32 adresses (2^5) 32-5 = 27 pour le ss réseau
Adresse Ip du routeur : 172.16.5.97
Début de plage IP disponible : 172.16.5.98
Fin de plage IP disponible : 172.16.5.126
Adresse de broadcast : 172.16.5.127
```
```
Sous-réseau 04: Direction Marketing
22 hôtes + 3 adresses réservées
Adresse de réseau : 172.16.5.128/27 => 32 adresses (2^5) 32-5 = 27 pour le ss réseau
Adresse Ip du routeur : 172.16.5.129
Début de plage IP disponible : 172.16.5.130
Fin de plage IP disponible : 172.16.5.158
Adresse de broadcast : 172.16.5.159
```
```
Sous-réseau 05: Communication
20 hôtes + 3 adresses réservées
Adresse de réseau : 172.16.5.160/27 => 32 adresses (2^5) 32-5 = 27 pour le ss réseau
Adresse Ip du routeur : 172.16.5.161
Début de plage IP disponible : 172.16.5.162
Fin de plage IP disponible : 172.16.5.190
Adresse de broadcast : 172.16.5.191
```
```
Sous-réseau 06: Direction Financière
16 hôtes + 3 adresses réservées
Adresse de réseau : 172.16.5.192/27 => 32 adresses (2^5) 32-5 = 27 pour le ss réseau
Adresse Ip du routeur : 172.16.5.193
Début de plage IP disponible : 172.16.5.194
Fin de plage IP disponible : 172.16.5.222
Adresse de broadcast : 172.16.5.223
```
```
Sous-réseau 07: Services Généraux 
12 hôtes + 3 adresses réservées
Adresse de réseau : 172.16.5.224/28 => 16 adresses (2^4) 32-4 = 28 pour le ss réseau
Adresse Ip du routeur : 172.16.5.225
Début de plage IP disponible : 172.16.5.226
Fin de plage IP disponible : 172.16.5.238
Adresse de broadcast : 172.16.5.239
```
```
Sous-réseau 08: Direction Générale
8 hôtes + 3 adresses réservées
Adresse de réseau : 172.16.5.240/28 => 16 adresses (2^4) 32-4 = 28 pour le ss réseau
Adresse Ip du routeur : 172.16.5.241
Début de plage IP disponible : 172.16.5.242
Fin de plage IP disponible : 172.16.5.254
Adresse de broadcast : 172.16.5.255
```
```
Sous-réseau 09: Juridique
8 hôtes + 3 adresses réservées
Adresse de réseau : 172.16.6.0/28 => 16 adresses (2^4) 32-4 = 28 pour le ss réseau
Adresse Ip du routeur : 172.16.6.1
Début de plage IP disponible : 172.16.6.2
Fin de plage IP disponible : 172.16.6.14
Adresse de broadcast : 172.16.6.15
```
```
Sous-réseau 10: Systèmes Information
6 hôtes + 3 adresses réservées
Adresse de réseau : 172.16.6.16/28 => 16 adresses (2^4) 32-4 = 28 pour le ss réseau
Adresse Ip du routeur : 172.16.6.17
Début de plage IP disponible : 172.16.6.18
Fin de plage IP disponible : 172.16.6.30
Adresse de broadcast : => 172.16.6.31
```
## Tableau d'adressage:

| **Sous-réseau**             | **Adresse réseau** | **Masque** | **Adresse IP du routeur** | **Plage IP disponible pour les hôtes** | **Adresse de broadcast** |
|-----------------------------|--------------------|------------|---------------------------|----------------------------------------|--------------------------|
| Ventes et Dév. Com.         | 172.16.5.0         | /26        | **172.16.5.1**            | 172.16.5.2 - 172.16.5.62               | 172.16.5.63              |
| R&D                         | 172.16.5.64        | /27        | **172.16.5.65**           | 172.16.5.66 - 172.16.5.94              | 172.16.5.95              |
| RH                          | 172.16.5.96        | /27        | **172.16.5.97**           | 172.16.5.98 - 172.16.5.126             | 172.16.5.127             |
| Direction Marketing         | 172.16.5.128       | /27        | **172.16.5.129**          | 172.16.5.130 - 172.16.5.158            | 172.16.5.159             |
| Communication               | 172.16.5.160       | /27        | **172.16.5.161**          | 172.16.5.162 - 172.16.5.190            | 172.16.5.191             |
| Direction Financière        | 172.16.5.192       | /27        | **172.16.5.193**          | 172.16.5.194 - 172.16.5.222            | 172.16.5.223             |
| Services Généraux           | 172.16.5.224       | /28        | **172.16.5.225**          | 172.16.5.226 - 172.16.5.238            | 172.16.5.239             |
| Direction Générale          | 172.16.5.240       | /28        | **172.16.5.241**          | 172.16.5.242 - 172.16.5.254            | 172.16.5.255             |
| Juridique                   | 172.16.6.0         | /28        | **172.16.6.1**            | 172.16.6.2 - 172.16.6.14               | 172.16.6.15              |
| Systèmes d'Information      | 172.16.6.16        | /28        | **172.16.6.17**           | 172.16.6.18 - 172.16.6.30              | 172.16.6.31              |


- Il nous reste donc des adresses de dispo pour une évolution futur et pour d'éventuels serveurs, périphériques, intervenants extérieurs,...
