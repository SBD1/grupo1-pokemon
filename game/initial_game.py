from time import sleep
from database import get_user_info, get_players_names, insert_new_treinador
from purchase_item import open_seller_menu
from in_game import start_game
from utils import *


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
    print('Bem vindo ao jogo Gotta Catch \'Em All, seguem algumas instruções para \nque você consiga jogar')
    print('- Ações: Ações possíveis serão mostradas no console, ao lado de um número.\n'
          '         Para executá-las insira o número desejado e pressione ENTER.')
    print('\nO Menu abaixo vai ter dar uma noção de como as coisas vão ser:')
    initial_menu()
    # seller()


def initial_menu():
    player_name = ''
    while True:
        print_title('MENU INICIAL')
        print('1 - Criar novo jogo')
        print('2 - Carregar jogo salvo')
        print('0 - Sair')
        tecla = input('Insira sua escolha: ')
        print()
        if tecla == '1':
            player_name = create_new_player()
            if player_name == '':
                print('\n\n')
                continue
        elif tecla == '2':
            player_name = load_players()
            if player_name == '':
                print('\n\n')
                continue
        elif tecla == '0':
            exit_game()
            return
        else:
            print('Opção inválida, tente novamente.\n\n')
            continue

        clean_bash()
        start_game(player_name)


def exit_game():
    clean_bash()
    print(r'''
  _______ _                 _                           __                   _             _             _ 
 |__   __| |               | |                         / _|                 | |           (_)           | |
    | |  | |__   __ _ _ __ | | __  _   _  ___  _   _  | |_ ___  _ __   _ __ | | __ _ _   _ _ _ __   __ _| |
    | |  | '_ \ / _` | '_ \| |/ / | | | |/ _ \| | | | |  _/ _ \| '__| | '_ \| |/ _` | | | | | '_ \ / _` | |
    | |  | | | | (_| | | | |   <  | |_| | (_) | |_| | | || (_) | |    | |_) | | (_| | |_| | | | | | (_| |_|
    |_|  |_| |_|\__,_|_| |_|_|\_\  \__, |\___/ \__,_| |_| \___/|_|    | .__/|_|\__,_|\__, |_|_| |_|\__, (_)
                                    __/ |                             | |             __/ |         __/ |  
                                   |___/                              |_|            |___/         |___/   
  
                                                _.--""`-..
                                                ,'          `.
                                            ,'          __  `.
                                            /|          " __   \
                                            , |           / |.   .
                                            |,'          !_.'|   |
                                        ,'             '   |   |
                                        /              |`--'|   |
                                        |                `---'   |
                                        .   ,                   |                       ,".
                                        ._     '           _'  |                    , ' \ `
                                    `.. `.`-...___,...---""    |       __,.        ,`"   L,|
                                    |, `- .`._        _,-,.'   .  __.-'-. /        .   ,    \
                                    -:..     `. `-..--_.,.<       `"      / `.        `-/ |   .
                                    `,         """"'     `.              ,'         |   |  ',,
                                        `.      '            '            /          '    |'. |/
                                        `.   |              \       _,-'           |       ''
                                            `._'               \   '"\                .      |
                                            |                '     \                `._  ,'
                                            |                 '     \                 .'|
                                            |                 .      \                | |
                                            |                 |       L              ,' |
                                            `                 |       |             /   '
                                                \                |       |           ,'   /
                                            ,' \               |  _.._ ,-..___,..-'    ,'
                                            /     .             .      `!             ,j'
                                            /       `.          /        .           .'/
                                        .          `.       /         |        _.'.'
                                            `.          7`'---'          |------"'_.'
                                        _,.`,_     _'                ,''-----"'
                                    _,-_    '       `.     .'      ,\
                                    -" /`.         _,'     | _  _  _.|
                                        ""--'---"""""'        `' '! |! /
                                                                `" " -' mh      
    ''')


def seller():
    open_seller_menu(1, 'Ash Ketchum')
    open_seller_menu(3, 'Ash Ketchum')


def create_new_player():
    print_subtitle('CRIAR NOVO JOGO')
    while True:
        player_name = input(
            'Insira o nome do treinador (ou insira 0 para voltar): ')

        if player_name == '0':
            return ''

        if get_user_info(player_name) != []:
            print('Nome já utilizado, tente outro nome')
            continue

        new_treinador = insert_new_treinador(player_name)
        if new_treinador != []:
            return player_name
        print('Algo deu errado enquanto um novo treinador era criado. Tente novamente\n\n')


def load_players():
    print_subtitle('CARREGAR JOGO SALVO')
    tecla = -1
    players_names = get_players_names()
    while True:
        count = 1
        for name in players_names:
            print(f'{count} - {name["nome"]}')
            count += 1
        print(f'0 - Voltar')
        tecla = input(
            'Selecione o nome do treinador que você deseja carregar: ')

        try:
            tecla = int(tecla)
        except:
            print('Opção inválida, tente novamente.\n\n')
            continue

        if tecla > 0 and tecla <= len(players_names):
            return players_names[tecla-1]['nome']
        elif tecla == 0:
            return ''
        else:
            print('Opção inválida, tente novamente.\n\n')
