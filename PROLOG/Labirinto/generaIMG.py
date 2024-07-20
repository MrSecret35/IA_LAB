import matplotlib.pyplot as plt
import numpy as np
import re

# Funzione per leggere il file e ottenere le posizioni e dimensioni
def parse_prolog_file(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    occupied_positions = []
    initial_position = None
    final_positions = []
    rows, cols = None, None

    for line in lines:
        if 'num_righe' in line:
            rows = int(re.findall(r'\d+', line)[0])
        elif 'num_colonne' in line:
            cols = int(re.findall(r'\d+', line)[0])
        elif 'iniziale' in line:
            initial_position = tuple(map(int, re.findall(r'\d+', line)))
        elif 'finale' in line:
            final_positions.append(tuple(map(int, re.findall(r'\d+', line))))
        elif 'occupata' in line:
            occupied_positions.append(tuple(map(int, re.findall(r'\d+', line))))
    
    return rows, cols, initial_position, final_positions, occupied_positions

# Funzione per generare la griglia e salvarla come immagine
def generate_labirinto_image(file_path, output_image):
    rows, cols, initial_position, final_positions, occupied_positions = parse_prolog_file(file_path)

    # Creazione della griglia
    grid = np.ones((rows, cols, 3))  # Sfondo bianco

    # Colori
    light_blue = [0.678, 0.847, 0.902]
    green = [0, 1, 0]
    orange = [1, 0.647, 0]

    # Impostazione della posizione iniziale, finale e delle posizioni occupate
    grid[initial_position[0] - 1, initial_position[1] - 1] = green
    for pos in final_positions:
        grid[pos[0] - 1, pos[1] - 1] = orange
    for pos in occupied_positions:
        grid[pos[0] - 1, pos[1] - 1] = light_blue

    # Tracciamento della griglia su sfondo bianco
    fig, ax = plt.subplots(figsize=(20, 20))
    ax.imshow(grid, aspect='equal')

    # Impostazione della griglia
    ax.set_xticks(np.arange(-0.5, rows, 1), minor=True)
    ax.set_yticks(np.arange(-0.5, cols, 1), minor=True)
    ax.grid(which='minor', color='black', linestyle='-', linewidth=1)

    # Aggiunta di numeri per indicare le posizioni ai lati della griglia
    for i in range(rows):
        ax.text(-1, i, f'{i+1}', ha='center', va='center', color='black', fontsize=6)
        ax.text(cols, i, f'{i+1}', ha='center', va='center', color='black', fontsize=6)

    for j in range(cols):
        ax.text(j, -1, f'{j+1}', ha='center', va='center', color='black', fontsize=6)
        ax.text(j, rows, f'{j+1}', ha='center', va='center', color='black', fontsize=6)

    # Rimozione dei tick
    ax.set_xticks([])
    ax.set_yticks([])

    # Salvataggio dell'immagine
    plt.savefig(output_image)
    plt.show()

# Esempio di utilizzo
generate_labirinto_image('labirinto8x8.pl', 'labirinto8x8.png')
generate_labirinto_image('labirinto8x8NoSol.pl', 'labirinto8x8NoSol.png')

generate_labirinto_image('labirinto10x10.pl', 'labirinto10x10.png')
generate_labirinto_image('labirinto10x10NoSol.pl', 'labirinto10x10NoSol.png')

generate_labirinto_image('labirinto16x16.pl', 'labirinto16x16.png')

generate_labirinto_image('labirinto50x50.pl', 'labirinto50x50.png')

generate_labirinto_image('labirinto100x100.pl', 'labirinto100x100.png')
