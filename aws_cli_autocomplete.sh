#!/bin/bash

aws_completer_paths=$(which aws_completer)
export AWS_COMPLETER_PATH=$aws_completer_paths
complete -C $AWS_COMPLETER_PATH aws