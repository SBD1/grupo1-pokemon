from database import *
from utils import *

def get_player_position_db(user_name):
    sql = f"SELECT get_player_position('{user_name}');"
    result = run_query_fetchone(sql)['get_player_position']
    return result

def get_movement_directions(pos):
    sql = f"SELECT p.norte, p.sul, p.leste, p.oeste, p.cima, p.baixo FROM posicao p WHERE p.id = {pos};"
    result = run_query_fetchall(sql)
    positions_available = []
    for pos in result:
        positions_available.append(dict(pos))
    return positions_available[0]

def valid_region_change_db(pos, user_name):
    sql = f"SELECT valid_region_change({pos}, '{user_name}');"
    valid_entry = run_query_fetchone(sql)['valid_region_change']
    return valid_entry

def get_display_available_pos(positions_available):
    return {key : value for key, value in positions_available.items() if value != None}

def change_player_pos(pos, user_name):
    sql = f"UPDATE treinador SET id_posicao = {pos} WHERE nome ='{user_name}';"
    run_update(sql)
    return get_player_position_db(user_name)

def get_avaliable_items_in_position(pos_id):
    sql = f"select id_instancia_item from instancia_item_posicao WHERE id_posicao={pos_id};"
    response = run_query_fetchall(sql)
    items = []
    for item in response:
        items.append(dict(item))
    return items

def pick_item(user_id, item_id):
    try:
        sql = f"CALL pegar_item_do_chao('{item_id}', '{user_id}');"
        run_transaction(sql)
        print('Item adicionado ao inventário')
    except (Exception, psycopg2.DatabaseError) as error:
        print('Mochila lotada')

def path(user_pos):
    init_pos = user_pos
    directions = get_movement_directions(init_pos)
    return get_display_available_pos(directions)