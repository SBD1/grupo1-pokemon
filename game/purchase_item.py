from database import *
from utils import print_prettier_dict


def open_seller_menu(id_npc):
    npc_info = get_npc_info(id_npc)
    nome = npc_info["nome"]

    if npc_info["profissao"] == "vendedor":
        print('=======================================================================')
        print(f'\t\tCOMPRAR ITEM DE VENDEDOR: {nome}')
        print('=======================================================================')
        print("+-------------------------- ITENS A VENDA ---------------------------+")
        instance_items = get_seller_items(id_npc)
        # print_prettier_dict(instance_items)

        quantity = {'pokebola': 0, 'berry': 0, 'evostone': 0, 'candy': 0}

        for item in instance_items:
            instancia_id = item["id_instancia_item"]
            item_id = get_item_id(instancia_id)["id_item"]
            papel = get_papel_item(item_id)["papel"]

            quantity[str(papel)] += 1
            # print(f"Instância ID: {instancia_id} é {papel}")

        for type in quantity:
            if quantity[type] > 0:
                plural = ('', 's')[quantity[type] > 1]
                print(
                    f'  <> Há {quantity[type]} {type}{plural} a venda')

        # print_prettier_dict(quantity)
    else:
        print(f"O NPC \"{nome}\" não é vendedor!")

    # print_prettier_dict(npc_info)
    # print(npc_info["id_posicao"])
