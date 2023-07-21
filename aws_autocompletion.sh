#!/bin/bash

aws_completer_paths=$(which aws_completer)
bash_shell="/bin/bash"

if [ "$aws_completer_paths" ]; then
    export AWS_COMPLETER_PATH=$aws_completer_paths
    echo "Auto completer found"
else
    echo "Error: aws_completer not found."
fi

if [ "$SHELL" == "$bash_shell" ]; then
    echo "Bash shell is active"
    if [ -f ~/.bashrc ]; then
        echo 'complete -C $AWS_COMPLETER_PATH aws' >> ~/.bashrc
    elif [ -f ~/.bash_profile ]; then
        echo 'complete -C $AWS_COMPLETER_PATH aws' >> ~/.bash_profile
    else
        echo "Warning: Unable to find .bashrc or .bash_profile in your home directory."
    fi
else
    echo "Bash shell should be active for autocomplete setup."
fi
