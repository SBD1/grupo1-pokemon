from database import *
from utils import *

def select_item(nome_treinador):
    items = get_bag_items_info(nome_treinador)
    print_items_name_and_quantity(items)
    option = input('O que deseja fazer?\n1. Usar um item.\n2. Fechar mochila.\n')
    while option != '1' and  option != '2':
        option = input('Opção invalida. O que deseja fazer?\n1. Usar um item.\n2. Fechar mochila.\n')
    if option == '2':
        return
    print_items_name_and_quantity(items)
    option = input('Qual dos items acima deseja utilizar?')
    

def get_bag_items_info(nome_treinador):
    items = {}
    bag_items = get_bag_items(nome_treinador)
    for item in bag_items:
        item_id = get_item_id(item["id_instancia_item"])["id_item"]
        papel = get_papel_item(item_id)["papel"]
        item_details = get_item_details(item_id, papel)

        if item_details["nome"] in items.keys():
            items[item_details["nome"]] += 1
        else:
            items[item_details["nome"]] = 1
    return items



def print_items_name_and_quantity(item_dict):
    print('Items disponíveis na mochila e quantidades:')
    i = 1
    for item in item_dict.keys():
        print(f'{i}. {item:20} x{item_dict[item]}')
        i+=1
    print()