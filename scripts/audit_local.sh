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

groupes_admin() {
    titre "Membres des groupes d'administration"
    local g membres trouve=0
    for g in sudo wheel admin; do
        if getent group "$g" >/dev/null; then
            membres=$(getent group "$g" | cut -d: -f4)
            echo "  $g : ${membres:-(aucun membre)}"
            trouve=1
        fi
    done
    if [ "$trouve" -eq 0 ]; then
        echo "  Aucun groupe sudo, wheel ou admin sur ce système."
    fi
}

controle_uid0() {
    titre "Contrôle : comptes à UID 0"
    local suspects
    suspects=$(awk -F: '$3 == 0 && $1 != "root" { print $1 }' /etc/passwd)
    if [ -n "$suspects" ]; then
        echo "  [ALERTE] Comptes à UID 0 autres que root :"
        echo "$suspects" | sed 's/^/    - /'
    else
        echo "  [OK] Seul root possède l'UID 0."
    fi
}

# Comptes humains : UID entre UID_MIN (/etc/login.defs, 1000 par défaut) et 65533
comptes_humains() {
    local min
    min=$(awk '/^UID_MIN/ { print $2 }' /etc/login.defs 2>/dev/null)
    awk -F: -v min="${min:-1000}" '$3 >= min && $3 < 65534 { print $1 }' /etc/passwd
}

derniere_connexion() {
    titre "Dernière connexion des comptes humains"
    local u info liste
    liste=$(comptes_humains)
    if [ -z "$liste" ]; then
        echo "  Aucun compte humain."
        return
    fi
    for u in $liste; do
        info=""
        if command -v lastlog >/dev/null 2>&1; then
            info=$(lastlog -u "$u" 2>/dev/null | awk 'NR == 2 { $1 = ""; sub(/^ +/, ""); print }')
        elif command -v last >/dev/null 2>&1; then
            info=$(last -n 1 "$u" 2>/dev/null | head -n 1)
        fi
        printf "  - %-20s %s\n" "$u" "${info:-inconnue}"
    done
}

utilisateurs_connectes() {
    titre "Utilisateurs actuellement connectés"
    local sessions
    sessions=$(who 2>/dev/null)
    if [ -n "$sessions" ]; then
        echo "$sessions" | sed 's/^/  /'
    else
        echo "  Aucune session ouverte."
    fi
}

resume() {
    titre "Résumé"
    echo "  Comptes au total         : $(wc -l < /etc/passwd)"
    echo "  Comptes humains          : $(comptes_humains | wc -l)"
    echo "  UID 0 autres que root    : $(awk -F: '$3 == 0 && $1 != "root"' /etc/passwd | wc -l)"
    echo "  Sessions ouvertes        : $(who 2>/dev/null | wc -l)"
}

# ===== Programme principal =====
case "${1:-}" in
    -h|--help) usage; exit 0 ;;
    "") ;;
    *) echo "Option inconnue : $1" >&2; usage >&2; exit 1 ;;
esac

echo "Audit local de $(hostname) — $(date '+%d/%m/%Y %H:%M:%S')"
lister_comptes
groupes_admin
controle_uid0
derniere_connexion
utilisateurs_connectes
resume