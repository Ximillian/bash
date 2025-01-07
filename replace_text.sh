#!/bin/bash

echo "Введите имя файла:"
read filename

echo "Введите слово для замены:"
read oldword

echo "Введите новое слово:"
read newword

sed -i "s/\b$old_word\b/$newword/g" "$filename"

echo "Все вхождения слова '$oldword' заменены на '$newword' в файле '$filename'."
