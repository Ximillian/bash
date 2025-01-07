#!/bin/bash

# Параметры
REMOTE_USER="ximillian"
REMOTE_HOST="192.0.0.1"
THRESHOLD=20
EMAIL="ximillian@ya.ru"

echo "Проверка свободного места на $REMOTE_HOST..."
FREE_SPACE=$(ssh "$REMOTE_USER@$REMOTE_HOST" "df -BG / | grep '/' | awk '{print \$4}' | sed 's/G//'")

if [ $? -ne 0 ]; then
    echo "Ошибка подключения или выполнения команды"
    exit 1
fi

echo "Свободное место на сервере: ${FREE_SPACE}G"

# Сравнение с порогом
if [ "$FREE_SPACE" -lt "$THRESHOLD" ]; then
    echo "Свободное место меньше порога ($THRESHOLD GB). Отправка уведомления"
    echo "На $REMOTE_HOST осталось всего ${FREE_SPACE} GB свободного места" | mail -s "Уведомление: Мало свободного места" "$EMAIL"
    if [ $? -ne 0 ]; then
        echo "Ошибка отправки"
        exit 1
    fi
    echo "Уведомление отправлено"
else
    echo "Свободного места достаточно"
fi
