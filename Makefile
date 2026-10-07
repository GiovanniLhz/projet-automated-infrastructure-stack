# .PHONY indique à make que ces cibles ne correspondent pas à des fichiers physiques, 
# évitant ainsi les conflits si un fichier du même nom existe dans le dossier.
.PHONY: all setup deploy clean status help

# Définition des variables pour centraliser les chemins d'accès Ansible
PLAYBOOK = ansible/playbook.yml
INVENTORY = ansible/inventory.ini

# Cible par défaut : exécuter 'make' sans argument lancera directement la cible 'deploy'
all: deploy

# Affiche le menu d'aide interactif décrivant l'usage de chaque commande
help:
	@echo "Commandes disponibles :"
	@echo "  make setup   - Initialise Terraform"
	@echo "  make deploy  - Applique Terraform et lance le playbook Ansible"
	@echo "  make clean   - Détruit l'infrastructure provisionnée par Terraform"
	@echo "  make status  - Vérifie le statut de l'application sur localhost:8080"

# Initialise le répertoire Terraform (télécharge les providers et prépare le backend)
setup:
	@echo "==> Initialisation de Terraform..."
	cd terraform && terraform init

# Déploie l'infrastructure complète :
# 1. Exécute 'setup' au préalable (dépendance)
# 2. Applique la configuration Terraform sans demander de confirmation manuelle
# 3. Lance le playbook Ansible pour configurer l'application
deploy: setup
	@echo "==> Déploiement de l'infrastructure via Terraform..."
	cd terraform && terraform apply -auto-approve
	@echo "==> Configuration et déploiement via Ansible..."
	ansible-playbook -i $(INVENTORY) $(PLAYBOOK)
	@echo "==> Déploiement terminé ! Application accessible sur http://localhost:8080"

# Effectue une requête HTTP HEAD sur le service web pour vérifier rapidement son accessibilité
status:
	@echo "==> Test du service web..."
	curl -I http://localhost:8080

# Supprime toutes les ressources créées par Terraform de manière automatisée
clean:
	@echo "==> Destruction de l'infrastructure..."
	cd terraform && terraform destroy -auto-approve
