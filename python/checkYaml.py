import os
import yaml

def search_sequence_in_yaml(file_path, sequence):
    with open(file_path, 'r') as f:
        lines = f.readlines()

        # Convert lines list to a single string
        yaml_content = ''.join(lines)

        # Load YAML content
        try:
            yaml_data = yaml.safe_load(yaml_content)
        except yaml.YAMLError as e:
            print(f"Error parsing YAML in {file_path}: {e}")
            return False

        # Check if the sequence of lines exists in the YAML data
        return sequence in yaml_content

# Directory containing YAML files
directory_path = '/path/to/your/directory'

# Sequence of lines you want to search for
sequence = "metadata:\n   name: frontend"

# Iterate through files in the directory
for filename in os.listdir(directory_path):
    if filename.endswith(".yaml") or filename.endswith(".yml"):
        file_path = os.path.join(directory_path, filename)
        if search_sequence_in_yaml(file_path, sequence):
            print(f"Sequence found in {filename}")
