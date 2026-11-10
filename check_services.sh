#!/bin/bash
# Script de vérification des services - Étudiant C
SERVICES=("ssh" "ufw" "cron")
RAPPORT="compte_rendu_services.txt"

echo "=== RAPPORT D'ÉTAT DES SERVICES ===" > "$RAPPORT"
date >> "$RAPPORT"
echo "-----------------------------------" >> "$RAPPORT"

for srv in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$srv"; then
        echo "[SUCCÈS] Le service $srv est ACTIF." | tee -a "$RAPPORT"
    else
        echo "[ERREUR] Le service $srv est INACTIF." | tee -a "$RAPPORT"
    fi
done

echo "Rapport généré avec succès dans $RAPPORT."