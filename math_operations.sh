#!/bin/bash
echo "Введите число:"
read num1

echo "Введите второе число:"
read num2

echo "Выберите операцию (+, -, *, /):"
read operation

case "$operation" in
    +)
        echo "Результат: $(($num1 + $num2))"
        ;;
    -)
        echo "Результат: $(($num1 - $num2))"
        ;;
    '*')
        echo "Результат: $(($num1 * $num2))"
        ;;
    /)
        if [ "$num2" -eq 0 ]; then
            echo "Ошибка: деление на ноль невозможно!"
        else
            echo "Результат: $(($num1 / $num2))"
        fi
        ;;
    *)
        echo "Ошибка: Неверная операция. Используйте +, -, *, /."
        ;;
esac
