from database import (
    get_pokedex_nro_pokemons_capturados, 
    get_pokedex_nro_pokemons_vistos,
    get_registra_descricao_visivel,
    get_seen_pokemons_name
)
from utils import print_title, print_subtitle
import time

class Pokedex:

    def __init__(self, player_name):
        self.pokedex_id = player_name
        self.qnt_pokemons_seen = get_pokedex_nro_pokemons_vistos(self.pokedex_id)
        self.qnt_pokemons_captured = get_pokedex_nro_pokemons_capturados(self.pokedex_id)
        self.seen_pokemons_id_name = get_seen_pokemons_name(self.pokedex_id)

    def display(self):
        while True:
            print_title(f'Pokedex do {self.pokedex_id}')
            print('Quantidade de pokemóns vistos: ', self.qnt_pokemons_seen)
            print('Quantidade de pokemóns capturados: ', self.qnt_pokemons_captured)
            
            print_subtitle('Detalhes dos pokemóns')
            count = 1
            for pokemon_dict in self.seen_pokemons_id_name:
                print(f'{count:3d} - {pokemon_dict["especie"].capitalize()}')
                count += 1
            print('  0 - Sair')

            tecla = input('Selecione a espécie do pokemón que você deseja detalhar: ')

            try:
                tecla = int(tecla)
            except:
                print('Opção inválida, tente novamente.\n\n')
                continue

            if tecla > 0 and tecla <= len(self.seen_pokemons_id_name):
                self.display_pokemon_info(self.seen_pokemons_id_name[tecla-1])
            elif tecla == 0:
                print('Fechando a pokedex...')
                time.sleep(0.5)
                return
            else:
                print('Opção inválida, tente novamente.\n\n')
    
    def display_pokemon_info(self, pokemon_id_name):
        print_subtitle(pokemon_id_name['especie'].upper())
        print(get_registra_descricao_visivel(pokemon_id_name['id_pokemon']))
        print('(Aperte enter tecla para continuar...)')
        input()
