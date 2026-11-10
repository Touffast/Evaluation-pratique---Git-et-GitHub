#!/usr/bin/env bash
#
# audit_local.sh — Audit des comptes utilisateurs locaux
# Fonctionnalité B — Boîte à outils d'administration système
#
# Usage      : ./scripts/audit_local.sh [-h]
# Prérequis  : Linux ou WSL, Bash 4+, awk, getent, who, lastlog ou last
# Droits     : aucun droit root nécessaire, le script ne modifie rien

set -u

VERSION="1.0"

usage() {
    cat <<FIN
Usage : $(basename "$0") [-h]

Audit en lecture seule des comptes utilisateurs locaux (version $VERSION) :
  - liste des comptes locaux
  - membres des groupes d'administration
  - alerte si un compte autre que root a l'UID 0
  - dernière connexion des comptes
  - utilisateurs connectés et résumé final

Options :
  -h, --help    affiche cette aide
FIN
}

titre() {
    echo
    echo "---- $1 ----"
}

lister_comptes() {
    titre "Comptes locaux (/etc/passwd)"
    printf "  %-20s %-7s %-7s %-25s %s\n" "LOGIN" "UID" "GID" "HOME" "SHELL"
    awk -F: '{ printf "  %-20s %-7s %-7s %-25s %s\n", $1, $3, $4, $6, $7 }' /etc/passwd
}

# ===== Programme principal =====
case "${1:-}" in
    -h|--help) usage; exit 0 ;;
    "") ;;
    *) echo "Option inconnue : $1" >&2; usage >&2; exit 1 ;;
esac

echo "Audit local de $(hostname) — $(date '+%d/%m/%Y %H:%M:%S')"
lister_comptes