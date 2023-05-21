#!/bin/bash

file_name=".abc.txt"
if [[ -f $file_name ]]; then
    out=$(cat $file_name)
    echo $out
else
    echo "Enter data"
    read data
    touch $file_name
    echo $data > $file_name
fi