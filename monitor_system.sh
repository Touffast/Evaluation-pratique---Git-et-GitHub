#!/bin/bash
# Fonctionnalité A - Surveillance système (Étudiant 1 : @Touffast)
# Affiche l'utilisation du processeur, de la mémoire et des disques

source ./config.sh 2>/dev/null

echo "=========================================="
echo "   SURVEILLANCE SYSTEME - $APP_NAME"
echo "=========================================="

echo -e "\n[1] Charge Processeur (CPU) :"
uptime

echo -e "\n[2] Utilisation de la Memoire (RAM) :"
free -h

echo -e "\n[3] Utilisation des Disques :"
df -h /

df / | tr -s ' ' ';'