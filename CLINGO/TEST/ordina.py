def leggi_dati(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    dati_ritorno = []
    dati_andata = []
    
    for line in lines:
        line = line.strip()
        if line.startswith('assign_ritorno'):
            parts = line.replace('assign_ritorno(', '').replace(')', '').split(',')
            dati_ritorno.append((int(parts[0]), parts[1], parts[2]))
        elif line.startswith('assign_andata'):
            parts = line.replace('assign_andata(', '').replace(')', '').split(',')
            dati_andata.append((int(parts[0]), parts[1], parts[2]))
    
    return dati_ritorno, dati_andata

def ordina_dati(dati):
    return sorted(dati, key=lambda x: (x[0], x[1], x[2]))

def stampa_dati(prefix, dati):
    for d in dati:
        print(f"{prefix}({d[0]},{d[1]},{d[2]})")

file_path = 'dati.txt'

dati_ritorno, dati_andata = leggi_dati(file_path)

dati_ritorno_ordinati = ordina_dati(dati_ritorno)
dati_andata_ordinati = ordina_dati(dati_andata)

print("Dati Ritorno Ordinati:")
stampa_dati('assign_ritorno', dati_ritorno_ordinati)

print("\nDati Andata Ordinati:")
stampa_dati('assign_andata', dati_andata_ordinati)
