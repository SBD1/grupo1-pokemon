from database import run_query_fetchall, run_query_fetchone, run_update, run_insert
def pokemon_instance_can_evolve(pokemon_instance_id = 1):
    pokemon_instance_info = run_query_fetchone(f"SELECT id_pokemon, experiencia from instancia_pokemon where id={pokemon_instance_id}")
    pokemons_evolution_info = run_query_fetchall(f"SELECT experiencia_evoluir from pokemon_evolucao where pokemon_id = {pokemon_instance_info['id_pokemon']};")
    for pokemon_evolution_info in pokemons_evolution_info:
        if pokemon_evolution_info['experiencia_evoluir'] <= pokemon_instance_info['experiencia']:
            return True
    return False

def evolve_pokemon_instance(pokemon_instance_id):
    pass