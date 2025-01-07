#!/bin/bash

# Параметры
REMOTE_USER="ximillian"
REMOTE_HOST="192.0.0.1"
REMOTE_DIR="/home/user/ximillian/arch"
LOCAL_DIR="./downloads"
ARCHIVE_NAME="backup_$(date +"%Y-%m-%d_%H-%M-%S").tar.gz"

echo "Архивирование $REMOTE_DIR на сервере"
ssh "$REMOTE_USER@$REMOTE_HOST" "
    tar -czf /tmp/$ARCHIVE_NAME -C $(dirname "$REMOTE_DIR") $(basename "$REMOTE_DIR")
"
if [ $? -ne 0 ]; then
    echo "Ошибка при создании архива"
    exit 1
fi
echo "Архив /tmp/$ARCHIVE_NAME создан"

mkdir -p "$LOCAL_DIR"
echo "Скачивание архива в $LOCAL_DIR"
scp "$REMOTE_USER@$REMOTE_HOST:/tmp/$ARCHIVE_NAME" "$LOCAL_DIR/"
if [ $? -ne 0 ]; then
    echo "Ошибка загрузки"
    exit 1
fi
echo "Архив скачан в $LOCAL_DIR/$ARCHIVE_NAME"

echo "Распаковка архива в $LOCAL_DIR"
tar -xzf "$LOCAL_DIR/$ARCHIVE_NAME" -C "$LOCAL_DIR"
if [ $? -ne 0 ]; then
    echo "Ошибка распаковки"
    exit 1
fi
echo "Архив успешно распакован в $LOCAL_DIR."

echo "Удаление архива на сервере"
ssh "$REMOTE_USER@$REMOTE_HOST" "rm -f /tmp/$ARCHIVE_NAME"
if [ $? -ne 0 ]; then
    echo "Ошибка удаления"
    exit 1
fi
echo "Архив удалён"
