from database import *
def get_pokemon_list(user_id):
    pokemons = get_user_pokemons(user_id) 
    return pokemons