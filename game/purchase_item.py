from database import *
from utils import *


def open_seller_menu(id_npc):
    npc_info = get_npc_info(id_npc)
    nome = npc_info["nome"]
    clean_bash()

    if npc_info["profissao"] == "vendedor":
        print_title(f"COMPRAR ITEM DE VENDEDOR: {nome}")
        print_subtitle("ITENS A VENDA")
        instance_items = get_seller_items(id_npc)
        # print_prettier_dict(instance_items)

        i = 0
        itens_a_venda = []
        tipo_itens = ['pokebola', 'evostone', 'berry', 'candy']

        for item in instance_items:
            instancia_id = item["id_instancia_item"]
            item_id = get_item_id(instancia_id)["id_item"]
            papel = get_papel_item(item_id)["papel"]

            itens_a_venda.append({'instancia_id': instancia_id,
                                  'item_id': item_id,
                                  'papel': papel})

            # quantity[str(papel)] += 1
            # print(f"Instância ID: {instancia_id} é {papel}")

        quantidade = count_dict_amount(
            tipo_itens, itens_a_venda, 'papel')

        for type in quantidade:
            if quantidade[type] > 0:
                plural = ('', 's')[quantidade[type] > 1]
                print(
                    f'   <> Há {quantidade[type]} {type}{plural} a venda')

        print_subtitle("O que deseja comprar?")
        print_prompt("Selecione algum número:")

        i = 0
        opcoes_validas = [0]
        opcao_item = []
        for type in quantidade:
            i += 1
            if quantidade[type] > 0:
                opcoes_validas.append(i)
                opcao_item.append({'opcao': i, 'papel_item': type})
                print(
                    f'   <{i}> Comprar {type}')
        print(
            f'      <0> Voltar ao menu')

        opcao: int = input()
        if int(opcao) not in opcoes_validas:
            print_prompt('Opção inválida')
        # print_prettier_dict(quantity)
        # print_prettier_dict(contado)

    else:
        print(f"O NPC \"{nome}\" não é vendedor!")

    # print_prettier_dict(npc_info)
    # print(npc_info["id_posicao"])
