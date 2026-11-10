# Evaluation-pratique---Git-et-GitHub
Repositories de l'évaluation Git / GitHub du 10/11/2026

##Identification du groupe : 

| Nom | Prenom | Pseudo Git | Rôle |

| Riegert | Samuel | @Touffast | Etudiant 1 (fonctionnalité A) |
| Proano | Florian | @nerolf | Etudiant 2 (fonctionnalité B) |
| Boufarnana | Adam | @adam59160a-art | Etudiant 3 (Fonctionnalité C)

#Fonctionnalité A - Surveillance système ('monitor_system.sh')
- Responsable : @Touffast
- Description : Affiche la charge CPU, l'utilisation de la RAM et l'espace Disque
- Prérequis : Environnement Linux / Git Bash
- Commande d'ex&cution : 
'''bash
chmod +x monitor_system.sh
./monitor_system.sh

### Prérequis

- Linux ou WSL
- Bash 4 ou plus récent
- Commandes : `awk`, `getent`, `who`, `lastlog` ou `last`
- Aucun droit root nécessaire : le script ne modifie rien sur le système

### Exécution

```bash
chmod +x scripts/audit_local.sh
./scripts/audit_local.sh        # audit complet
./scripts/audit_local.sh -h     # affiche l'aide
```


## Script d'audit local — Étudiant 2 (@nerolf)

Ce script réalise un audit en lecture seule des comptes utilisateurs locaux. Il affiche :

- la liste des comptes locaux (login, UID, GID, répertoire personnel, shell) ;
- les membres des groupes d'administration (sudo, wheel, admin) ;
- une alerte si un compte autre que root possède l'UID 0 ;
- la dernière connexion des comptes humains ;
- les utilisateurs actuellement connectés et un résumé chiffré.

Question 1 (Florian) : Le GitFlow permet d'organiser un cycle de vie d'un projet en séparatn les différents environnements: 
- main : heberge le code de production stable
- develop : centralise les évolutions du projet en cours
- features : ajouts des défférentes fonctionnalitées
- release : prépare les mises en productions
- hotfix : permet de corriger le/les bugs urgent directement en prod

Question 3 (Samuel) : Le merge créer un commut de fusion qui conserve l'historique et la chronologie des branches alors que le rebase déplace les commits d'une branche à l'autre sans le respect de la temporalité des commits

Question 4 (Florian) : Les commits font référence aux issues, pour clore les issues on leur fait référence dans la description de la PR.

Quesrtion 6 (Florian) : Git contribue a la sécurité et a l'intégration du code via une tracabilité totale et transparente de toutes les modifications qui ont été apporté au cours des commits. Bien paramètré, il permet d'éviter les modifications directes non aurotisées et éxige des validations par des tiers. Il permet de revenir en arrière en cas de problèmes ou incident de sécurité.

Question 8 (Samuel) : un conflit Git survient lorsque Git ne peut pas fusionner automatiquement deux modifications concurrentes sur les même lignes de code. Afin de le résoudre, on doit analyser les balises de conflit insérées par Git dans le/les fichiers concernés, on choisit manuellement le code a conserver ou fusionner.