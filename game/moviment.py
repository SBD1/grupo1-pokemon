from unittest import result
from database import *
from initial_game import clean_bash
from utils import *

def get_player_position(player_name):
    sql = f'SELECT t.id_posicao FROM treinador t WHERE t.nome={player_name};'
    result = run_query_fetchone(sql)
    return result['id_posicao']

def get_player_position_db(player_name):
    sql = f'SELECT get_player_position({player_name});'
    result = run_query_fetchone(sql)['get_player_position']
    return result


def get_movement_directions(pos):
    sql = f'SELECT p.norte, p.sul, p.leste, p.oeste, p.cima, p.baixo FROM posicao p WHERE p.id = {pos};'
    result = run_query_fetchall(sql)
    positions_available = []
    for pos in result:
        positions_available.append(dict(pos))
    return positions_available[0]

def valid_region_change(pos, player_name):
    sql = f'SELECT r.entrada FROM regiao r WHERE r.id = (SELECT p.id_regiao FROM posicao p WHERE p.id = {pos});'
    entrada = run_query_fetchone(sql)['entrada']

    if entrada == 0:
        return 1
    else:
        sql_count_pokemon = f'SELECT COUNT(*) as n_capturados FROM captura WHERE id_treinador = {player_name};'
        pokemons_capturados = run_query_fetchone(sql_count_pokemon)['n_capturados']
        if pokemons_capturados >= entrada:
            return 1
        else:
            return 0

def valid_region_change_db(pos, player_name):
    sql = f'SELECT valid_region_change({pos}, {player_name});'
    valid_entry = run_query_fetchone(sql)['valid_region_change']
    return valid_entry

def get_display_available_pos(positions_available):
    positions = []
    for key in positions_available.keys():
        positions.append(key)
    positions_not_none = {}
    for pos in positions:
        if positions_available[pos] != None:
            to_append = {pos: positions_available[pos]}
            positions_not_none.update(to_append)
    return positions_not_none


def change_player_pos(pos, player_name):
    sql = f'UPDATE treinador SET id_posicao = {pos} WHERE nome = {player_name};'
    run_update(sql)
    
    return get_player_position(player_name)


def get_char_position(positions):
    char_array = []

    if 'norte' in positions:
        char_array.append('w')
    if 'sul' in positions:
        char_array.append('s')
    if 'leste' in positions:
        char_array.append('d')
    if 'oeste' in positions:
        char_array.append('a')
    if 'cima' in positions:
        char_array.append('q')
    if 'baixo' in positions:
        char_array.append('e')
    
    return char_array

def get_char_equivalence(char, pattern):
    
    if char == 'w':
        if pattern == 'db':
            return 'norte'
        elif pattern == 'exibition':
            return 'Norte'
    if char == 's':
        if pattern == 'db':
            return 'sul'
        elif pattern == 'exibition':
            return 'Sul'
    if char == 'd':
        if pattern == 'db':
            return 'leste'
        elif pattern == 'exibition':
            return 'Leste'
    if char == 'a':
        if pattern == 'db':
            return 'oeste'
        elif pattern == 'exibition':
            return 'Oeste'
    if char == 'q':
        if pattern == 'db':
            return 'cima'
        elif pattern == 'exibition':
            return 'Subir'
    if char == 'e':
        if pattern == 'db':
            return 'baixo'
        elif pattern == 'exibition':
            return 'Descer'


# Todo:  Fix dictionary reference from get_display_available_pos
def choose_player_path(player_name):
    player_ini_pos = get_player_position_db(player_name)
    directions = get_movement_directions(player_ini_pos)
    display = get_display_available_pos(directions)

    available_directions = []
    for direction in display:
        available_directions.append(direction)

    input_directions = get_char_position(available_directions)
    
    clean_bash()

    print_title('Escolha seu caminho treinador')
    print_subtitle('Você pode seguir para as seguintes direções: ')

    ok = 0
    while ok == 0:
        for input_char in input_directions:
            text = get_char_equivalence(input_char, 'exibition')
            print(input_char +' -> ' + text, end='\n')
        print('r -> Cancelar', end='\n')

        print_subtitle('Qual sua escolha?')
        choose = input('Direção: ')
        if choose == 'r':
            return 0
        elif choose in input_directions:
            direction_chosen = directions[get_char_equivalence(choose, 'db')]
            can_acess = valid_region_change_db(direction_chosen, player_name)
            if can_acess == 1:
                ok = 1
            else:
                clean_bash()
                print_title('Você ainda não tem pokemons suficientes para acessar essa região')
                print_subtitle('Escolha novamente')
        else:
            clean_bash()
            print_title('Essa direção não existe treinador')
            print_subtitle('Escolha novamente')
    
    return change_player_pos(direction_chosen, player_name)


### MOVIMENTATION DEBUGGING

player_name = '\'Ash Ketchum\''

choose_player_path(player_name)


