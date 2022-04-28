from utils import *
from database import get_user_info
from moviment import path, valid_region_change_db, change_player_pos

def start_game(player_name):
    user_info = get_user_info(player_name)
    print_prettier_dict(user_info)
    while True:
        print_title('Movimentação possível: ')
        display = path(player_name)
        i = 0
        for d in display:
            i += 1
            print(f"{i} - {list(d.keys())[0].capitalize()}", end='\n')

        print('0 - Sair')

        tecla = input()

        try:
            tecla = int(tecla)
        except:
            print('Opção inválida, tente novamente.\n\n')
            continue

        if tecla > 0 and tecla <= len(display):
            choose = list(display[tecla-1].values())[0]

            can_acess = valid_region_change_db(choose, player_name)
            if can_acess == 1:
                change_player_pos(choose, player_name)
                clean_bash()
            else:
                print_title('Você ainda não tem pokemons suficientes para acessar essa região')
        elif tecla == 0:
            return ''
        else:
            print('Opção inválida, tente novamente.\n\n')
