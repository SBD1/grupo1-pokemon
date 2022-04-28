from utils import *
from database import get_user_info
from moviment import path, valid_region_change_db, change_player_pos
import time

def start_game(player_name):
    user_info = get_user_info(player_name)
    print_prettier_dict(user_info)

    while True:
        print('\n\n')
        print_title('Menu')
        count = 1

        # Pokémon na posição
        pokemons = [1] # checar pokemons na posição
        if pokemons != []:
            pokemon_name = 'Alfredo' # pokemons[0]['specie']
            print_subtitle(f'UM(A) {pokemon_name.upper()} SELVAGEM APARECEU!!!')
            print(f'{count} - Tentar capturar o(a) {pokemon_name}')
            count += 1

        # NPC na posição
        NPCs = [1] # checar nps na posição
        if NPCs != []:
            npc_name = 'Godofredo' # NPCs[0]['nome']
            print_subtitle('Um viajante cruzou seu caminho...')
            print(f'{count} - Interagir com {npc_name}')
            count += 1

        # Items no chão
        items = [1] # checar items no chão
        if items != []:
            print_subtitle('Um item encontrados no chão!')
            item_name = 'Jujuba' # items[0]['nome']
            print(f'{count} - Pegar {item_name} do chão')
            count += 1

        # Movimentação        
        positions = path(user_info['id_posicao'])
        if positions != []:
            print_subtitle('Para onde desejar ir?')
            for p in positions:
                print(f'{count} - {list(p.keys())[0].capitalize()}')
                count += 1

        print(f'{count} - Abrir inventário')
        print('0 - Sair')

        tecla = input('Insira sua escolha: ')

        try:
            tecla = int(tecla)
        except:
            print('Opção inválida, tente novamente.')
            continue

        if tecla > 0 and tecla < count:
            curr_size = len(pokemons)
            if tecla <= curr_size:
                # pokemon action
                print('Pokemon action na pos: ', tecla)
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

            # move action
            normalized_input = tecla - curr_size
            print('Move action na pos: ', normalized_input)
            choose = list(positions[normalized_input-1].values())[0]
            can_acess = valid_region_change_db(choose, user_info['nome'])
            if can_acess == 1:
                user_info['id_posicao'] = change_player_pos(choose, user_info['nome'])
            else:
                print_title('Você ainda não tem pokemons suficientes para acessar essa região')
                time.sleep(1.5)
        elif tecla == count:
            # abrir inventário
            print('Abrir inventário')
            continue
        elif tecla == 0:
            return ''
        else:
            print('Opção inválida, tente novamente.\n\n')
