from utils import *
from database import get_user_info, get_pokemon_on_position, remove_pokemon_from_position
from moviment import path, valid_region_change_db, change_player_pos
from catch import Catch
import time

MAP_DIRECTIONS_KEYBOARD = {
    'norte' : 'W',
    'sul'   : 'S',
    'oeste' : 'A',
    'leste' : 'D',
    'cima'  : 'Q',
    'baixo' : 'E',
}
MAP_KEYBOARD_DIRECTIONS = {
    'w' : 'norte',
    's' : 'sul'  ,
    'a' : 'oeste',
    'd' : 'leste',
    'q' : 'cima' ,
    'e' : 'baixo'
}

def start_game(player_name):
    user_info = get_user_info(player_name)
    print_prettier_dict(user_info)

    while True:
        print('\n\n')
        print_title('Menu')
        count = 1

        pokemon, count = display_pokemons(user_info['id_posicao'], count)
        NPCs, count = display_npcs(count)
        items, count = display_items(count)

        print_subtitle('Inventário')
        print(f'{count} - Olhar mochila')

        positions = display_positions(user_info['id_posicao'])

        print('0 - Sair')

        tecla = input('Insira sua escolha: ')

        if tecla.lower() in MAP_KEYBOARD_DIRECTIONS.keys() and positions != {}:
            choose = positions[MAP_KEYBOARD_DIRECTIONS[tecla.lower()]]
            can_acess = valid_region_change_db(choose, user_info['nome'])
            if can_acess == 1:
                user_info['id_posicao'] = change_player_pos(choose, user_info['nome'])
            else:
                print_title('Você ainda não tem pokemons suficientes para acessar essa região')
                time.sleep(1.5)
        else:
            try:
                tecla = int(tecla)
            except:
                print('Opção inválida, tente novamente.')
                continue

            if tecla > 0 and tecla < count:
                curr_size = 1 if pokemon else 0
                if tecla <= curr_size:
                    catch = Catch(pokemon, user_info['nome'])
                    if catch.display():
                        remove_pokemon_from_position(user_info['id_posicao'], pokemon)
                    continue
                
                curr_size += len(NPCs)
                if tecla <= curr_size:
                    normalized_input = tecla - curr_size + len(NPCs)
                    # NPC action
                    print('NPC action na pos: ', normalized_input)
                    continue
                
                curr_size += len(items)
                if tecla <= curr_size:
                    normalized_input = tecla - curr_size + len(items)
                    print('Item action na pos: ', normalized_input)
                    # item action
                    continue
            elif tecla == count:
                # abrir inventário
                print('Abrir inventário')
                continue
            elif tecla == 0:
                return ''
            else:
                print('Opção inválida, tente novamente.\n\n')

def display_pokemons(pos, count):
    pokemon = get_pokemon_on_position(pos)
    if pokemon:
        print_subtitle(f'UM POKEMON SELVAGEM APARECEU!!!')
        print(f'{count} - Tentar capturar?!')
        count += 1
    return pokemon, count

def display_npcs(count):
    NPCs = [1] # checar nps na posição
    if NPCs != []:
        npc_name = 'Godofredo' # NPCs[0]['nome']
        print_subtitle('Um viajante cruzou seu caminho...')
        print(f'{count} - Interagir com {npc_name}')
        count += 1
    return NPCs, count

def display_items(count):
    items = [1] # checar items no chão
    if items != []:
        print_subtitle('Um item encontrados no chão!')
        item_name = 'Jujuba' # items[0]['nome']
        print(f'{count} - Pegar {item_name} do chão')
        count += 1
    return items, count

def display_positions(user_position):
    positions = path(user_position)
    if positions != {}:
        print_subtitle('Para onde desejar ir?')
        for p in positions.keys():
            print(f'{MAP_DIRECTIONS_KEYBOARD[p.lower()]} - {p.capitalize()}')
    return positions