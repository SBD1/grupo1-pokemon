from database import *
from utils import *


def get_player_position_db(player_name):
    sql = f"SELECT get_player_position('{player_name}');"
    result = run_query_fetchone(sql)['get_player_position']
    return result

def get_movement_directions(pos):
    sql = f"SELECT p.norte, p.sul, p.leste, p.oeste, p.cima, p.baixo FROM posicao p WHERE p.id = {pos};"
    result = run_query_fetchall(sql)
    positions_available = []
    for pos in result:
        positions_available.append(dict(pos))
    return positions_available[0]

def valid_region_change(pos, player_name):
    sql = f"SELECT r.entrada FROM regiao r WHERE r.id = (SELECT p.id_regiao FROM posicao p WHERE p.id = {pos});"
    entrada = run_query_fetchone(sql)['entrada']

    if entrada == 0:
        return 1
    else:
        sql_count_pokemon = f"SELECT COUNT(*) as n_capturados FROM captura WHERE id_treinador = '{player_name}';"
        pokemons_capturados = run_query_fetchone(sql_count_pokemon)['n_capturados']
        if pokemons_capturados >= entrada:
            return 1
        else:
            return 0

def valid_region_change_db(pos, player_name):
    sql = f"SELECT valid_region_change({pos}, '{player_name}');"
    valid_entry = run_query_fetchone(sql)['valid_region_change']
    return valid_entry

def get_display_available_pos(positions_available):
    return [{key : value} for key, value in positions_available.items() if value != None]

def change_player_pos(pos, player_name):
    sql = f"UPDATE treinador SET id_posicao = {pos} WHERE nome ='{player_name}';"
    run_update(sql)
    return get_player_position_db(player_name)

def path(player_name):
    init_pos = get_player_position_db(player_name)
    directions = get_movement_directions(init_pos)
    return get_display_available_pos(directions)