#!/bin/bash

if [ $# -ne 1 ]; then
        echo "Usage: $0  <filename> or "all""
        exit 1
fi

option=$1

case "$option" in
        all)
                git add .
                ;;
        *)      
                git add $option
                ;;