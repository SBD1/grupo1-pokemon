from database import *
from utils import *
from user_pokemon_list import get_pokemon_list

def bag_menu(user_id):
    option = -1
    while option != 0:
        option = int(input('O que deseja fazer?\n1 - Visualizar items\n2 - Utilizar um item\n0 - Fechar mochila.\n'))
        while option < 0 or  option > 2:
            try:
                option = int(input('Opção invalida. O que deseja fazer?\n1 - Visualizar items\n2 - Utilizar um item\n0 - Fechar mochila.\n'))
            except:
                continue

        if option == 0:
            return

        items_dict = get_bag_items_info(user_id)
        if option == 1:
            print_items_name_and_quantity(items_dict)
        
        if option == 2:
            use_item(user_id)

def use_item(user_id):
    item = select_item(user_id)
    if item != None:
        pokemon = select_pokemon(user_id)
        if item['role'] == 'evostone':
            evolve_pokemon_with_item(pokemon['id'],pokemon['id_pokemon'],  item['item_id'], item['ids'][0])
        else:
            use_candy(pokemon['id'], item['ids'][0])
    else:
        print('Ops... você não tem nenhum item utilizavél disponível')

def select_item(user_id):
    usable_items_dict = get_bag_items_info(user_id, True)
    if usable_items_dict:
        print_items_name_and_quantity(usable_items_dict)
        option = int(input('Qual dos items acima deseja utilizar?\n'))
        while option < 1 or option > len(usable_items_dict):
            option = int(input('Opção inválida. Qual dos items acima deseja utilizar?\n'))
        item_list = list(usable_items_dict)
        return usable_items_dict[item_list[option-1]]
    return None

def select_pokemon(user_id):
    instancia_pokemons_list = get_pokemon_list(user_id)
    instancia_pokemons_info = []
    for instancia_pokemon in  instancia_pokemons_list:
        instancia_pokemon_info = get_instancia_pokemon_info(instancia_pokemon['id_instancia_pokemon'])
        instancia_pokemons_info.append(instancia_pokemon_info)
    
    for instancia_pokemon_info in instancia_pokemons_info:
        pokemon_info = get_pokemon_info(instancia_pokemon_info['id_pokemon'])
        instancia_pokemon_info['name'] = pokemon_info['especie']
    print_instancia_pokemon_info(instancia_pokemons_info)
    option = int(input('Em qual dos pokémons acima deseja utilizar esse item?\n'))
    while option < 1 or option > len(instancia_pokemons_info):
        option = int(input('Opção inválida. Em qual dos pokémons acima deseja utilizar esse item?\n'))
    
    return instancia_pokemons_info[option-1]
    

def get_bag_items_info(user_id, only_usables=False):
    items = {}
    bag_items = get_bag_items(user_id)
    for item in bag_items:
        item_id = get_item_id(item["id_instancia_item"])["id_item"]
        papel = get_papel_item(item_id)["papel"]
        item_details = get_item_details(item_id, papel)
        if not only_usables or (only_usables and (papel == "candy" or papel == "evostone")):
            if item_details["nome"] in items.keys():
                items[item_details["nome"]]['quantity'] += 1
                items[item_details["nome"]]['ids'].append(item["id_instancia_item"])

            else:
                items[item_details["nome"]] = {
                    "quantity": 1,
                    "ids": [item["id_instancia_item"]],
                    "role": papel,
                    "item_id": item_id
                }
    return items


def print_items_name_and_quantity(item_dict):
    print('Items disponíveis na mochila e quantidades:')
    i = 1
    for item in item_dict.keys():
        print(f"{i} - ({item_dict[item]['role']}) {item:20} x{item_dict[item]['quantity']}")
        i+=1
    print()

def print_instancia_pokemon_info(instancia_pokemon_list):
    i = 1
    print('Lista de pokémons:')
    print(f"{'':3}{'Nome':20} {'Genero':8} {'XP':5}")
    for instancia in instancia_pokemon_list:
        print(f"{i} - {instancia['name'].capitalize():20} {instancia['genero']:8} {instancia['experiencia']:<5}")
        i+=1
    print()
