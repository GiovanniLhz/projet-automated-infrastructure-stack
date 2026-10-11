# Stack d'infrastructure automatisée (Terraform, Ansible, Docker, Makefile)

Ce projet regroupe les quatre étapes précédentes dans une seule chaîne de déploiement. Un Makefile lance Terraform pour créer le conteneur Nginx, puis Ansible pour y déployer une page d'accueil générée à partir d'un template Jinja2. L'objectif était de tout déclencher avec une seule commande. Le détail de ma démarche est dans [JOURNAL.md](JOURNAL.md).

## Architecture

- `terraform/` : provisionne le conteneur Nginx via le provider Docker
- `ansible/` : vérifie le conteneur et déploie la page d'accueil via un template Jinja2
- `app/` : dossier applicatif du conteneur (contient un `.gitkeep` pour garder la structure)
- `Makefile` : point d'entrée unique pour toutes les commandes
- `JOURNAL.md` : mon journal de bord

## Prérequis

- Docker
- Terraform
- Ansible, avec la collection `community.docker`
- Make

## Commandes

Afficher l'aide :

```bash
make help
```

Initialiser Terraform :

```bash
make setup
```

Déployer l'infrastructure et configurer l'application :

```bash
make deploy
```

Vérifier que l'application répond :

```bash
make status
```

Détruire l'infrastructure :

```bash
make clean
```

L'application est accessible sur http://localhost:8080 une fois `make deploy` terminé.

