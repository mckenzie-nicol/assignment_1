#!/bin/bash

if [ $# -gt 0 ]; then
        echo "Usage: $0"
        exit 1
fi

push_confirmed=$(git pull | grep "error" -c)

if [[ $push_confirmed -ne 0 ]]; then
    echo "ERROR: Pull unsuccessful"
    echo "Please, commit/discard all changes."

    