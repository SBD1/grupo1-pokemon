import time
from database import *
from utils import *


def open_seller_menu(id_npc, nome_treinador):
    npc_info = get_npc_info(id_npc)
    nome = npc_info["nome"]
    clean_bash()

    if npc_info["profissao"] == "vendedor":
        print_title(f"COMPRAR ITEM DE VENDEDOR: {nome}")
        print_subtitle("ITENS A VENDA")
        instance_items = get_seller_items(id_npc)
        # print_prettier_dict(instance_items)

        if len(instance_items) is 0:
            print_prompt(
                "Este vendedor não possui itens para a venda no momento!")

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
            f'      <0> Voltar')

        opcao = input()

        while(not opcao.isnumeric()):
            print_subtitle('Opção inválida!')
            print_prompt('Selecione um número.')
            opcao = input()

        while int(opcao) not in opcoes_validas:
            print_prompt('Opção inválida!')
            print_prompt('Selecione uma opção válida.')
            opcao = input()

        # COLOCAR PARA VOLTAR AO MENU ==============> opcao = 0
        if int(opcao) is 0:
            return None

        clean_bash()
        print_title(f"COMPRAR ITEM DE VENDEDOR: {nome}")
        for op in opcao_item:
            if(op['opcao'] == int(opcao)):
                detalhar = op['papel_item']
                print_subtitle(detalhar)
                print()

        printados = []
        correcoes_gramaticais = {
            'preco': 'Preço R$',
            'id_elemento': 'Elemento',
            'aumento_experiencia': 'Aumento de Experiência',
            'aumento_taxa_captura': 'Aumento de Taxa de Captura'}
        for item in itens_a_venda:
            if(item['papel'] == detalhar):
                if item['item_id'] not in printados:
                    printados.append(item['item_id'])
                    detalhes = get_item_details(item['item_id'], detalhar)
                    print_prompt(detalhes['nome'])
                    for att in detalhes:
                        if not ((att == 'nome') | (att == 'id')):
                            print(
                                f"{correcoes_gramaticais[att]}: {detalhes[att]}")
                    print()
            # print(item)

        print_subtitle(f"Qual {detalhar} deseja comprar?")
        print_prompt("Selecione algum número:")

        i = 0
        opcoes_validas.clear()
        opcoes_validas = [0]
        opcao_especializacao_item = []
        # print(printados)

        for _item_id in printados:
            i += 1
            opcoes_validas.append(i)
            especializacao = get_item_details(
                _item_id, detalhar)['nome']
            opcao_especializacao_item.append(
                {_item_id: especializacao})
            print(
                f'   <{i}> Comprar {especializacao}')
        print(
            f'      <0> Voltar')

        opcao = input()

        while(not opcao.isnumeric()):
            print_subtitle('Opção inválida!')
            print_prompt('Selecione um número.')
            opcao = input()

        while int(opcao) not in opcoes_validas:
            print_prompt('Opção inválida!')
            print_prompt('Selecione uma opção válida.')
            opcao = input()

        # COLOCAR PARA VOLTAR AO MENU ==============> opcao = 0
        if int(opcao) is 0:
            return open_seller_menu(id_npc, nome_treinador)

        # print(opcoes_validas[int(opcao)])
        if(int(opcao) > 0):
            print(
                f'Comprou item_id: {printados[opcoes_validas[int(opcao)-1]]}')

        for item in itens_a_venda:
            if(item['item_id'] == printados[opcoes_validas[int(opcao)-1]]):
                item_comprado = item
                break
        # print_prettier_dict(itens_a_venda)
        print_prettier_dict(item_comprado)
        # print(f"Comprou {opcao_especializacao_item[printados[int(opcao)]]}")
        answer = run_sell_item(
            item_comprado['instancia_id'], nome_treinador, id_npc)

        if answer is None:
            print_prompt(
                f"Não foi possível realizar a compra.")
            print(' Tente novamente! O menu será reaberto em 3 segundos.')
            time.sleep(3)
            return open_seller_menu(id_npc, nome_treinador)
        # print_prettier_dict(quantity)
        # print_prettier_dict(contado)

    else:
        print(f"O NPC \"{nome}\" não é vendedor!")

    # print_prettier_dict(npc_info)
    # print(npc_info["id_posicao"])
