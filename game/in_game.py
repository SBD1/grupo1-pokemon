from purchase_item import open_seller_menu
from npc import check_npc_in_position, talk_with_npc
from utils import *
from database import get_item_full_details, get_item_id, get_papel_item, get_user_info, get_pokemon_on_position, remove_pokemon_from_position
from moviment import get_avaliable_items_in_position, get_display_available_pos, path, pick_item, valid_region_change_db, change_player_pos
from catch import Catch
from pokedex import Pokedex
from board import Board
from use_item import bag_menu
import time

MAP_DIRECTIONS_KEYBOARD = {
    'norte': 'W',
    'sul': 'S',
    'oeste': 'A',
    'leste': 'D',
    'cima': 'Q',
    'baixo': 'E',
}
MAP_KEYBOARD_DIRECTIONS = {
    'w': 'norte',
    's': 'sul',
    'a': 'oeste',
    'd': 'leste',
    'q': 'cima',
    'e': 'baixo'
}


def start_game(player_name):
    board = Board()
    user_info = get_user_info(player_name)
    user_info['board'] = board
    while True:
        clean_bash()
        # print_prettier_dict(user_info)
        print('\n\n')
        print_title('Menu')
        count = 1

        pokemon, count = display_pokemons(user_info['id_posicao'], count)
        NPC, count = display_npc(user_info["id_posicao"], count)
        items, count = display_items(user_info["id_posicao"], count)
        default_options, count = display_default_options(count)
        # print('Pokemon:', pokemon, '\nNPC:', NPC, '\nitems:', items, '\ndefault_options:', default_options)

        positions = display_positions(user_info['id_posicao'])
        print('0 - Sair')

        tecla = input('Insira sua escolha: ')
        clean_bash()
        if tecla.lower() in MAP_KEYBOARD_DIRECTIONS.keys() and positions != {} and MAP_KEYBOARD_DIRECTIONS[tecla.lower()] in positions.keys():
            choose = positions[MAP_KEYBOARD_DIRECTIONS[tecla.lower()]]
            can_acess = valid_region_change_db(choose, user_info['nome'])
            if can_acess == 1:
                user_info['id_posicao'] = change_player_pos(
                    choose, user_info['nome'])
            else:
                print_title(
                    'Voc?? ainda n??o tem pokemons suficientes para acessar essa regi??o')
                time.sleep(1.5)
        else:
            try:
                tecla = int(tecla)
            except:
                print('Op????o inv??lida, tente novamente.')
                continue

            if tecla > 0 and tecla < count:
                # print('Tecla:', tecla)
                curr_size = 1 if pokemon else 0
                # print('Curr size:', curr_size)
                if tecla <= curr_size:
                    # print('Pokemon action na pos:', tecla)
                    catch = Catch(pokemon, user_info['nome'])
                    if catch.display():
                        remove_pokemon_from_position(
                            user_info['id_posicao'], pokemon)
                    continue

                curr_size += 1 if NPC else 0
                # print('Curr size:', curr_size)
                if tecla <= curr_size:
                    normalized_input = tecla - curr_size + 1
                    # NPC action
                    # print('NPC action na pos: ', normalized_input)
                    if NPC['profissao'] == 'vendedor':
                        open_seller_menu(NPC['id'], user_info['nome'])
                    else:
                        talk_with_npc(NPC)
                    continue

                curr_size += len(items)
                # print('Curr size:', curr_size)
                if tecla <= curr_size:
                    normalized_input = tecla - curr_size + len(items)
                    pick_item(player_name, items[0]['id_instancia_item'])
                    continue
                
                curr_size += len(default_options)
                if tecla <= curr_size:
                    normalized_input = tecla - curr_size + len(default_options)
                    # print('Default action na pos: ', normalized_input)
                    default_options[normalized_input-1](user_info)
                    continue
            elif tecla == 0:
                return ''
            else:
                print('Op????o inv??lida, tente novamente.\n\n')


def display_pokemons(pos, count):
    pokemon = get_pokemon_on_position(pos)
    if pokemon:
        print_subtitle(f'UM POKEMON SELVAGEM APARECEU!!!')
        print(f'{count} - Tentar capturar?!')
        count += 1
    return pokemon, count


def display_npc(pos, count):
    # NPC na posi????o
    NPC = check_npc_in_position(pos)
    if NPC:
        print_subtitle('Um viajante cruzou seu caminho...')
        print(f'{count} - Interagir com {NPC["nome"]}')
        count += 1
    return NPC, count


def display_items(pos_id, count):
    items = get_avaliable_items_in_position(pos_id)
    if items != []:
        id_instancia_item = items[0]['id_instancia_item']
        item_id = get_item_id(id_instancia_item)["id_item"]
        papel = get_papel_item(item_id)["papel"]
        item_info = get_item_full_details(
                    id_instancia_item, papel)
        print_subtitle('Um item encontrados no ch??o!')
        item_name = item_info['nome']  # items[0]['nome']
        print(f'{count} - Pegar {item_name} do ch??o')
        count += 1
    return items, count


def display_positions(user_position):
    positions = path(user_position)
    if positions != {}:
        print_subtitle('Para onde desejar ir?')
        print_prompt(
            f'Voc?? est?? na posi????o [{user_position}], treinador.')
        for p in positions.keys():
            print(f'{MAP_DIRECTIONS_KEYBOARD[p.lower()]} - {p.capitalize()}')
    return positions

def display_default_options(count):
    default_options = [open_bag, open_pokedex, open_map]
    print_subtitle('Outras a????es')
    print(f'{count} - Olhar mochila')
    count += 1
    print(f'{count} - Olhar pokedex')
    count += 1
    print(f'{count} - Olhar mapa')
    count += 1
    return default_options, count


def open_pokedex(user_info):
    pokedex = Pokedex(user_info['nome'])
    pokedex.display()


def open_bag(user_info):
    bag_menu(user_info['nome'])

def open_map(user_info):
    user_info['board'].print_map(user_info['id_posicao'])