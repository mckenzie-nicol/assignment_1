#!/bin/bash

if [ $# -ne 1 ]; then
        echo "Usage: $0  <filename> or "all""
        exit 1
fi

option=$1

case "$option" in
        all)
                git add .
                echo "All files added to commit."
                ;;
        *)      
                valid=$(git status | grep "$option" -c)
                n=${#option}
                if [[ $n -gt 3 && $valid -gt 0 ]]; then
                        git add $option
                else
                        echo "Unable to add file: $option 

Please try again."
                fi
                ;;
esac