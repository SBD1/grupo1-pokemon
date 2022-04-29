from database import *
from utils import print_subtitle

def check_npc_in_position(position):
    npc = get_npc_info_by_pos(position)
    return npc

def talk_with_npc(NPC):
    print('\n')
    print_subtitle(f'{NPC["nome"]} tem algo para te dizer!')
    print(NPC['nome'], ':', NPC['fala'])
    print('(Aperte qualquer tecla para continuar...)')
    input()