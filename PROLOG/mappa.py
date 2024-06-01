import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.animation import FuncAnimation


muri = [
    (1,6),
    (2,2),
    (2,8),
    (3,8),
    (4,4),
    (4,5),
    (5,5),
    (6,2),
    (7,2),
    (7,6),
    (8,3)
    ]

def parse_position(position_str):
    x, y = map(int, position_str.strip('pos()').split(','))
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

def create_map():
    fig, ax = plt.subplots()
    ax.set_xlim(0, 8)
    ax.set_ylim(0, 8)
    ax.set_xticks(range(9))
    ax.set_yticks(range(9))
    ax.grid(True)
    plt.gca().invert_yaxis()
    return fig, ax

def update_map(frame, ax, data):
    ax.clear()
    ax.set_xlim(0, 8)
    ax.set_ylim(0, 8)
    ax.set_xticks(range(9))
    ax.set_yticks(range(9))
    ax.grid(True)
    plt.gca().invert_yaxis()
    
    position, ghiaccio, gemme = data[frame]

    # Add muri
    for pos in muri:
        ax.add_patch(patches.Rectangle((pos[1]-1, pos[0]-1), 1, 1, edgecolor='black', facecolor='black'))

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
            if pos==posG:
                ax.add_patch(patches.Rectangle((pos[1], pos[0]), 1, 1, edgecolor='black', facecolor='green'))
def main():
    data = read_file('output.txt')
    fig, ax = create_map()
    
    ani = FuncAnimation(fig, update_map, frames=len(data), fargs=(ax, data), repeat=False, interval=3000)
    
    plt.show()

if __name__ == "__main__":
    main()
