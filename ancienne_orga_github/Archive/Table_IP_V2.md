# Table d'adressage pour la société Pharmgreen

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

## Table d'adressage
```
Sous-réseau 01: Ventes et Développement Commercial
46 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.0.0/26 => 64 adresses (2^6) 32-6 = 26 pour le ss réseau
Adresse IP du routeur : 10.15.0.1
Début de plage IP disponible : 10.15.0.2
Fin de plage IP disponible : 10.15.0.62
Adresse de broadcast : 10.15.0.63
```
```
Sous-réseau 02: R&D
29 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.0.64/27 => 32 adresses (2^5) 32-5 = 27 pour le ss réseau
Adresse IP du routeur : 10.15.0.65
Début de plage IP disponible : 10.15.0.66
Fin de plage IP disponible : 10.15.0.94
Adresse de broadcast : 10.15.0.95
```
```
Sous-réseau 03: RH
24 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.0.96/27 => 32 adresses (2^5) 32-5 = 27 pour le ss réseau
Adresse IP du routeur : 10.15.0.97
Début de plage IP disponible : 10.15.0.98
Fin de plage IP disponible : 10.15.0.126
Adresse de broadcast : 10.15.0.127
```
```
Sous-réseau 04: Direction Marketing
22 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.0.128/27 => 32 adresses (2^5) 32-5 = 27 pour le ss réseau
Adresse IP du routeur : 10.15.0.129
Début de plage IP disponible : 10.15.0.130
Fin de plage IP disponible : 10.15.0.158
Adresse de broadcast : 10.15.0.159
```
```
Sous-réseau 05: Communication
20 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.0.160/27 => 32 adresses (2^5) 32-5 = 27 pour le ss réseau
Adresse IP du routeur : 10.15.0.161
Début de plage IP disponible : 10.15.0.162
Fin de plage IP disponible : 10.15.0.190
Adresse de broadcast : 10.15.0.191
```
```
Sous-réseau 06: Direction Financière
16 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.0.192/27 => 32 adresses (2^5) 32-5 = 27 pour le ss réseau
Adresse IP du routeur : 10.15.0.193
Début de plage IP disponible : 10.15.0.194
Fin de plage IP disponible : 10.15.0.222
Adresse de broadcast : 10.15.0.223
```
```
Sous-réseau 07: Services Généraux 
12 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.0.224/28 => 16 adresses (2^4) 32-4 = 28 pour le ss réseau
Adresse IP du routeur : 10.15.0.225
Début de plage IP disponible : 10.15.0.226
Fin de plage IP disponible : 10.15.0.238
Adresse de broadcast : 10.15.0.239
```
```
Sous-réseau 08: Direction Générale
8 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.0.240/28 => 16 adresses (2^4) 32-4 = 28 pour le ss réseau
Adresse IP du routeur : 10.15.0.241
Début de plage IP disponible : 10.15.0.242
Fin de plage IP disponible : 10.15.0.254
Adresse de broadcast : 10.15.0.255
```
```
Sous-réseau 09: Juridique
8 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.1.0/28 => 16 adresses (2^4) 32-4 = 28 pour le ss réseau
Adresse IP du routeur : 10.15.1.1
Début de plage IP disponible : 10.15.1.2
Fin de plage IP disponible : 10.15.1.14
Adresse de broadcast : 10.15.1.15
```
```
Sous-réseau 10: Systèmes Information
6 hôtes + 3 adresses réservées
Adresse de réseau : 10.15.1.16/28 => 16 adresses (2^4) 32-4 = 28 pour le ss réseau
Adresse IP du routeur : 10.15.1.17
Début de plage IP disponible : 10.15.1.18
Fin de plage IP disponible : 10.15.1.30
Adresse de broadcast : 10.15.1.31
```
## Tableau d'adressage:


# Nouvelle Table d'Adressage

| **Sous-réseau**             | **Adresse réseau** | **Masque** | **Adresse IP du routeur** | **Plage IP disponible pour les hôtes** | **Adresse de broadcast** |
|-----------------------------|--------------------|------------|---------------------------|----------------------------------------|--------------------------|
| Ventes et Dév. Com.         | 10.15.0.0         | /26        | **10.15.0.1**             | 10.15.0.2 - 10.15.0.62                 | 10.15.0.63               |
| R&D                         | 10.15.0.64        | /27        | **10.15.0.65**            | 10.15.0.66 - 10.15.0.94                | 10.15.0.95               |
| RH                          | 10.15.0.96        | /27        | **10.15.0.97**            | 10.15.0.98 - 10.15.0.126               | 10.15.0.127              |
| Direction Marketing         | 10.15.0.128       | /27        | **10.15.0.129**           | 10.15.0.130 - 10.15.0.158              | 10.15.0.159              |
| Communication               | 10.15.0.160       | /27        | **10.15.0.161**           | 10.15.0.162 - 10.15.0.190              | 10.15.0.191              |
| Direction Financière        | 10.15.0.192       | /27        | **10.15.0.193**           | 10.15.0.194 - 10.15.0.222              | 10.15.0.223              |
| Services Généraux           | 10.15.0.224       | /28        | **10.15.0.225**           | 10.15.0.226 - 10.15.0.238              | 10.15.0.239              |
| Direction Générale          | 10.15.0.240       | /28        | **10.15.0.241**           | 10.15.0.242 - 10.15.0.254              | 10.15.0.255              |
| Juridique                   | 10.15.1.0         | /28        | **10.15.1.1**             | 10.15.1.2 - 10.15.1.14                 | 10.15.1.15               |
| Systèmes d'Information      | 10.15.1.16        | /28        | **10.15.1.17**            | 10.15.1.18 - 10.15.1.30                | 10.15.1.31               |



- Il nous reste donc des adresses de dispo pour une évolution futur et pour d'éventuels serveurs, périphériques, intervenants extérieurs, etc.
