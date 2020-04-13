#!/bin/bash

#./cl-tagging.sh add <tagname> -f <filename> adds a tag to the specified file.
#./cl-tagging.sh add <tagname> -d <folder>  adds a tag to all the files in the specified folder.
#./cl-tagging.sh add <tagname> -d <folder> -e <extension>  adds a tag to all the files with the specified extension in the specified folder.
#./cl-tagging.sh remove <tagname> -f <filename> removes a tag to the specified file.
#./cl-tagging.sh remove <tagname> -d <folder>  removes a tag to all the files in the specified folder.
#./cl-tagging.sh remove <tagname> -d <folder> -e <extension> removes a tag to all the files with the specified extension in the specified folder.
#./cl-tagging.sh remove <tagname> removes the given tag from all the files its present on.
#./cl-tagging.sh view <filename> prints all the tags (if any) for a given file.
#./cl-tagging.sh list <tagname> prints a list of all the files with this tag.
#./cl-tagging.sh copy <tagname> <new_directory> copies all the files with this tag to the given directory.
 
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
        cat help.txt
        exit 0
    elif [[ $i == "-f" ]]
    then
        has_f=0
        j=$(($ctr+1))
        file=${!j}
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
    fi
    ctr=$(($ctr+1))
done

if [[ $command_type == "add" ]]
then
    tag_name=$2
    if [[ has_f -eq 0 ]]
    then
        python3 tag.py $command_type $tag_name $file
    elif [[ has_e -eq 0 ]]
    then
        files=$(ls $dir | grep $extension | tr '\n' ' ')
        python3 tag.py $command_type $tag_name $files
    else
        files=$(ls $dir | tr '\n' ' ')
        python3 tag.py $command_type $tag_name $files
    fi
elif [[ $command_type == "remove" ]]
then
    tag_name=$2
    if [[ has_f -eq 0 ]]
    then
        python3 tag.py $command_type $tag_name $file
    elif [[ has_d -eq 0 && has_e -eq 0 ]]
    then
        files=$(ls $dir | grep $extension | tr '\n' ' ')
        python3 tag.py $command_type $tag_name $files
    elif [[ has_d -eq 0 ]]
    then
        files=$(ls $dir | tr '\n' ' ')
        python3 tag.py $command_type $tag_name $files
    else
        files="$(python3 tag.py list $tag_name | tr '\n' ' ')"
        python3 tag.py $command_type $tag_name $files
    fi
elif [[ $command_type == "view" ]]
then
    python3 tag.py $*
elif [[ $command_type == "list" ]]
then
    python3 tag.py $*
elif [[ $command_type == "copy" ]]
then
    tag_name=$2
    dir=$3
    files="$(python3 tag.py list $tag_name | tr '\n' ' ')"
    cp $files $dir
fi

