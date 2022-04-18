-- =========================================================================
--- SQL utilizado para a mecanica de movimentação
--- Queries abaixo apresentam pontos que são construidos dinamicamente no jogo, identificadas por {}.
-- =========================================================================

-- Posição atual do treinador
SELECT t.id_posicao FROM treinador t WHERE t.nome = {player_name};

-- Posições que se ligam a posição atual do treinador
SELECT p.norte, p.sul, p.leste, p.oeste, p.cima, p.baixo FROM posicao p WHERE p.id = {pos};

-- Numero de pokemons necessário a entrada em uma região, tendo com parametro a posição escolhida pelo jogador para avançar
SELECT r.entrada FROM regiao r WHERE r.id = (SELECT p.id_regiao FROM posicao p WHERE p.id = {pos});

-- Numero de pokemons capturados pelo treinador até o momento, utilizado para verificar se o treinador pode passar de região
SELECT COUNT(*) as n_capturados FROM captura WHERE id_treinador = {player_name};

-- =========================================================================
-- Validação da entrada em região por Function do banco de dados
-- A Function utiliza das duas queries acima para validar a entrada em uma nova regiao
-- =========================================================================

SELECT valid_region_change({posicao}, {player_name});

-- Mudança efetiva da posição do treinador de acordo a sua escolha
UPDATE treinador SET id_posicao = {pos} WHERE nome = {player_name};

-- =========================================================================
-- Mecânica de compra de um item do NPC
-- =========================================================================

-- Descobrir o id real de uma instância de item para descobrir qual é a especialização do item que vai ser comprado
SELECT id_item FROM instancia_item WHERE id = {id_instancia};

-- Com o id do item descoberto na QUERY acima, conseguimos encontrar qual é a especialização do item
SELECT papel FROM especializacao_do_item WHERE id_item = {_id_item};

-- Agora vamos retornar o preço do item da tabela específica do tipo do item que estamos olhando. A {tabela} vai ser o nome da especialização, que é exatamente o retorno da QUERY acima em 'papel'. O {_id_item} foi descoberto na penúltima QUERY.
SELECT QUERY EXECUTE 'SELECT preco FROM ' || {tabela} || ' WHERE id=' || {_id_item};

-- =========================================================================
-- titulo:
-- =========================================================================