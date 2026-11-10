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
## Script d'audit local — Étudiant 2 (@nerolf)

Ce script réalise un audit en lecture seule des comptes utilisateurs locaux. Il affiche :

- la liste des comptes locaux (login, UID, GID, répertoire personnel, shell) ;
- les membres des groupes d'administration (sudo, wheel, admin) ;
- une alerte si un compte autre que root possède l'UID 0 ;
- la dernière connexion des comptes humains ;
- les utilisateurs actuellement connectés et un résumé chiffré.

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

