import json

def sort_value_strings(file_path):
    # Leggi il file JSON dal percorso specificato
    with open(file_path, 'r') as file:
        data = json.load(file)

    # Controlla se il campo "Value" esiste e se è una lista
    if "Call" in data and "Witnesses" in data["Call"][0] and "Value" in data["Call"][0]["Witnesses"][0]:
        # Ordina le stringhe all'interno di "Value"
        data["Call"][0]["Witnesses"][0]["Value"].sort()

    # Sovrascrivi il file JSON originale con le stringhe ordinate
    with open(file_path, 'w') as file:
        json.dump(data, file, indent=4)

# Percorso del file JSON
file_path = "./output.json"

# Chiama la funzione per ordinare le stringhe nel file JSON
sort_value_strings(file_path)

print("Stringhe JSON ordinate con successo!")