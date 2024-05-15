import json

def sort_all_value_strings(file_path):
    # Leggi il file JSON dal percorso specificato
    with open(file_path, 'r') as file:
        data = json.load(file)

    # Funzione per ordinare le stringhe all'interno di un campo "Value"
    def sort_value_strings(value):
        if isinstance(value, list):
            value.sort()

    # Funzione ricorsiva per iterare su tutti i campi "Value" nel JSON
    def traverse_and_sort(data):
        if isinstance(data, dict):
            for key, value in data.items():
                if key == "Value":
                    sort_value_strings(value)
                else:
                    traverse_and_sort(value)
        elif isinstance(data, list):
            for item in data:
                traverse_and_sort(item)

    # Ordina tutti i campi "Value" nel JSON
    traverse_and_sort(data)

    # Sovrascrivi il file JSON originale con le stringhe ordinate
    with open(file_path, 'w') as file:
        json.dump(data, file, indent=4)

# Percorso del file JSON
file_path = "./output.json"

# Chiama la funzione per ordinare tutte le stringhe nei campi "Value" nel file JSON
sort_all_value_strings(file_path)

print("Stringhe JSON ordinate con successo!")