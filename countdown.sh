#!/bin/bash
echo "Введите число"
read number
while [ $number -gt 0 ]
do
echo "$number"
number=$(( $number - 1 ))
done

