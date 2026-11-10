#!/bin/bash
# Script de vérification des services - Étudiant C (HOTFIX v1.0.1)
# Correction critique : Gestion des services inexistants sur le système

if [[ "$1" == "-h" || "$1" == `--help` ]]; then
    echo "Usage: bash check_services.sh"
    echo "Vérifie l'état des services systemd et génère un rapport."
    exit 0
fi

SERVICES=("ssh" "ufw" "cron")
RAPPORT="compte_rendu_services.txt"

echo "=== RAPPORT D'ÉTAT DES SERVICES (HOTFIX v1.0.1) ===" > "$RAPPORT"
date >> "$RAPPORT"
echo "--------------------------------------------------" >> "$RAPPORT"

for srv in "${SERVICES[@]}"; do
    # Vérification si le service existe sur la machine avant de tester son état
    if ! systemctl list-unit-files --type=service | grep -q "^$srv.service"; then
        echo "[AVERTISSEMENT] Le service $srv n'est pas installe sur ce systeme." | tee -a "$RAPPORT"
    elif systemctl is-active --quiet "$srv" 2>/dev/null; then
        echo "[SUCCÈS] Le service $srv est ACTIF." | tee -a "$RAPPORT"
    else
        echo "[ERREUR] Le service $srv est INACTIF." | tee -a "$RAPPORT"
    fi
done

echo "--------------------------------------------------" >> "$RAPPORT"
echo "Rapport de hotfix généré avec succès dans $RAPPORT."