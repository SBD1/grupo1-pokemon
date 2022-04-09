from database import run_query_fetchall, run_query_fetchone, run_update, get_user_info
# from utils import print_prettier_dict

def get_player_position(player_name):
    sql = f'SELECT id_posicao FROM treinador WHERE nome={player_name}'
    result = run_query_fetchone(sql)
    return result['id_posicao']


def get_movement_directions(pos):
    sql = f'SELECT p.norte, p.sul, p.leste, p.oeste, p.cima, p.baixo FROM posicao p WHERE p.id = {pos}'
    result = run_query_fetchall(sql)
    positions_available = []
    for pos in result:
        positions_available.append(dict(pos))
    return positions_available[0];


def get_display_available_pos(positions_available):
    positions = positions_available.keys()
    positions_not_none = []
    for pos in positions:
        if positions_available[pos] != None:
            to_append = {pos: positions_available[pos]}
            positions_not_none.append(to_append)
    return positions_not_none[:];


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
def choose_player_path(player_name, player_ini_pos):
    directions = get_movement_directions(player_ini_pos)
    display = get_display_available_pos(directions)

    available_directions = []
    for direction in display:
        available_directions.append(direction.keys(0))

    print(available_directions)

    input_directions = get_char_position(available_directions)

    # print(input_directions)
    
    print('Escolha seu caminho treinador: ', end='\n')
    print('Você pode seguir para as seguintes direções: ', end='\n\n')

    for input_char in input_directions:
        text = get_char_equivalence(input_char, 'exibition')
        print(input_char +' -> ' + text, end='\n\n')

    ok = 0
    while ok == 0:
        choose = input('Qual sua escolha?\n\n')
        if choose in input_directions:
            ok = 1
        else:
            print('Escolha novamente', end='\n')

    direction_chosen = directions[get_char_equivalence(choose, 'db')]
    
    change_player_pos(direction_chosen, player_name)



# print(get_user_info())
# print(change_player_pos(1, '\'Ash Ketchum\''))

player_name = '\'Ash Ketchum\''

choose_player_path(player_name, get_player_position(player_name))

# print(get_display_available_pos(get_movement_directions(4)))


