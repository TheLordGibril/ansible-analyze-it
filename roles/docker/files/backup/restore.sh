#!/bin/bash
set -e

# Variables (repris de ton entrypoint)
BACKUP_DIR="backups"
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5434}"
DB_NAME="${DB_NAME:-oms_suisse}"
DB_USER="${DB_USER:-postgres}"
DB_PASS="${DB_PASS:-1234}"

# Choix du fichier à restaurer : le dernier backup dispo
BACKUP_FILE=$(ls -t "$BACKUP_DIR"/db_*.sql 2>/dev/null | head -1)

if [ -z "$BACKUP_FILE" ]; then
    echo "Aucun fichier de backup trouvé dans $BACKUP_DIR"
    exit 1
fi

echo "=== [$(date)] Restauration PostgreSQL ==="
echo "Fichier à restaurer : $BACKUP_FILE"

# Export du mot de passe pour psql
export PGPASSWORD="$DB_PASS"

# Vérification que la DB est prête
until pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER"; do
    echo "Postgres non prêt, attente..."
    sleep 2
done

# Rollback
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -f "$BACKUP_FILE"

echo "=== Restauration terminée avec succès ==="
