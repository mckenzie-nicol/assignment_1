#!/bin/bash

echo "
Welcome to mygit!
---------------------------------------------------------------
"

number=0


while [[ $number -ne 9 ]]
do

    echo "
    Please select from the menu below on what you would like to do?
    1. Initialize Repository
    2. Clone Repository
    3. Add changes
    4. Commit Changes
    5. Push Changes
    6. Pull from Remote Repository
    7. Modify Repository Contents (File Operations)

    9. Exit Program

    Enter the number:
    "
    
    read number

    case "$number" in
        1)
            echo "Do you want to initialize the current working directory as a Repository? (Y/N)"
            read response

            response="${response,,}"

            case "$response" in
                y)
                    ./mygit-init.sh
                    ;;    
                n)
                    echo "Enter the name of the directory you wish to initialize:"
                    read response
                    ./mygit-init.sh $response
                    ;;
                *)
                    echo "Invalid response, command ending."
                    exit 1
                    ;;
            esac
            ;;

        2)
            echo "What is the URL of the repository you want to clone?"
            read url
            echo "What is the name of the directory to clone to?"
            read destination
            ./mygit-clone.sh $url $destination
            ;;

        3)
            while [[ "$file" != "all" && "$file" != "done" ]]
            do

                git status | grep -Pv "  \(use"
                echo "What file do you want to add? 
Or enter 'all' to add all files. Or enter 'done' when finished.
"
                read file
                if [[ "$file" != "done" ]]; then
                    ./mygit-add.sh $file
                fi
            done
            ;;

        4)
            message=""
            git status | grep -Pv "  \(use"
            
            echo "Please enter your commit message:"
            read message
            ./mygit-commit $message
            ;;

        5)
            
            ;;

        6)

            ;;
        
        7)

            ;;

        9)
            continue
            ;;

        *)
            echo "That was an invalid option, please try again."
            ;;
    esac
done

echo "Thanks for using mygit!"

exit 0
