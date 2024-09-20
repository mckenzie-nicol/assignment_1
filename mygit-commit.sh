#!/bin/bash

if [ $# -ne 1 ]; then
        echo "Usage: $0 <commit_message>"
        exit 1
fi

message=$1

git commit -m $message
