import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
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


def get_user_info():
    query_response = run_query_fetchall("SELECT * FROM treinador;")
    trainer_info = []
    for info in query_response:
        trainer_info.append(dict(info))
    return trainer_info[0]


def get_npc_info(id_npc):
    query_response = run_query_fetchall(
        f"SELECT * FROM npc WHERE id={id_npc};")
    npc_info = []
    for info in query_response:
        npc_info.append(dict(info))
    return npc_info[0]


def get_seller_items(_id_npc):
    query_response = run_query_fetchall(
        f"SELECT id_instancia_item FROM npc_guarda_instancia_de_item WHERE id_npc={_id_npc};")
    instance_items = []
    for item in query_response:
        instance_items.append(dict(item))
    return instance_items


def get_item_id(instance_id):
    query_response = run_query_fetchall(
        f"SELECT id_item FROM instancia_item WHERE id={instance_id};")
    items_id = []
    for item in query_response:
        items_id.append(dict(item))
    return items_id[0]


def get_papel_item(item_id):
    query_response = run_query_fetchall(
        f"SELECT papel FROM especializacao_do_item WHERE id_item={item_id};")
    papeis = []
    for papel in query_response:
        papeis.append(dict(papel))
    return papeis[0]


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
