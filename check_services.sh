#!/bin/bash
# Script de vérification des services - Étudiant C (v1.1 - support de l'option --help)

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "Usage: bash check_services.sh"
    echo "Vérifie l'état des services systemd (ssh, ufw, cron) et génère un rapport."
    exit 0
fi

SERVICES=("ssh" "ufw" "cron")
RAPPORT="compte_rendu_services.txt"

echo "=== RAPPORT D'ÉTAT DES SERVICES ===" > "$RAPPORT"
date >> "$RAPPORT"
echo "-----------------------------------" >> "$RAPPORT"

for srv in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$srv" 2>/dev/null; then
        echo "[SUCCÈS] Le service $srv est ACTIF." | tee -a "$RAPPORT"
    else
        echo "[ERREUR] Le service $srv est INACTIF." | tee -a "$RAPPORT"
    fi
done

echo "-----------------------------------" >> "$RAPPORT"
echo "Rapport généré avec succès dans $RAPPORT."