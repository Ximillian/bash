#!/bin/bash

# Параметры
SOURCE_DIR="./source"
BACKUP_DIR="./backup"
REMOTE_USER="ximillian"
REMOTE_HOST="192.0.0.1"
REMOTE_DIR="/home/user/Ximillian/Arch"

DATE=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVE_NAME="backup_$DATE.tar.gz"

mkdir -p "$BACKUP_DIR"
tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" "$SOURCE_DIR"
echo "Архив создан: $BACKUP_DIR/$ARCHIVE_NAME"

scp "$BACKUP_DIR/$ARCHIVE_NAME" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"
if [ $? -eq 0 ]; then
    echo "Архив  передан в $REMOTE_HOST:$REMOTE_DIR"
else
    echo "Ошибка: архив не передан" >&2
    exit 1
fi

ssh "$REMOTE_USER@$REMOTE_HOST" "cd $REMOTE_DIR && ls -tp | grep -v '/$' | tail -n +4 | xargs -d '\n' rm --"
if [ $? -eq 0 ]; then
    echo "Старые архивы на сервере удалены"
else
    echo "Ошибка при удалении" >&2
    exit 1
fi

echo "Выполнено"
