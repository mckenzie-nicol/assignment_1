#!/bin/bash

mygit_init() {

    if [[ $# -eq 0 && ! `git rev-parse --is-inside-work-tree` ]]; then
        git init
    elif [[ `git rev-parse --is-inside-work-tree` ]]; then
        echo "ABORTED: Current directory is already initialized as a repository."
    else 
        git init $1
    fi
}

mygit_clone() {

    remote_url=$1
    local_directory=$2

    git clone $remote_url $local_directory
}

mygit_add() {
    option=$1

    case "$option" in
        all)
            git add .
            echo "All files added to commit."
            ;;
        *)      
            valid=$(git status | grep "$option" -c)
            n=${#valid}
            if [[ $n -gt 3 && $valid -gt 0 ]]; then
                git add $option
            else
                echo "Unable to add file: $option 
Please try again."
            fi
            ;;
    esac

}

mygit_remove() {
    option=$1

    case "$option" in
        all)
            git reset
            echo "All files added to commit."
            ;;
        *)      
            valid=$(git status | grep "$option" -c)
            n=${#valid}
            if [[ $n -gt 3 && $valid -gt 0 ]]; then
                git restore --staged $option
            else
                echo "Unable to add file: $option 
Please try again."
            fi
            ;;
    esac
}

mygit_commit() {
    message=$1
    git commit -m $message
}

mygit_push() {
    git push
}

mygit_pull() {
    push_confirmed=$(git pull | grep "error" -c)

    if [[ $push_confirmed -ne 0 ]]; then
        echo "ERROR: Pull unsuccessful"
        echo "Please, commit/discard all changes."
        exit 1
    fi
    echo "Pull successful... project up to date."
}

echo "
Welcome to mygit!
---------------------------------------------------------------
"

menu_choice=0
sub_menu_choice=0
path_prefix="./"


while [[ $choice -ne 9 ]]
do
    echo "You are currently working in: $(pwd)"
    echo "
    Please select from the menu below on what you would like to do?
    1. Initialize Repository
    2. Clone Repository
    3. Add/Unstage changes
    4. Commit Changes
    5. Push Changes
    6. Pull from Remote Repository
    7. Modify Repository Contents (File Operations)

    9. Exit Program

    Enter the number:
    "
    
    read menu_choice

    case "$menu_choice" in
        1)
            echo "Do you want to initialize the current working directory as a Repository? (Y/N)"
            read sub_menu_choice

            sub_menu_choice="${sub_menu_choice,,}"

            case "$sub_menu_choice" in
                y)
                    mygit_init
                    ;;    
                n)
                    echo "Enter the name of the directory you wish to initialize:"
                    read sub_menu_choice
                    echo "Initializing repo..."
                    mygit_init $sub_menu_choice
                    cd sub_menu_choice
                    ;;
                *)
                    echo "Invalid response, command ending. Heading to main menu..."
                    ;;
            esac
            ;;

        2)
            destination=""
            echo "What is the URL of the repository you want to clone?"
            read sub_menu_choice
            echo "What is the name of the directory to clone to?"
            read destination
            echo "Cloning repository from ${sub_menu_choice} ..."
            mygit_clone $url $destination
            ;;

        3)
            file=""
            while [[ "$file" != "all" && "$file" != "done" ]]
            do
                echo "Do you want to add or unstage files?
    1. Add
    2. Unstage"
                read sub_menu_choice

                git status | grep -Pv "  \(use"

                case "$sub_menu_choice" in
                    1) 
                        echo "What file do you want to add? 
Or enter 'all' to add all files. Or enter 'done' when finished.
"
                        read file
                        if [[ "$file" != "done" ]]; then
                            echo "Adding ${file} to the commit..."
                            mygit_add $file
                        fi
                        ;;
                    2)
                        echo "What file do you want to unstage? 
Or enter 'all' to unstage all files. Or enter 'done' when finished.
"
                        read file
                        if [[ "$file" != "done" ]]; then
                            echo "Unstaging ${file} from the commit..."
                            mygit_remove $file
                        fi
                        ;;
                    *)
                        echo "Invalid selection..."
                        ;;
                esac
            done
            ;;

        4)
            message=""
            git status | grep -Pv "  \(use"
            
            echo "Please enter your commit message:"
            read message

            if [ -z "$message" ]; then
                echo "Commit message cannot be empty."
            fi

            mygit_commit $message
            ;;

        5)
            confirmation=""
            while [[ "$confirmation" != "y" && "$confirmation" != "n" ]] 
            do
                echo "Are you sure you want to push your changes? (Y/N)"
                read confirmation
                confirmation="${confirmation,,}"
                if [[ "$confirmation" != "y" || "$confirmation" != "n" ]]; then
                    echo "Invalid entry, please try again."
                elif [[ "$confirmation" == "y" ]]; then
                    mygit_push
                else
                    echo "Push aborted..."
                fi
            done
            ;;

        6)  
            echo "Pulling changes from remote repository..."
            mygit_pull
            ;;
        
        7)
            choice=0
            while [[ $choice -ne 9 ]]
            do
                echo "Please select from the below options:
    1. Add a directory
    2. Remove a directory (entirely with its contents)
    3. Add a file
    4. Remove a file
    9. BACK"
                read choice

                case "$choice" in
                    1)
                        ls
                        echo "Please enter the directory name to add:"
                        read directory
                        mkdir "$directory"
                        ;;
                    2)
                        ls
                        echo "Please enter the directory name to remove:"
                        read directory
                        rm -r "$directory"
                        ;;
                    3)
                        echo "Please enter the file name to add:"
                        read file
                        touch "$file"
                        ;;
                    4)
                        echo "Please enter the file name to remove:"
                        read file
                        rm "$file"
                        ;;
                    9)
                        break
                        ;;
                    *)
                        echo "Invalid option, try again."
                        ;;
                esac
            done
            ;;

        9)
            break
            ;;

        *)
            echo "That was an invalid option, please try again."
            ;;
    esac
done

echo "Thanks for using mygit!"

exit 0
