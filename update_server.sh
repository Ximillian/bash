#!/bin/bash

# Параметры
REMOTE_USER="ximillian"
REMOTE_HOST="192.0.0.1"
EMAIL="ximillian@ya.ru"
LOG_FILE="./update_log.txt"

echo "=== $(date) ===" >> $LOG_FILE
echo "Подключение к $REMOTE_HOST" | tee -a $LOG_FILE

ssh "$REMOTE_USER@$REMOTE_HOST" "
    echo 'Проверка обновлений';
    sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y;
    echo 'Обновления установлены';
    
    # Проверка необходимости перезагрузки
    if [ -f /var/run/reboot-required ]; then
        echo 'Перезагрузка системы';
        sudo reboot;
    else
        echo 'Перезагрузка не требуется';
    fi
"

if [ $? -eq 0 ]; then
    echo "Обновления установлены" | tee -a $LOG_FILE
    if ssh "$REMOTE_USER@$REMOTE_HOST" "test -f /var/run/reboot-required"; then
        echo "Сервер перезагружен. Отправка уведомления"
        echo "Сервер $REMOTE_HOST был перезагружен после установки обновления" | mail -s "Уведомление: Перезагрузка сервера" "$EMAIL"
    fi
else
    echo "Ошибка при обновлении или подключении" | tee -a $LOG_FILE
fi
