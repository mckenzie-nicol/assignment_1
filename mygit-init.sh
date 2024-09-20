#!/bin/bash

if [ $# -gt 1 ]; then
        echo "Usage: $0 <directory>"
        exit 1
fi

if [$# -eq 0]; then
        git init
        exit 0
else
        git init $1
        exit 0
fi