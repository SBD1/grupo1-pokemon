from database import run_insert, get_item_instances_on_backpack, get_papel_item, run_query_fetchone
from exceptions.communs import PokemonDoesntExists, ItemDoesntExists, ItemNoInBackpack
from utils import (check_backpack_has_item,
                   check_pokemon_exists,
                   print_title,
                   print_subtitle)


class Catch:

    pokebolas_dict = {
        "Pokeball": 20,
        "Great Ball": 21,
        "Ultra Ball": 22,
        "Master Ball": 23
    }

    candy_dict = {
        "Picante": 1,
        "Seco": 2,
        "Doce": 3,
        "Amargo": 4
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
        self.player_name = player_name

    @staticmethod
    def get_pokemon_info(pokemon_id):
        query = f"SELECT especie, taxa_captura FROM instancia_pokemon\
         INNER JOIN pokemon ON instancia_pokemon.id_pokemon = pokemon.id WHERE instancia_pokemon.id = {pokemon_id};"

        response = run_query_fetchone(query)
        return response

    def display(self):

        print_title(f"Um pokemon selvagem apareceu!!!: {self.pokemon_name}")

        pokebolas_in_backpack = self.get_pokebolas()
        total_pokebolas = 0

        for _, value in pokebolas_in_backpack.items():
            total_pokebolas += len(value)

        if total_pokebolas == 0:
            print_subtitle("Infelizmente você não tem nenhuma pokebola :(")
            print_subtitle("Procure um vendedor para comprar algumas pokebolas")
            return None

        print_subtitle("O que deseja fazer?")
        map_option_item_use = self.display_menu_options()

        option: int = int(input("Selecione uma opção...\n"))

        if option == 0:
            return None

        while not map_option_item_use.get(option):
            option = int(input("Selecione uma opção válida...\n"))

        print(map_option_item_use)

    def display_menu_options(self):

        options_count = 1
        map_option_item_use = {}

        berries = self.get_papel_itens_instances(self.berry_dict)

        for berry_name, berry_list in berries.items():
            if len(berry_list) > 0:
                print(f"<{options_count}> Utilizar barry {berry_name}.")
                map_option_item_use[options_count] = berry_list[0]
                options_count += 1

        candies = self.get_papel_itens_instances(self.candy_dict)

        for candy_name, candy_list in candies.items():
            if len(candy_list) > 0:
                print(f"<{options_count}> Utilizar candy {candy_name}.")
                map_option_item_use[options_count] = candy_list[0]
                options_count += 1

        pokebolas = self.get_papel_itens_instances(self.pokebolas_dict)

        for pokebola_name, pokebola_list in pokebolas.items():
            if len(pokebola_list) > 0:
                print(f"<{options_count}> Utilizar pokebola {pokebola_name}.")
                map_option_item_use[options_count] = pokebola_list[0]
                options_count += 1

        print(f"    <0> Cancelar captura.")

        return map_option_item_use

    def catch_pokemon(self, pokebola_id):

        mochila_id = self.player_name

        if not check_pokemon_exists(self.pokemon_id):
            raise PokemonDoesntExists(f"Error to find pokemon id:{self.pokemon_id}")

        if not check_backpack_has_item(mochila_id, pokebola_id):
            raise ItemNoInBackpack(f"Item id: {pokebola_id} not in backpack {mochila_id}")

        self.create_catch(pokebola_id)

    def create_catch(self, pokebola_id):
        run_insert(f"INSERT INTO captura VALUES ({self.pokemon_id}, {self.player_name});")
        self.create_catch_event(pokebola_id)

    def create_catch_event(self, pokebola_id):
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
