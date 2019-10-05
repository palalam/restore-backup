#!/bin/bash

set -e

BACKUPS_ROOT="backups"
RESTORE_ROOT="backend/web/uploads"
APP_ROOT="backend"

if [[ ! $1 ]];
then
	echo "No date specified. Specify a date in the format dd-mm-yyyy"
	exit 1
fi

if [[ ! $1 =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]
then 
  	echo "The date is not correct. Specify a date in the format dd-mm-yyyy"
  	exit 1
fi

if [[ ! -d $BACKUPS_ROOT ]];
then
	echo "Backups directory not found..."
	exit 1
fi

if [[ ! -d $RESTORE_ROOT ]];
then
	echo "Created restore directory..."
	mkdir -p "$RESTORE_ROOT"
fi

if [[ ! -d "$BACKUPS_ROOT/$1" ]];
then
	echo "Backup for the specified date does not exist!"
	exit 1
fi

echo "Restoring database..."

#gzip -d "$BACKUPS_ROOT/$1"/dump.sql.gz
#mv "$BACKUPS_ROOT/$1"/dump.sql "$APP_ROOT"

gzip -dc < "$BACKUPS_ROOT/$1"/dump.sql.gz > "$APP_ROOT"/dump.sql

echo "Restoring files..."
unzip "$BACKUPS_ROOT/$1"/uploads.zip -d "$RESTORE_ROOT"

echo "Recovery completed."







