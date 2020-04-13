# command-line-tagging
Final project repository for CIS 191.

To use our tool, call ./cl-tagging.sh with the appropriate arguments. There are five types of commands: add, remove, view, list, and copy commands. 

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
./cl-tagging.sh copy <tagname> <new_directory> copies all the files with this tag to the given directory.


