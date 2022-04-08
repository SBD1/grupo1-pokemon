import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

def create_database():
    conn = psycopg2.connect("user='postgres' host='localhost' password='123'")
    cur = conn.cursor()
    conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur.execute("create database pokemon;")
    cur.close()
    conn.close()

def create_and_populate_tables():
    conn = psycopg2.connect("dbname='pokemon' user='postgres' host='localhost' password='123'")
    cur = conn.cursor()
    cur.execute(open("docs/SQL/DDL-BD.sql", "r").read())
    cur.execute(open("docs/SQL/DML-BD.sql", "r").read())
    cur.execute("SELECT * FROM pokemon")
    records = cur.fetchall()
    conn.commit()
    cur.close()
    conn.close()

create_database()
create_and_populate_tables()