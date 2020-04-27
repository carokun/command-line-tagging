#!/bin/bash

# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "
${CYAN}There are five types of commands: add, remove, view, list, and copy commands.

1. ADD commands

./cl-tagging.sh add <tagname> -f <filename> adds a tag to the specified file.
./cl-tagging.sh add <tagname> -d <folder>  adds a tag to all the files in the specified folder.
./cl-tagging.sh add <tagname> -d <folder> -e <extension>  adds a tag to all the files with the specified extension in the specified folder.

2. REMOVE commands

./cl-tagging.sh remove <tagname> -f <filename> removes a tag to the specified file.
./cl-tagging.sh remove <tagname> -d <folder>  removes a tag to all the files in the specified folder.
./cl-tagging.sh remove <tagname> -d <folder> -e <extension> removes a tag to all the files with the specified extension in the specified folder.
./cl-tagging.sh remove <tagname> removes the given tag from all the files its present on.

3. VIEW commands
./cl-tagging.sh view <filename> prints all the tags (if any) for a given file.

4. LIST commands
./cl-tagging.sh list <tagname> prints a list of all the files with this tag.

5. COPY commands
./cl-tagging.sh copy <tagname> <new_directory> copies all the files with this tag to the given directory.${NC}"
