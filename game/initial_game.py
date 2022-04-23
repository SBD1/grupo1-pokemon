from os import system, name
from database import get_user_info
from purchase_item import open_seller_menu
from utils import print_prettier_dict


def welcome_screen():
    print(r"""
                                      ,'\
    _.----.        ____         ,'  _\   ___    ___     ____
_,-'       `.     |    |  /`.   \,-'    |   \  /   |   |    \  |`.
\      __    \    '-.  | /   `.  ___    |    \/    |   '-.   \ |  |
 \.    \ \   |  __  |  |/    ,','_  `.  |          | __  |    \|  |
   \    \/   /,' _`.|      ,' / / / /   |          ,' _`.|     |  |
    \     ,-'/  /   \    ,'   | \/ / ,`.|         /  /   \  |     |
     \    \ |   \_/  |   `-.  \    `'  /|  |    ||   \_/  | |\    |
      \    \ \      /       `-.`.___,-' |  |\  /| \      /  | |   |
       \    \ `.__,'|  |`-._    `|      |__| \/ |  `.__,'|  | |   |
        \_.-'       |__|    `-._ |              '-.|     '-.| |   |
                                `'                            '-._|
    """)
    print('=======================================================================')
    print('Bem vindo ao jogo Gotta Catch \'Em All, seguem algumas instruções para que você consiga jogar')
    print('1. Movimentaçao: W(cima) A(esquerda) S(baixo) D(direita)')
    print('Aperte a tecla J para começar o jogo')
    tecla = input()
    while tecla != 'j' and tecla != 'J':
        tecla = input()
    clean_bash()
    start_game()
    # seller()


def clean_bash():
    if name == 'nt':
        _ = system('cls')
    else:
        _ = system('clear')


def start_game():
    user_info = get_user_info()
    print_prettier_dict(user_info)


def seller():
    open_seller_menu(3)
    open_seller_menu(1)
