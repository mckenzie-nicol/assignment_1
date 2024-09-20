#!/bin/bash

if [ $# -ne 2 ]; then
        echo "Usage: $0 <remote_url> <local_directory>"
        exit 1
fi

