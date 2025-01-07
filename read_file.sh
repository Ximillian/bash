#!/bin/bash

echo "Введите имя файла:"
read filename

cat "$filename" | while read line; do
    echo "$line"
done
