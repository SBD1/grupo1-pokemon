import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT, ISOLATION_LEVEL_SERIALIZABLE
from setup.setup_environment import get_database_and_cursor
import psycopg2.extras
import os


# Unnecessary function if using docker
#
# def create_database():
#     conn, cur = get_database()
#     conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
#     cur.execute("create database pokemon;")
#     cur.close()
#     conn.close()


# def get_database_and_cursor(dbname='pokemon'):

#     #Lembrar de criar o arquivo .env com as infos que estão no .env-examples e mudar para os valores para o que façam sentido na sua máquina

#     if(dbname == None):
#         conn = psycopg2.connect(f"user='{os.environ.get('DB_USER')}' host='{os.environ.get('DB_HOST')}' password='{os.environ.get('DB_PASSWORD')}'")
#     else:
#         conn = psycopg2.connect(f"dbname='pokemon' user='{os.environ.get('DB_USER')}' host='{os.environ.get('DB_HOST')}' password='{os.environ.get('DB_PASSWORD')}'")
#     return [conn, conn.cursor(cursor_factory = psycopg2.extras.RealDictCursor)]


# def drop_dabase():
#     conn, cur = get_database()
#     conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
#     cur.execute("drop database pokemon;")
#     cur.close()
#     conn.close()


# def create_and_populate_tables():
#     conn, cur = get_database()
#     cur.execute(open("docs/SQL/DDL-BD.sql", "r").read())
#     cur.execute(open("docs/SQL/DML-BD.sql", "r").read())
#     cur.execute("SELECT * FROM pokemon;")
#     conn.commit()
#     cur.close()
#     conn.close()

def run_query_fetchall(query):
    conn, cur = get_database_and_cursor()
    cur.execute(query)
    response = cur.fetchall()
    conn.commit()
    cur.close()
    conn.close()
    return response


def run_query_fetchone(query):
    conn, cur = get_database_and_cursor()
    cur.execute(query)
    response = cur.fetchone()
    conn.commit()
    cur.close()
    conn.close()
    return response


def run_update(query):
    conn, cur = get_database_and_cursor()
    conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur.execute(query)
    cur.close()
    conn.close()


def run_delete(query):
    conn, cur = get_database_and_cursor()
    conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur.execute(query)
    cur.close()
    conn.close()


def run_insert(query):
    conn, cur = get_database_and_cursor()
    conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    response = cur.execute(query)
    cur.close()
    conn.close()
    return response


def get_players_names():
    query_response = run_query_fetchall("SELECT nome FROM treinador;")
    players_names = []
    for info in query_response:
        players_names.append(dict(info))
    return players_names


def get_user_info(nome_player):
    query_response = run_query_fetchall(
        f"SELECT * FROM treinador WHERE nome='{nome_player}';")
    trainer_info = []
    for info in query_response:
        trainer_info.append(dict(info))
    if len(trainer_info) > 0:
        return trainer_info[0]
    return []


def get_npc_info(id_npc):
    query_response = run_query_fetchall(
        f"SELECT * FROM npc WHERE id = {id_npc};")
    npc_info = []
    for info in query_response:
        npc_info.append(dict(info))
    if len(npc_info) > 0:
        return npc_info[0]
    return []


def get_seller_items(_id_npc):
    query_response = run_query_fetchall(
        f"SELECT id_instancia_item FROM npc_guarda_instancia_de_item WHERE id_npc = {_id_npc};")
    instance_items = []
    for item in query_response:
        instance_items.append(dict(item))
    return instance_items


def get_item_id(instance_id):
    query_response = run_query_fetchall(
        f"SELECT id_item FROM instancia_item WHERE id = {instance_id};")
    items_id = []
    for item in query_response:
        items_id.append(dict(item))
    if len(items_id) > 0:
        return items_id[0]
    return []


def get_papel_item(item_id):
    query_response = run_query_fetchall(
        f"SELECT papel FROM especializacao_do_item WHERE id_item = {item_id};")
    papeis = []
    for papel in query_response:
        papeis.append(dict(papel))
    if len(papeis) > 0:
        return papeis[0]
    return []


def get_item_instances_on_backpack(item_id, backpack_id):
    query = f"SELECT item_mochila.id_instancia_item FROM mochila_guarda_instancia_de_item AS item_mochila\
     INNER JOIN instancia_item AS itens ON item_mochila.id_instancia_item = itens.id\
      WHERE itens.id_item = {item_id} AND item_mochila.id_mochila = '{backpack_id}';"

    instance_ids = run_query_fetchall(query)

    return instance_ids


def insert_new_treinador(player_name):
    try:
        run_insert(
            f"INSERT INTO treinador (nome, nivel, dinheiro, insignia, id_posicao, id_professor) VALUES ('{player_name}', 0, 500.00, 'iniciante', 1, 2);"
        )
        return get_user_info(player_name)
    except:
        return []

def get_bag_items(player_name):
    query_response = run_query_fetchall(f"SELECT * from mochila_guarda_instancia_de_item where id_mochila='{player_name}'")
    items = []
    for item in query_response:
        items.append(dict(item))
    return items

def get_item_details(item_id, table):
    query_response = run_query_fetchall(
        f"SELECT * FROM {table} WHERE id = {item_id};"
    )
    details = []
    for info in query_response:
        details.append(dict(info))
        return details[0]

def get_user_pokemons(user_id):
    query_response = run_query_fetchall(f"SELECT * from captura where id_treinador = '{user_id}';")
    pokemons = []
    for info in query_response:
        pokemons.append(dict(info))
    return pokemons

def get_instancia_pokemon_info(instancia_pokemon_id):
    query_response = run_query_fetchall(f"SELECT * from instancia_pokemon where id = '{instancia_pokemon_id}';")
    for info in query_response:
        return dict(info)

def get_pokemon_info(pokemon_id):
    query_response = run_query_fetchall(f"SELECT * from pokemon where id = '{pokemon_id}';")
    for info in query_response:
        return dict(info)


def run_delete(query):
    conn, cur = get_database_and_cursor()
    conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur.execute(query)
    cur.close()
    conn.close()


def run_sell_item(id_instancia, _nome_treinador, id_npc):
    try:
        query = f"CALL vende_item({id_instancia}, '{_nome_treinador}', {id_npc})"
        conn, cur = get_database_and_cursor()
        conn.set_isolation_level(ISOLATION_LEVEL_SERIALIZABLE)
        cur.execute(query)
        conn.commit()
        cur.close()
        conn.close()
    except (Exception, psycopg2.DatabaseError) as error:
        return None
