import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.animation import FuncAnimation
import re

def parse_position(position_str):
    x, y = map(int, re.findall(r'\d+', position_str))
    return (x - 1, y - 1)  # Convert to 0-indexed

def parse_positions(positions_str):
    positions_str = positions_str.strip('[]')
    return [parse_position(pos_str) for pos_str in positions_str.split('),pos(') if pos_str]

def read_file(filename):
    with open(filename, 'r') as file:
        lines = file.read().strip().split('\n\n')
    data = []
    for block in lines:
        lines = block.split('\n')
        position = parse_position(lines[0].split(': ')[1])
        ghiaccio = parse_positions(lines[1].split(': ')[1])
        gemme = parse_positions(lines[2].split(': ')[1])
        data.append((position, ghiaccio, gemme))
    return data

def read_muri_finale(filename):
    with open(filename, 'r') as file:
        lines = file.readlines()
    muri = []
    finali = []
    dimensione = (dimensioneT, dimensioneT)
    for line in lines:
        if line.startswith('dim'):
            dimension = re.search(r'dim\((\d+),(\d+)\)', line)
            if dimension:
                dimensione = (int(dimension.group(1)), int(dimension.group(2)))
        elif line.startswith('occupata'):
            position = re.search(r'occupata\(pos\((\d+),(\d+)\)\)', line)
            if position:
                muri.append(parse_position(f"pos({position.group(1)},{position.group(2)})"))
        elif line.startswith('finale'):
            position = re.search(r'finale\(pos\((\d+),(\d+)\)\)', line)
            if position:
                finali.append(parse_position(f"pos({position.group(1)},{position.group(2)})"))
    return muri, finali, dimensione

def read_martello(filename):
    with open(filename, 'r') as file:
        lines = file.readlines()
    for line in lines:
        if line.startswith('martello'):
            position = re.search(r'martello\(pos\((\d+),(\d+)\)\)', line)
            if position:
                return parse_position(f"pos({position.group(1)},{position.group(2)})")
    return None

def create_map(dimensione):
    fig, ax = plt.subplots()
    ax.set_xlim(0, dimensione[1])
    ax.set_ylim(0, dimensione[0])
    ax.set_xticks(range(dimensione[1] + 1))
    ax.set_yticks(range(dimensione[0] + 1))
    ax.grid(True)
    plt.gca().invert_yaxis()
    return fig, ax

def update_map(frame, ax, data, muri, finali, martello, dimensione):
    ax.clear()
    ax.set_xlim(0, dimensione[1])
    ax.set_ylim(0, dimensione[0])
    ax.set_xticks(range(dimensione[1] + 1))
    ax.set_yticks(range(dimensione[0] + 1))
    ax.grid(True)
    plt.gca().invert_yaxis()
    
    position, ghiaccio, gemme = data[frame]

    # Add muri
    for pos in muri:
        ax.add_patch(patches.Rectangle((pos[1], pos[0]), 1, 1, edgecolor='black', facecolor='black'))

    # Add finali
    for pos in finali:
        ax.add_patch(patches.Rectangle((pos[1], pos[0]), 1, 1, edgecolor='black', facecolor='orange'))

    # Add martello
    if martello:
        ax.add_patch(patches.Rectangle((martello[1], martello[0]), 1, 1, edgecolor='black', facecolor='lightyellow'))

    # Add position
    ax.add_patch(patches.Circle((position[1] + 0.5, position[0] + 0.5), 0.3, color='blue'))

    # Add ghiaccio
    for pos in ghiaccio:
        ax.add_patch(patches.Rectangle((pos[1], pos[0]), 1, 1, edgecolor='black', facecolor='cyan'))

    # Add gemme
    for pos in gemme:
        ax.add_patch(patches.Rectangle((pos[1], pos[0]), 1, 1, edgecolor='black', facecolor='yellow'))

    for pos in ghiaccio:
        for posG in gemme:
            if pos == posG:
                ax.add_patch(patches.Rectangle((pos[1], pos[0]), 1, 1, edgecolor='black', facecolor='green'))

dimensioneT=25
Labirinto='./Labirinto/labirinto25x25.pl'
LabMostro='./Mostriciattolo/labirinto25x25.pl'

def main():
    data = read_file('output.txt')
    muri, finali, dimensione = read_muri_finale(Labirinto)
    martello = read_martello(LabMostro)

    fig, ax = create_map(dimensione)
    
    ani = FuncAnimation(fig, update_map, frames=len(data), fargs=(ax, data, muri, finali, martello, dimensione), repeat=False, interval=1000)
    
    plt.show()

if __name__ == "__main__":
    main()

