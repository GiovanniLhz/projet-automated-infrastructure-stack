# Journal de Bord Projet Évolutif Sciensano

Session 5 : Automatisation complète de l'Infrastructure avec Stack Unifiée (Terraform, Ansible, Docker & Makefile)

1. Architecture & Orchestration Globale

* Analyse des besoins d'automatisation de bout en bout pour le projet d'infrastructure.
* Définition d'un point d'entrée unique via un fichier Makefile pour orchestrer l'ensemble de la chaîne de déploiement.
* Structuration du dépôt avec isolation des responsabilités ( Terraform pour le IaaS local, Ansible pour la configuration runtime, Jinja2 pour le templating applicatif ).

2. Provisionnement de l'Infrastructure avec Terraform

* Configuration du provider Docker (`kreuzwerker/docker`) dans le répertoire `terraform/`.
* Définition déclarative du conteneur Nginx et du mappage de port (`8080:80`).
* Gestion du cycle de vie du conteneur et isolation des fichiers de state local.

3. Configuration et Templating avec Ansible & Jinja2

* Configuration de l'inventaire Ansible local (`inventory.ini`).
* Rédaction du playbook (`playbook.yml`) pour vérifier l'état du conteneur Nginx à chaud.
* Création et injection dynamique du template Jinja2 (`index.html.j2`) vers le répertoire applicatif du conteneur.

4. Automatisation CLI via Makefile

* Implémentation des cibles d'exécution :
  * `setup` : vérification préalable des dépendances système (Docker, Terraform, Ansible, Make).
  * `deploy` : automatisation séquentielle `terraform apply` suivie de `ansible-playbook`.
  * `status` : contrôle de l'état runtime du conteneur et de l'exposition du port web.
  * `clean` : destruction propre de l'infrastructure via `terraform destroy`.

5. Gestion de Version & Publication GitHub

* Initialisation du dépôt Git local et gestion des exclusions via `.gitignore`.
* Création du fichier `app/.gitkeep` pour conserver la structure du répertoire applicatif cible.
* Configuration et validation de la clé SSH (`ed25519`) du système hôte Zorin OS.
* Publication du projet sur le dépôt distant (`projet-automated-infrastructure-stack`).

6. Validation & Contrôle Qualité

* Validation de la chaîne d'automatisation via la commande unifiée `make deploy`.
* Contrôle du statut du conteneur et des logs Nginx via `make status`.
* Validation de l'accès au service web dynamique via `curl http://localhost:8080` et le navigateur.
