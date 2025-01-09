## Intégration du serveur Debian au domaine

- Configurer les deux cartes réseaux (interne, bridge).
- Se connecter en root et modifier les interfaces réseau :  
  ```bash
  nano /etc/network/interfaces
  ```
  ![ad1](https://github.com/user-attachments/assets/593cf91c-d977-4e20-a742-0250ff14c349)

- Installer les paquets nécessaires :
  ```bash
  apt -y install realmd sssd sssd-tools libnss-sss libpam-sss adcli samba-common-bin oddjob oddjob-mkhomedir packagekit
  ```

- Modifier le fichier de résolution DNS :
  ```bash
  nano /etc/resolv.conf
  ```
  ![ad1](https://github.com/user-attachments/assets/8f5040da-7b95-4d11-82c9-84970cbb2fd6)

- Rejoindre le domaine :
  ```bash
  realm join --user=administrator <NomDeDomaine>
  ```
  ![ad1](https://github.com/user-attachments/assets/73431a49-1520-4ea1-a2d7-6f4299b48c10)
