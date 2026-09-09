# Infrastructure as Code - Terraform & CI/CD sur AWS

Projet de stage d'été : déploiement d'une infrastructure web (VPC, EC2, Application Load Balancer) sur AWS, entièrement automatisé avec Terraform et un pipeline CI/CD GitHub Actions.

## Objectif du projet

Démontrer une maîtrise des pratiques d'Infrastructure as Code (IaC) et de CI/CD dans un contexte cloud réel, en respectant les contraintes d'un environnement pédagogique (AWS Academy Learner Lab).

## Architecture

- **VPC** avec 2 subnets publics répartis sur 2 zones de disponibilité (haute disponibilité)
- **Internet Gateway** + table de routage pour l'accès public
- **Security Groups en couches** : l'EC2 n'accepte le trafic HTTP que depuis l'ALB, jamais directement depuis Internet
- **Aucune NAT Gateway** (choix budgétaire, subnets publics utilisés directement)

## Structure du projet

Architecture modulaire : le même code (modules) est réutilisé par les deux environnements, avec des valeurs différentes via des fichiers `.tfvars`.

## Pipeline CI/CD (GitHub Actions)

Le pipeline s'exécute automatiquement sur chaque `push`/`pull request` :
- `terraform init`
- `terraform fmt -check`
- `terraform validate`
- `terraform plan` (lecture seule, aucune ressource créée)

Un déclenchement manuel (`workflow_dispatch`) permet de choisir explicitement `plan`, `apply` ou `destroy` — ce choix volontaire évite toute création accidentelle de ressources facturables.

## Prérequis

- Terraform >= 1.9
- AWS CLI configuré
- Un compte AWS (ce projet a été développé et testé sur AWS Academy Learner Lab)

## Utilisation en local

```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

⚠️ Ne pas oublier `terraform destroy` après vérification pour éviter les coûts inutiles.

## Contraintes spécifiques (AWS Academy Learner Lab)

Ce projet a été conçu pour respecter les contraintes d'un environnement de lab pédagogique :
- **IAM** : utilisation du rôle `LabRole` existant (pas de création d'IAM personnalisé, non autorisée)
- **Credentials temporaires** : rotation toutes les ~4h, jamais stockées en dur, injectées via variables d'environnement ou secrets GitHub
- **Budget limité** : pas de NAT Gateway, instances `t2.micro` (éligibles free tier)
- **Région restreinte** : `us-east-1`

## Défis techniques rencontrés

- **Caractères spéciaux AWS** : les descriptions de Security Groups n'acceptent ni accents ni apostrophes (erreur `doesn't comply with restrictions`), corrigé en reformulant les descriptions
- **Fichiers `.tfvars` et CI/CD** : `.gitignore` excluait par défaut les fichiers `.tfvars`, empêchant GitHub Actions de les lire ; résolu avec une exception ciblée (`!environments/dev/terraform.tfvars`)
- **Mode non-interactif en CI** : ajout de `-input=false` pour éviter les blocages de `terraform plan` sur les runners GitHub Actions

## Auteure

Cheima Ezzine — étudiante en Cloud Computing & Réseaux, stage d'été.