import random

from exceptions.communs import PokemonDoesntExists, ItemDoesntExists, ItemNoInBackpack
from database import (run_insert,
                      get_item_instances_on_backpack,
                      get_item_id,
                      run_query_fetchone,
                      pokemon_on_pokedex,
                      add_pokemon_to_pokedex,
                      increment_pokemon_seen_on_pokedex,
                      increment_pokemon_catch_on_pokedex,
                      run_query_fetchall)

from utils import (check_backpack_has_item,
                   check_pokemon_exists,
                   print_title,
                   print_prompt,
                   print_subtitle)


def use_item(item_id):
    pass


class Catch:

    pokebolas_dict = {
        "Pokeball": 20,
        "Great Ball": 21,
        "Ultra Ball": 22,
        "Master Ball": 23
    }

    berry_dict = {
        "Morango": 5,
        "Amora": 6,
        "Blueberry": 7,
        "Banana": 8
    }

    def __init__(self, pokemon_id, player_name):
        self.pokemon_id = pokemon_id
        self.pokemon_info = self.get_pokemon_info(pokemon_id)
        self.pokemon_name = self.pokemon_info['especie']
        self.pokemon_catch_prob = self.pokemon_info['taxa_captura']
        self.pokemon_xp = self.pokemon_info['experiencia']
        self.pokemon_specie_id = self.pokemon_info['id_pokemon']
        self.player_name = player_name

        self.berry_stats = self.get_berry_stats()
        self.pokeball_stats = self.get_pokeball_stats(self.pokebolas_dict)

        if not pokemon_on_pokedex(self.pokemon_specie_id, player_name):
            add_pokemon_to_pokedex(self.pokemon_specie_id, player_name)

        increment_pokemon_seen_on_pokedex(self.pokemon_specie_id, player_name)

    @staticmethod
    def get_pokemon_info(pokemon_id):

        if not check_pokemon_exists(pokemon_id):
            raise PokemonDoesntExists

        query = f"SELECT especie, taxa_captura, experiencia, id_pokemon FROM instancia_pokemon\
         INNER JOIN pokemon ON instancia_pokemon.id_pokemon = pokemon.id WHERE instancia_pokemon.id = {pokemon_id};"

        response = run_query_fetchone(query)
        return response

    def display(self):

        print_title(f"Um pokemon selvagem apareceu!!!: {self.pokemon_name}")

        pokebolas_in_backpack = self.get_pokebolas()
        total_pokebolas = 0

        for _, value in pokebolas_in_backpack.items():
            total_pokebolas += len(value)

        while total_pokebolas > 0:

            print_subtitle("O que deseja fazer?")
            print_prompt("Selecione algum número:")
            map_option_item_use = self.display_menu_options()

            option: int = int(input("Selecione uma opção...\n"))

            if option == 0:
                return None

            while not map_option_item_use.get(option):
                option = int(input("Selecione uma opção válida...\n"))

            option_item_id = map_option_item_use[option][0]
            option_item_name = map_option_item_use[option][1]

            if option_item_name in self.berry_dict.keys():
                self.pokemon_catch_prob += self.berry_stats[option_item_name] / 100.0
                print_prompt(f"Você utilizou um berry do tipo {option_item_name}!")
                print_prompt(f"Isso aumentou a chance de captura\
                             do pokemon em {self.berry_stats[option_item_name]}%")
                use_item(option_item_id)

            if option_item_name in self.pokebolas_dict.keys():
                print_prompt(f"Você jogou uma pokebola do tipo {option_item_name}...")
                if random.random() < self.pokemon_catch_prob * self.pokeball_stats[option_item_name]:
                    self.catch_pokemon(option_item_id)
                    use_item(option_item_id)
                    print_prompt(f"Parabéns!!! Você conseguiu capturar o pokemon {self.pokemon_name}")
                    print_prompt(f"Você ganhou {self.pokemon_xp} pontos de experiência!!!")
                    return self.pokemon_xp

                print_prompt(f"Infelizmente você não conseguiu capturar o pokemon :(")
                use_item(option_item_id)
                total_pokebolas -= 1

        if total_pokebolas == 0:
            print_subtitle("Infelizmente você não tem nenhuma pokebola :(")
            print_subtitle("Procure um vendedor para comprar algumas pokebolas")
            return None

    @staticmethod
    def get_berry_stats():
        query = f"SELECT nome, aumento_taxa_captura FROM berry;"
        response = run_query_fetchall(query)

        berry_stats = {}

        for berry in response:
            berry_stats[berry['nome']] = berry['aumento_taxa_captura']

        return berry_stats

    @staticmethod
    def get_pokeball_stats(pokebolas_dict):
        pokeball_stats = {}

        for pokeball_name, pokeball_id in pokebolas_dict.items():
            query = f"SELECT get_pokeball_catch_rate({pokeball_id});"
            response = run_query_fetchall(query)
            pokeball_stats[pokeball_name] = dict(response[0])['get_pokeball_catch_rate']
        
        return pokeball_stats

    def display_menu_options(self):

        options_count = 1
        map_option_item_use = {}

        berries = self.get_papel_itens_instances(self.berry_dict)

        for berry_name, berry_list in berries.items():
            if len(berry_list) > 0:
                print(f"{options_count} - Utilizar berry {berry_name}.")
                map_option_item_use[options_count] = (berry_list[0], berry_name)
                options_count += 1

        pokebolas = self.get_papel_itens_instances(self.pokebolas_dict)

        for pokebola_name, pokebola_list in pokebolas.items():
            if len(pokebola_list) > 0:
                print(f"{options_count} - Utilizar pokebola {pokebola_name}.")
                map_option_item_use[options_count] = (pokebola_list[0], pokebola_name)
                options_count += 1

        print(f"0 - Cancelar captura.")

        return map_option_item_use

    def catch_pokemon(self, pokebola_id):

        mochila_id = self.player_name

        if not check_pokemon_exists(self.pokemon_id):
            raise PokemonDoesntExists(f"Error to find pokemon id:{self.pokemon_id}")

        if not check_backpack_has_item(mochila_id, pokebola_id):
            raise ItemNoInBackpack(f"Item id: {pokebola_id} not in backpack {mochila_id}")

        self.create_catch(pokebola_id)
        increment_pokemon_catch_on_pokedex(self.pokemon_specie_id, self.player_name)

    def create_catch(self, pokebola_id):
        run_insert(f"INSERT INTO captura(id_instancia_pokemon, id_treinador)\
         VALUES ({self.pokemon_id}, '{self.player_name}');")
        self.create_catch_event(pokebola_id)

    def create_catch_event(self, pokebola_instance_id):

        pokebola_id = get_item_id(pokebola_instance_id)['id_item']
        run_insert(f"INSERT INTO evento_captura VALUES ({self.pokemon_id}, {pokebola_id});")

    def get_pokebolas(self):
        return self.get_papel_itens_instances(self.pokebolas_dict)

    def get_papel_itens_instances(self, papel_dict):

        aux_dict = papel_dict.copy()

        for key, value in aux_dict.items():
            itens = get_item_instances_on_backpack(value, self.player_name)
            itens_list = []
            for item in itens:
                itens_list.append(item['id_instancia_item'])
            aux_dict[key] = itens_list

        return aux_dict


if __name__ == "__main__":
    catch = Catch(1, "Ash Ketchum")

    print(catch.display())
