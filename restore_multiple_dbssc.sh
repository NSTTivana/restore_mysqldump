#!/bin/bash

DATABASES=(
"xxxx"
"yyyy"
)

USER="xx"
PASSWORD="xxx"
HOST="x.x.x.x"
DUMP_FILE="dump/dump-xxx.sql"

restore_db() {
  DB=$1
  if [[ -f "$DUMP_FILE" ]]; then
    echo "Restoring $DB from $DUMP_FILE..."
    pv "$DUMP_FILE" | mysql --skip-ssl -h "$HOST" -u "$USER" -p"$PASSWORD" "$DB"
    echo "Completed $DB"
  else
    echo "SQL file $DUMP_FILE not found."
  fi
}

# Loop through the databases and restore each in the background
for DB in "${DATABASES[@]}"
do
  restore_db "$DB" &  # Run in the background
done


wait 
echo "All databases have been restored."
