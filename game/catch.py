from database import run_query_fetchall, run_query_fetchone, run_update, run_insert
from exceptions.communs import PokemonDoesntExists, ItemDoesntExists, ItemNoInBackpack
from utils import check_backpack_has_item, check_pokemon_exists


def catch_pokemon(pokemon_id, player_name, pokebola_id):

    mochila_id = player_name

    if not check_pokemon_exists(pokemon_id):
        raise PokemonDoesntExists(f"Error to find pokemon id:{pokemon_id}")

    if not check_backpack_has_item(mochila_id, pokebola_id):
        raise ItemNoInBackpack(f"Item id: {pokebola_id} not in backpack {mochila_id}")

    create_catch(pokemon_id, player_name, pokebola_id)


def create_catch(pokemon_id, player_name, pokebola_id):
    run_insert(f"INSERT INTO captura VALUES ({pokemon_id}, {player_name});")
    create_catch_event(pokemon_id, pokebola_id)


def create_catch_event(pokemon_id, pokebola_id):
    run_insert(f"INSERT INTO evento_captura VALUES ({pokemon_id}, {pokebola_id});")
