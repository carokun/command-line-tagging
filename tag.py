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
	pickle.dump(file_to_tags, open(".file_to_tags.p", "rb"))



def main(argv):
	tag_to_files, file_to_tags = load_data()

	command = argv[0].lower()

	if command == 'add':
	 	tag = argv[1].lower()
	 	files = argv[2:]
		

if __name__ == "__main__":
   main(sys.argv[1:])