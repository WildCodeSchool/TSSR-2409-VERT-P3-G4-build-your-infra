| **2^0** | **2^1** | **2^2** | **2^3** | **2^4** | **2^5** | **2^6** | **2^7** | **2^8** | **2^9** | **2^10** | **2^11** |
|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|----------|----------|
| 1       | 2       | 4       | 8       | 16      | 32      | 64      | 128     | 256     | 512     | 1024     | 2048     |

# Réseau: `172.14.5.0/24`

```
Sous-réseau 01: Ventes et Développement Commercial
46 hôtes
Adresse de réseau : 172.14.5.0/26 => 64 adresses (2^6) 32-6 = 26 pour le ss réseau
Début de plage IP disponible :172.14.5.1 
Fin de plage IP disponible : 172.14.5.62
Adresse de broadcast : 172.14.5.63
```
```
Sous-réseau 02: R&D
29 hôtes
Adresse de réseau : 172.14.5.64/27  => 32 adresses (2^5) 32-5 = 27 pour le ss réseau
Début de plage IP disponible : 172.14.5.65
Fin de plage IP disponible : 172.14.5.94
Adresse de broadcast : 172.14.5.95
```
```
Sous-réseau 03: RH
24 hôtes
Adresse de réseau : 172.14.5.96/27 => 32 adresses (2^5) 32-5 = 27 pour le ss réseau
Début de plage IP disponible : 172.14.5.97
Fin de plage IP disponible : 172.14.5.126
Adresse de broadcast : 172.14.5.127
```
```
Sous-réseau 04: Direction Marketing
22 hôtes
Adresse de réseau : 172.14.5.128/27 => 32 adresses (2^5) 32-5 = 27 pour le ss réseau
Début de plage IP disponible : 172.14.5.129
Fin de plage IP disponible : 172.14.5.128
Adresse de broadcast : 172.14.5.159
```
```
Sous-réseau 05: Communication
20 hôtes
Adresse de réseau : 172.14.5.160/27 => 32 adresses (2^5) 32-5 = 27 pour le ss réseau
Début de plage IP disponible : 172.14.5.161
Fin de plage IP disponible : 172.14.5.190
Adresse de broadcast : 172.14.5.191
```
```
Sous-réseau 06: Direction Financière
14 hôtes
Adresse de réseau : 172.14.5.192/28 => 16 adresses (2^4) 32-4 = 28 pour le ss réseau
Début de plage IP disponible : 172.14.5.193
Fin de plage IP disponible : 172.14.5.206
Adresse de broadcast : 172.14.5.207
```
```
Sous-réseau 07: Services Généraux 
12 hôtes
Adresse de réseau : 172.14.5.208/28 => 16 adresses (2^4) 32-4 = 28 pour le ss réseau
Début de plage IP disponible : 172.14.5.209
Fin de plage IP disponible : 172.14.5.222
Adresse de broadcast : 172.14.5.223
```
```
Sous-réseau 08: Direction Générale
8 hôtes + 2 réservé => besoin de 10
Adresse de réseau : 172.14.5.224/28 => 16 adresses (2^4) 32-4 = 28 pour le ss réseau
Début de plage IP disponible : 172.14.5.225
Fin de plage IP disponible : 172.14.5.238
Adresse de broadcast : 172.14.5.239
```
```
Sous-réseau 09: Juridique
8 hôtes + 2 réservé => besoin de 10
Adresse de réseau : 172.14.5.240/28 => 16 adresses (2^4) 32-4 = 28 pour le ss réseau
Début de plage IP disponible : 172.14.5.241
Fin de plage IP disponible : 172.14.5.254
Adresse de broadcast : 172.14.5.255
```

# complet on doit donc changer le prefixe et passer à un réseau en `172.14.5.0/23` et ainsi on complète: 

```
Sous-réseau 10: Systèmes Information
6 hôtes + 2 réservé => besoin de 8 
Adresse de réseau : 172.14.6.0/29 => 8 adresses (2^3) 32-3 = 29 pour le ss réseau
Début de plage IP disponible : 172.14.6.1
Fin de plage IP disponible : 172.14.6.6
Adresse de broadcast : => 172.14.6.7
```

- Il nous reste donc des adresses de dispo pour une évolution futur et pour d'éventuels serveurs, périphériques, intervenants extérieurs,...
