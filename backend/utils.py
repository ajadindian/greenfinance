import json

def save_to_file(data, filename):
    with open(filename, "w") as f:
        json.dump(data, f)

def load_from_file(filename):
    with open(filename, "r") as f:
        return json.load(f)