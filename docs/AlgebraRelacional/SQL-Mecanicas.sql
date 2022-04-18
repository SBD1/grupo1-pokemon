--- SQL utilizado para a mecanica de movimentação
--- Queries abaixo apresentam pontos que são construidos dinamicamente no jogo, identificadas por {}.

-- Posição atual do treinador
SELECT t.id_posicao FROM treinador t WHERE t.nome = {player_name};

-- Posições que se ligam a posição atual do treinador
SELECT p.norte, p.sul, p.leste, p.oeste, p.cima, p.baixo FROM posicao p WHERE p.id = {pos};

-- Numero de pokemons necessário a entrada em uma região, tendo com parametro a posição escolhida pelo jogador para avançar
SELECT r.entrada FROM regiao r WHERE r.id = (SELECT p.id_regiao FROM posicao p WHERE p.id = {pos});

-- Numero de pokemons capturados pelo treinador até o momento, utilizado para verificar se o treinador pode passar de região
SELECT COUNT(*) as n_capturados FROM captura WHERE id_treinador = {player_name};

-- Validação da entrada em região por Function do banco de dados
-- A Function utiliza das duas queries acima para validar a entrada em uma nova regiao

SELECT valid_region_change({posicao}, {player_name});

-- Mudança efetiva da posição do treinador de acordo a sua escolha
UPDATE treinador SET id_posicao = {pos} WHERE nome = {player_name};