#!/bin/bash
set -e

# Variables
BACKUP_DIR="backups"
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5434}"
DB_NAME="${DB_NAME:-oms_suisse}"
DB_USER="${DB_USER:-postgres}"
DB_PASS="${DB_PASS:-1234}"

# Nom du fichier basé sur la date du jour
TODAY=$(date +'%Y-%m-%d')
BACKUP_FILE="$BACKUP_DIR/db_${TODAY}.sql"

echo "=== [$(date)] Backup PostgreSQL ==="

# Création du répertoire si inexistant
mkdir -p "$BACKUP_DIR"

# Suppression de l'ancien backup du jour s'il existe
if [ -f "$BACKUP_FILE" ]; then
    echo "Un backup du jour existe déjà, il sera remplacé."
    rm -f "$BACKUP_FILE"
fi

# Dump de la base
export PGPASSWORD="$DB_PASS"
pg_dump -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" "$DB_NAME" > "$BACKUP_FILE"
echo "Backup créé : $BACKUP_FILE"

# Conserver uniquement les 7 backups les plus récents
TOTAL_BACKUPS=$(ls -1t "$BACKUP_DIR"/db_*.sql 2>/dev/null | wc -l)

if [ "$TOTAL_BACKUPS" -gt 7 ]; then
    ls -1t "$BACKUP_DIR"/db_*.sql | tail -n +8 | xargs rm -f
    echo "Rotation effectuée (conservation des 7 derniers backups)."
else
    echo "Moins de 7 backups, aucune rotation nécessaire."
fi

echo "=== Backup terminé avec succès ==="
