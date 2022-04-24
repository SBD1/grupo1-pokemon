from os import system, name
from database import run_query_fetchall, run_query_fetchone, run_update, run_delete
from exceptions.communs import ItemDoesntExists
import pprint


def print_prompt(message):
    print(f' # {message}')


def print_title(message):
    tlen = 70
    mlen = len(message)
    dlen = tlen - mlen - 2
    if(dlen % 2 != 0):
        dlen += 1
    dlen /= 2

    print('=======================================================================')
    for i in range(int(dlen)):
        print(' ', end='')
    print(' ', end='')
    print(message, end='')
    print(' ', end='')
    for i in range(int(dlen)):
        print(' ', end='')
    print('\n=======================================================================')


def print_subtitle(message):
    tlen = 70
    mlen = len(message)
    dlen = tlen - mlen - 4
    if(dlen % 2 != 0):
        dlen += 1
    dlen /= 2
    print('+', end='')
    for i in range(int(dlen)):
        print('-', end='')
    print(f' {message} ', end='')
    for i in range(int(dlen)):
        print('-', end='')
    print('+')


def count_dict_amount(keys: list, dictlist: list, param: str):
    quantity = {}
    for key in keys:
        quantity[str(key)] = 0
    for elem in dictlist:
        quantity[elem[param]] += 1
    return quantity


def clean_bash():
    if name == 'nt':
        _ = system('cls')
    else:
        _ = system('clear')


def print_prettier_dict(dict):
    pp = pprint.PrettyPrinter(indent=4)
    pp.pprint(dict)


def check_item_exists(item_id):
    exists = run_query_fetchone(f"SELECT check_item_exists({item_id});")
    return bool(exists)


def check_backpack_has_item(backpack_id, item_id):

    if not check_item_exists(item_id):
        raise ItemDoesntExists(f"Item id:{item_id} doesn't exists")

    exists = run_query_fetchone(
        f"SELECT check_backpack_has_item({backpack_id}, {item_id});")
    return bool(exists)


def check_pokemon_exists(pokemon_id):
    exists = run_query_fetchone(f"SELECT check_pokemon_exists({pokemon_id});")
    return bool(exists)


def remove_item_from_backpack(backpack_id, item_id):

    if not check_backpack_has_item(backpack_id, item_id):
        return None

    run_delete(f"DELETE FROM mochila_guarda_instancia_de_item WHERE id_instancia_item={item_id} "
               f"and id_mochila={backpack_id};")
