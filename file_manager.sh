#!/bin/bash
mkdir $1
cd $1

touch file1.txt
touch file2.txt
cd ..
rm -rf $1
