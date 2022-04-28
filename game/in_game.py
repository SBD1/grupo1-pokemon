from utils import *
from database import get_user_info
from moviment import player_path, choose_path

def start_game(player_name):
    user_info = get_user_info(player_name)
    print_prettier_dict(user_info)
    while True:
        print_title('Movimentação possível: ')
        player_path(player_name)
        choose = input()
        res = choose_path(player_name, choose)
        print(res)
        if res == 0:
            return
        elif res == 1:
            clean_bash()
        elif res == -1:
            print_subtitle('Escolha inválida')
        elif res == 2:
            print_title('Você ainda não tem pokemons suficientes para acessar essa região')
