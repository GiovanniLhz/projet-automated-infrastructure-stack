# Résolution du problème de compatibilité d'API Docker avec Terraform

## Description du problème

Lors de l'exécution de `terraform apply`, l'erreur suivante survient :

```text
Error: Unable to read Docker image into resource: unable to list Docker images: 
Error response from daemon: client version 1.41 is too old. 
Minimum supported API version is 1.44, please upgrade your client to a newer version
