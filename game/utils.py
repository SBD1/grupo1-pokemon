from database import run_query_fetchall, run_query_fetchone, run_update, run_delete
from exceptions.communs import ItemDoesntExists
import pprint


def print_prettier_dict(dict):
    pp = pprint.PrettyPrinter(indent=4)
    pp.pprint(dict)


def check_item_exists(item_id):
    exists = run_query_fetchone(f"SELECT check_item_exists({item_id});")
    return bool(exists)


def check_backpack_has_item(mochila_id, item_id):

    if not check_item_exists(item_id):
        raise ItemDoesntExists(f"Item id:{item_id} doesn't exists")

    exists = run_query_fetchone(f"SELECT check_backpack_has_item({mochila_id}, {item_id});")
    return bool(exists)


def check_pokemon_exists(pokemon_id):
    exists = run_query_fetchone(f"SELECT check_pokemon_exists({pokemon_id});")
    return bool(exists)


def remove_item_from_backpack(mochila_id, item_id):

    if not check_backpack_has_item(mochila_id, item_id):
        return None

    run_delete(f"DELETE FROM mochila_guarda_instancia_de_item WHERE id_instancia_item={item_id} "
               f"and id_mochila={mochila_id};")
