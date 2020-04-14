import sys
import pickle

"""
Adds the specified tag to the specified files by updating 
the tag_to_files and file_to_tags dictionaries
"""
def add_tags(tag, files, tag_to_files, file_to_tags):
	if tag in tag_to_files:
		tag_to_files[tag].update(files)

	else:
		tag_to_files[tag] = set(files)

	for file in files:
		if file in file_to_tags:
			file_to_tags[file].add(tag)
		else:
			file_to_tags[file] = set()
			file_to_tags[file].add(tag)

	save_data(tag_to_files, file_to_tags)

"""
Removes the speciifed tag from the specified files by 
updating the tag_to_files and file_to_tags dictionaries
"""
def remove_tags(tag, files, tag_to_files, file_to_tags):
	if tag in tag_to_files:
		tag_to_files[tag].difference_update(files)

		if len(tag_to_files[tag]) == 0:
			del tag_to_files[tag]

	for file in files:
		if file in file_to_tags:
			file_to_tags[file].remove(tag)

			if len(file_to_tags[file]) == 0:
				del file_to_tags[file]

	save_data(tag_to_files, file_to_tags)

"""
Returns all the tags for the given file
"""
def view_tags(file, file_to_tags):
	tags = list(file_to_tags[file]) if file in file_to_tags else []
	return tags

"""
Returns all the files tagged with the given tag
"""

def view_files(tag, tag_to_files):
	files = list(tag_to_files[tag]) if tag in tag_to_files else []
	return files

"""
Loads the tag_to_files, file_to_tags dictionaries if they exist. 
Otherwise, will initailize them to empty dictionaries
"""
def load_data():
	tag_to_files = {}
	file_to_tags = {}

	try:
		tag_to_files = pickle.load(open(".tag_to_files.p", "rb"))
		file_to_tags = pickle.load(open(".file_to_tags.p", "rb"))
	except (OSError, IOError) as e:
		pass

	return tag_to_files, file_to_tags

"""
Saves the tag_to_files, file_to_tags dictionaries as pickle files 
"""
def save_data(tag_to_files, file_to_tags):
	pickle.dump(tag_to_files, open(".tag_to_files.p", "wb"))
	pickle.dump(file_to_tags, open(".file_to_tags.p", "wb"))


def main(argv):	
	if len(argv) == 0:
		print("No command inputted!")

	tag_to_files, file_to_tags = load_data()
	command = argv[0].lower()

	if command == "add":
		tag = argv[1].lower()
		files = argv[2:]
		add_tags(tag, files, tag_to_files, file_to_tags)

	elif command == "remove":
		tag = argv[1].lower()
		files = argv[2:]
		remove_tags(tag, files, tag_to_files, file_to_tags)

	elif command == "view":
		file = argv[1]
		tags = view_tags(file, file_to_tags)
		tags_str = ', '.join([str(elem) for elem in tags])
		print("The tags for", file, "are:", tags_str)

	elif command == "list":
		tag = argv[1].lower()
		files = view_files(tag, tag_to_files)
		files_str = ', '.join([str(elem) for elem in files])
		print("The files tagged with", tag, "are:", files_str)

	else: 
		print("Command not valid!")

if __name__ == "__main__":
   main(sys.argv[1:])