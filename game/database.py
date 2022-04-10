import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import psycopg2.extras


def create_database():
    conn, cur = get_database_and_cursor(None)
    conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur.execute("create database pokemon;")
    cur.close()
    conn.close()


def get_database_and_cursor(dbname='pokemon'):
    if(dbname == None):
        conn = psycopg2.connect("user='postgres' host='localhost' password='postgres'")
    else:
        conn = psycopg2.connect("dbname='pokemon' user='postgres' host='localhost' password='postgres'")
    return [conn, conn.cursor(cursor_factory = psycopg2.extras.RealDictCursor)]


def drop_dabase():
    conn, cur = get_database_and_cursor(None)
    conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur.execute("drop database pokemon;")
    cur.close()
    conn.close()


def create_and_populate_tables():
    conn, cur = get_database_and_cursor()
    cur.execute(open("docs/SQL/DDL-BD.sql", "r").read())
    cur.execute(open("docs/SQL/DML-BD.sql", "r").read())
    cur.execute("SELECT * FROM pokemon;")
    conn.commit()
    cur.close()
    conn.close()


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
