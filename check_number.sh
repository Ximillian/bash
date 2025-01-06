#!/bin/bash
echo "Введите число"
read number
if [[ $number -gt 0 ]]; then
    echo "+"
elif [[ $number -eq 0 ]]; then
    echo "0"
else
    echo "-"
fi
