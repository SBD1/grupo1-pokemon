# Dicionário Entidades MER

|    Data    | Versão | Descrição | Autor |
| :---: | :---: | :---: | :---: |
| 05/02/2022 | 0.1 | Criação do documento | [João Guedes](https://github.com/sudjoao), [Lucas Medeiros](https://github.com/medeiroslucas) |
| 05/02/2022 | 0.2 | Adição das entidades Berry, Candy, Pokebola, Vendedor, Mapa, Região, Posição e  Tipo | [Lucas Medeiros](https://github.com/medeiroslucas) |
| 05/02/2022 | 0.3 | Adição das entidades Pokémon, Pokédex, Treinador, Mochila, Item, EvoStone, NPC e Professor | [João Guedes](https://github.com/sudjoao) |
| 22/03/2022 | 0.4 | Atualização da entidade Tipo para Elemento | [Iuri Severo](https://github.com/iurisevero) |


## O que é?
O dicionário de Entidades do MER é um documento que explica o que é cada uma das entidades para que pessoas que não conheçam o contexto *Pokémon* consigam entender um pouco sobre o que é cada uma daquelas entidades e, consequentimente, entender a necessidade de cada um dos atributos levantados na modelagem.

## Inspiração
Durante uma das lives, o professor Maurício comentou que seria interessante a existência de um documento para que nosso contexto fique mais claro e também que possamos anotar algumas coisas que não possam ser representados dentro do MER.

## Entidades
| Nome | Descrição  | Observação    |
| ---- | -------    | ---------     |
| Pokémon | São criaturas ficticias que possuem poderes, normalmente são separados por **tipos**, possuem ataques e podem evoluir para uma forma mais forte. |  Dentro do nosso contexto existirão apenas 151 pokémons    |
| Pokédex | Dispostivo utilizado para registrar dados sobre as espécies de **Pokémon**. |  Para conseguir visualizar todas as informações sobre um pokémon é necessário capturá-lo  |
| Treinador | Pessoa que captura e treina **Pokémons** |   |
| Mochila | Lugar onde os **Items** são guardados |   |
| Item | Objeto que pode ser utilizado para uma finalidade específica | |
| Candy | **Item** que concede aumento no valor de experiência de um **Pokemon** | |
| Berry | **Item** que concede aumento na taxa de sucesso no momento da captura de um **Pokemon** | |
| Pokebola | **Item** utilizado para capturar um **Pokemon** | Podem existir vários tipos de **Pokebola** |
| EvoStone | **Item** utilizado para evoluir certos **Pokémons** para o mesmo **Tipo** da pedra  | |
| NPC | Pessoa dentro do sistema que possui falas/ações pré-definidas |   |
| Vendedor | **NPC** responsável pela venda de **Itens** | |
| Professor | **NPC** responsável por dar instruções ao **Treinador**| |
| Posição | Unidade mínima de localização no jogo | Pode ser uma posição vazia ou conter instâncias como **Jogador**, **Pokemon**, **Item**, etc. |
| Região | Unidade de localização formada pela junção de **Posições** | Pertence a um tipo específico |
| Mapa | Unidade máxima de localização, formada pela junção de **Regiões** | |
| Elemento | Entidade que possui as características comuns à um **Elemento** de **Pokemon** | **Regiões** também possuem elementos e, geralmente, **Pokemons** de um determinado **Elemento** são encontrados em **Regiões** equivalentes

