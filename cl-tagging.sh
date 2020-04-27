#!/bin/bash

has_f=1
has_d=1
has_e=1
has_h=1
command_type=$1
file=""
dir=""
extension=""

ctr=1
for i in "$@"
do
    if [[ $i == "-h" ]]
    then
        ./help.sh
        exit 0
    elif [[ $i == "-f" ]]
    then
        has_f=0
        j=$(($ctr+1))
        file=${!j}
        if [[ ! -f $file ]]
        then
            echo -e "ERROR: File $file does not exist." 1>&2
            exit 1
        fi
    elif [[ $i == "-e" ]]
    then
        has_e=0
        j=$(($ctr+1))
        extension=${!j}
    elif [[ $i == "-d" ]]
    then
        has_d=0
        j=$(($ctr+1))
        dir=${!j}
        if [[ ! -d $dir ]]
        then
            echo "ERROR: Directory $dir does not exist." 1>&2
            exit 1
        fi
    fi
    ctr=$(($ctr+1))
done

if [[ $command_type == "add" ]]
then
    tag_name=$2
    if [[ has_f -eq 0 ]]
    then
        python3 tag.py $command_type $tag_name $file
    elif [[ has_e -eq 0 && has_d -eq 0 ]]
    then
        files=$(find $dir -type f -maxdepth 1 | grep $extension | tr '\n' ' ')
        python3 tag.py $command_type $tag_name $files
    elif [[ has_d -eq 0 ]]
    then
        files=$(find $dir -type f -maxdepth 1 | tr '\n' ' ')
        python3 tag.py $command_type $tag_name $files
    else
        echo "ERROR: The add argument must be ran with -f <filename> or -d <directory>" 1>&2
        exit 127
    fi
elif [[ $command_type == "remove" ]]
then
    tag_name=$2
    if [[ has_f -eq 0 ]]
    then
        python3 tag.py $command_type $tag_name $file
    elif [[ has_d -eq 0 && has_e -eq 0 ]]
    then
        files=$(find $dir -type f -maxdepth 1 | grep $extension | tr '\n' ' ')
        python3 tag.py $command_type $tag_name $files
    elif [[ has_d -eq 0 ]]
    then
        files=$(find $dir -type f -maxdepth 1 | tr '\n' ' ')
        python3 tag.py $command_type $tag_name $files
    else
        files="$(python3 tag.py list $tag_name | sed 's/^.*://' | tr ',' ' ')"
        python3 tag.py $command_type $tag_name $files
    fi
elif [[ $command_type == "view" ]]
then
    if [[ ! -f $2 ]]
    then
        echo "ERROR: File $file does not exist." 1>&2
        exit 1
    fi
    python3 tag.py $*
elif [[ $command_type == "list" ]]
then
    python3 tag.py $*
elif [[ $command_type == "copy" ]]
then
    tag_name=$2
    dir=$3
    mkdir -p $dir

    files="$(python3 tag.py list $tag_name | sed 's/^.*://' | tr ',' ' ')"
    cp $files $dir
fi
