from database import *
from utils import print_prettier_dict

class Board:
    map_graph = {}
    map_pos_dir = {}
    def __init__(self):
        self.get_map_graph()
    
    def get_map_graph(self):
        positions = get_all_positions()
        positions = self.filter_none_positions(positions)

        self.map_graph = {}
        for position in positions:
            self.map_graph[position['id']] = [ value for key, value in position.items() if(key != 'id' and key != 'id_regiao') ]
            self.map_pos_dir[position['id']] = { value : key for key, value in position.items() if(key != 'id' and key != 'id_regiao')  }
        return positions
    
    def bfs_distance(self, initial_pos):
        distance = [-1] * (len(self.map_graph) + 1)
        parent = [-1] * (len(self.map_graph) + 1)
        initial_vertice = initial_pos

        to_visit = []
        to_visit.append(initial_vertice)
        distance[initial_vertice] = 0

        while(len(to_visit) > 0):
            u = to_visit.pop(0)
            for v in self.map_graph[u]:
                if distance[v] == -1:
                    distance[v] = distance[u] + 1
                    parent[v] = u
                    to_visit.append(v)
        return distance, parent

    def print_map(self, initial_pos):
        distance, parent = self.bfs_distance(initial_pos)
        levels = {}
        for i in range(0, max(distance) + 1):
            levels[i] = []
        for i in range(1, len(distance)):
            levels[distance[i]].append(i)

        formated_levels = {}
        formated_levels[0] = [levels[0]]
        for i in range(1, len(levels)):
            parent_list = []
            for v_parent in levels[i-1]:
                child_list = [v_child for v_child in levels[i] if parent[v_child] == v_parent]
                parent_list.append(child_list)
            formated_levels[i] = parent_list            

        output_texts = []
        for value in formated_levels.values():
            out_text = ''
            for i in range(len(value)):
                if len(value[i]) > 0:
                    values_parent = parent[value[i][0]]
                else:
                    values_parent = ''
                if(values_parent != -1):
                    if values_parent != '':
                        out_text += 'De ' + str(values_parent) + ' você pode ir para: '
                        for v in value[i]:
                            out_text += (
                                '(' + self.map_pos_dir[values_parent][v].capitalize() + 
                                ', ' + str(v) + ')' + ' '
                            )
                        if i + 1 < len(value):
                            out_text += '\n'
                        else:
                            out_text += '\n\n'
                            output_texts.append(out_text)
                            out_text = ''
                else:
                    output_texts.append('Você está aqui: ' + str(value[i][0]) + '\n')

        # biggest_string_size = max(len(text) for text in output_texts) // 2
        for text in output_texts:
            # print(' ' * (biggest_string_size - (len(text) // 2)), sep='', end='')  
            print(text, sep='', end='')
        print('\n(Aperte enter tecla para continuar...)')
        input()

    def filter_none_positions(self, positions):
        filtered_pos = []
        for position in positions:
            filtered_pos.append({key : value for key, value in position.items() if value != None})
        return filtered_pos
