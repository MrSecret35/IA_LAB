import matplotlib.pyplot as plt
import numpy as np

#Da labirinto a prolog
def labirintoToProlog(maze, start, goals, rows, cols, filename):
    with open(filename, 'w') as file:
        file.write(f"num_righe({rows}).\n")
        file.write(f"num_colonne({cols}).\n\n")
        file.write(f"iniziale(pos({start[0]},{start[1]})).\n")
        for goal in goals:    
            file.write(f"finale(pos({goal[0]},{goal[1]})).\n\n")
        
        for row in range(1, rows + 1):
            for col in range(1, cols + 1):
                if maze[row, col] == 1:
                    file.write(f"occupata(pos({row},{col})).\n")

def generatoreLabirinto(rows, cols, filenameProlog):
    #1 se c'è il muro, 0 altrimenti
    maze = np.zeros((rows + 2, cols + 2))
    maze[2:6, 4] = 1
    maze[5, 4:8] = 1
    maze[8, 7] = 1
    maze[3, 7] = 1
    maze[4, 6] = 1
    maze[6, 7] = 1
    maze[6, 6] = 1
    maze[6, 5] = 1
    maze[7, 7] = 1
    maze[7, 6] = 1
    maze[7, 5] = 1

    start = (4, 1)
    goals = [(8, 9),(1,3)]

    labirintoToProlog(maze, start, goals, rows, cols, filenameProlog)

    #Stampa labirinto
    fig, ax = plt.subplots()

    for i in range(1, rows + 2):
        ax.plot([1, cols + 1], [i, i], color='k', linewidth=1)
        ax.plot([i, i], [1, rows + 1], color='k', linewidth=1)

    for row in range(1, rows + 1):
        for col in range(1, cols + 1):
            if maze[row, col] == 1:
                ax.add_patch(plt.Rectangle((col, rows - row + 1), 1, 1, color='deepskyblue'))

    ax.add_patch(plt.Rectangle((start[1], rows - start[0] + 1), 1, 1, color='orange', label='start'))
    for goal in goals:
        ax.add_patch(plt.Rectangle((goal[1], rows - goal[0] + 1), 1, 1, color='limegreen', label='goal'))

    ax.set_xlim(1, cols + 1)
    ax.set_ylim(1, rows + 1)
    ax.set_aspect('equal')
    ax.axis('off')

    ax.legend()
    plt.show()

generatoreLabirinto(10, 10, 'labirinto16x16.pl')