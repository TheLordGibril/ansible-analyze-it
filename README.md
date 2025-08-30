# Ansible - Analyze It

Ce projet Ansible permet de déployer automatiquement l’application **Analyze It** (frontend, backend, API IA, base de données et services associés) sur un serveur.

L’infrastructure repose sur **Docker** et **Docker Compose**, avec gestion des backups, reverse proxy Nginx et monitoring.

## 🚀 Prérequis

- Ansible
- Accès SSH à la machine distante
- `ansible-vault` si vous souhaitez déchiffrer `vault.yml` (me contacter pour obtenir le mot de passe du vault : gabidule03@gmail.com)

## ⚙️ Installation

1. **Cloner le repo**
    
    ```bash
    git clone https://github.com/TheLordGibril/ansible-analyze-it.git
    cd ansible-analyze-it
    ```
    
2. **Configurer l’inventaire**
    
    Modifier `inventory.ini` avec l’IP/DNS de votre serveur :
    
    ```
    [servers]
    vm1 ansible_host=xxx.xxx.xxx.xxx ansible_user=xxx ansible_password=xxx
    ```
    
3. **Déployer avec Ansible**
    
    ```bash
    ansible-playbook -i inventory.ini playbook.yml --ask-become-pass --ask-vault-pass
    ```
    

## 📦 Services déployés

- **Postgres** (base de données)
- **Backend** Node.js
- **Frontend** Vue/React (selon ton app)
- **API IA** Python FastAPI
- **Nginx** (reverse proxy + load balancing)
- **Backup** (scripts pour dump/restore)
- **cAdvisor** (monitoring)
- **Watchtower** (mises à jour auto des conteneurs)
