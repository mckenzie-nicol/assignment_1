#!/bin/bash

echo "
Welcome to mygit! \
---------------------------------------------------------------\
"

number=0

while [$number -ne 9] 

do
    echo "
    Please select from the menu below on what you would like to do?
    1. Initialize Repository
    2. Clone Repository
    3. Commit Changes
    4. Push Changes
    5. Pull from Remote Repository
    6. Modify Repository Contents (File Operations)

    9. Exit Program

    Enter the number:
    "
    
    read number


    case "$number" in
        1)
            echo "Do you want to initialize the current working directory as a Repository? (Y/N)"
            read response
            case "$response" in
                Y)
                    ./mygit-init
                    ;;    
                N)
                    echo "Enter the name of the directory you wish to initialize:"
                    read response
                    ./mygit-init $response
                    ;;
                *)
                    echo "Invalid response, command ending."
                    exit 1
            ;;

        2)
            echo "What is the URL of the respository you want to clone?"
            read url
            echo "What is the name of the directory to clone to?"
            read destination
            ./mygit-clone $url $destination
            ;;

        3)
            while [[ "$response" != "all" && "$response" != "done" ]]; do
                git status
                echo "Modified files are listed above. What file do you want to add? 
                Or enter 'all' to add all files. Or enter 'done' when finished."
                read response
                if [["$response" != "done"]]; then
                    ./mygit-add.sh 
                fi
            done
            ;;

        4)
            
            ;;
        5)
            
            ;;

        6)
            
            ;;
        7)
            continue
            ;;
        *)
            echo "That was an invalid option, please try again."
            ;;
done

echo "Thanks for using mygit!"

exit 0