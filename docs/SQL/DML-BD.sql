-- Arquivo para popular pokémons --
-- INSERT group 0: ELEMENTO
INSERT INTO elemento (nome) VALUES ('fogo'), ('água'), ('grama'), ('voador'), ('lutador'), ('veneno'), ('elétrico'), ('terra'), ('pedra'), ('psiquico'), ('gelo'), ('inseto'), ('fantasma'), ('ferro'), ('dragão'), ('sombrio'), ('fada'), ('normal');

-- INSERT group 1: MAPA, REGIÃO, POSIÇÃO, REGIAO POSSUI ELEMENTO

-- MAPA
INSERT INTO mapa (id) VALUES (DEFAULT);

-- REGIÃO
INSERT INTO regiao (entrada, id_mapa) VALUES (0, 1), (2, 1), (4, 1);

-- REGIÃO POSSUI ELEMENTO
INSERT INTO regiao_possui_elemento (id_regiao, id_elemento) VALUES 
(1, 3), (1, 4), (1, 5), (1, 8), (1, 12), (1, 18), -- REGIÃO 1
(2, 1), (2, 2), (2, 7), (2, 9), (2, 11), (2, 14), -- REGIÃO 2
(3, 6), (3, 10), (3, 13), (3, 15), (3, 16), (3, 17); -- REGIÃO 3

-- POSIÇÃO
INSERT INTO posicao (id_regiao, norte, sul , leste , oeste , cima , baixo) VALUES
-- POSIÇÕES REGIÃO 1
(1, 2, NULL, 4, NULL, NULL, NULL), (1, NULL, 1, 3, NULL, NULL, NULL), (1, NULL, 4, NULL, 2, NULL, NULL),
(1, 3, 5, 7, 1, NULL, NULL), (1, 4, NULL, 6, NULL, NULL, NULL), (1, 7, NULL, NULL, 5, NULL, NULL),
(1, NULL, 6, 8, 4, NULL, NULL), (1, 9, 11, NULL, 7, NULL, NULL), (1, NULL, 8, 13, 10, NULL, NULL),
(1, NULL, NULL, 9, NULL, NULL, NULL), (1, 8, NULL, 12, NULL, NULL, NULL), (1, 14, NULL, 15, 11, NULL, NULL),
(1, NULL, 14, 15, 9, NULL, NULL), (1, 13, 12, 15, NULL, NULL, NULL), (1, 13, 12, 16, 14, NULL, NULL),
-- POSIÇÕES REGIÃO 2
(2, 19, 17, 20, 15, NULL, NULL), (2, 16, NULL, 18, NULL, NULL, NULL), (2, NULL, NULL, 25, NULL, NULL, NULL),
(2, NULL, 20, NULL, 16, NULL, NULL), (2, 19, NULL, 21, 16, NULL, NULL), (2, NULL, NULL, 22, 20, NULL, NULL),
(2, NULL, 25, 23, 21, NULL, NULL), (2, 24, 26, NULL, 22, NULL, NULL), (2, NULL, 23, NULL, NULL, NULL, NULL),
(2, 22, 27, 26, 28, NULL, NULL), (2, 23, 27, NULL, 25, NULL, NULL), (2, 25, 30, 26, 28, NULL, NULL),
(2, 25, 29, 27, NULL, NULL, NULL), (2, 28, 32, 30, NULL, NULL, NULL), (2, 27, 32, 31, 29, NULL, NULL),
(2, NULL, 32, NULL, 30, NULL, NULL), (2, 30, 33, 31, 29, NULL, NULL),
-- POSIÇÕES REGIÃO 3
(3, 32, 44, NULL, NULL, NULL, 34), (3, NULL, 41, 35, 36, NULL, NULL), (3, NULL, 37, NULL, 34, NULL, NULL),
(3, NULL, 38, 34, NULL, NULL, NULL), (3, 35, 39, NULL, 41, NULL, NULL), (3, 36, 40, 41, NULL, NULL, NULL),
(3, 37, NULL, NULL, 42, NULL, NULL), (3, 38, NULL, 42, NULL, NULL, NULL), (3, 34, 42, 37, 38, NULL, NULL),
(3, 41, NULL, 39, 40, 43, NULL), (3, 46, NULL, NULL, NULL, NULL, NULL), (3, 33, 45, NULL, NULL, NULL, NULL),
(3, 44, 46, NULL, NULL, NULL, NULL), (3, 45, 43, NULL, NULL, NULL, NULL);

-- INSERT group 2: NPC, TREINADOR, MOCHILA, POKEDEX
-- TODO: Quando o mapa for criado, corrigir NPCs e Professor - DONE, mas testar com mapa ainda sim

-- NPC
INSERT INTO npc (nome, fala, profissao, id_posicao) VALUES 
('Mãe', 'Oh, meu filho, cresceu tanto! Já vai sair na sua primeira jornada Pokémon... Não esqueça de me ligar S2', 'matriarca', 2),
('Professor Oak', 'Olá treinador, sou o Professor Oak!! Você sabia que existem vários tipos de pokébola? Cada uma delas possui uma taxa de captura maior. Use elas com sabedoria', 'professor', 4),
('Vendedor June', 'Bem vindo a minha lojinha! Fique avontade!!', 'vendedor', 6),
('BugCatcher April', 'Insetos!! Insetos!! Procuro apenas pokemons Insetos!!', 'bugcatcher', 17),
('Professor Algo', 'Tudo bem treinador? Me chamo Professor Algo. Você sabia que certos pokemons podem evoluir sem adquirir experiência? Basta dar a ele a Evostone correta!!', 'professor', 22),
('Vendedora May', 'Ei muleque, não toque em nada que não vá pagar!!', 'vendedor', 26),
('Aventureiro Jonas', 'Fazem alguns meses desde que sai da minha cidade natal para minha jornada, é um pouco solitário mas é uma experiência incrível', 'aventureiro', 43);

-- Treinador
INSERT INTO treinador (nome, nivel, dinheiro, insignia, id_posicao, id_professor) VALUES ('Ash Ketchum', 0, 0.00, 'iniciante', 1, 1);

-- Mochila
INSERT INTO mochila (id, capacidade, dinheiro_maximo) VALUES ('Ash Ketchum', 50, 500.00);

-- Pokedex
INSERT INTO pokedex (id) VALUES ('Ash Ketchum');

-- Pokemon
INSERT INTO pokemon (especie, tamanho, peso, descricao, elemento1,  taxa_captura, elemento2) VALUES  ('bulbasaur', 7, 69, 'hmm', 3, 0.75, 6), ('ivysaur', 10, 130, 'hmm', 3, 0.55, 6), ('venusaur', 20, 1000, 'hmm', 3, 0.45, 6), ('charmander', 6, 85, 'hmm', 1, 0.75, null), ('charmeleon', 11, 190, 'hmm', 1, 0.55, null), ('charizard', 17, 905, 'hmm', 1, 0.45, 4), ('squirtle', 5, 90, 'hmm', 2, 0.75, null), ('wartortle', 10, 225, 'hmm', 2, 0.55, null), ('blastoise', 16, 855, 'hmm', 2, 0.45, null), ('caterpie', 3, 29, 'hmm', 12, 0.75, null), ('metapod', 7, 99, 'hmm', 12, 0.55, null), ('butterfree', 11, 320, 'hmm', 12, 0.45, 4), ('weedle', 3, 32, 'hmm', 12, 0.75, 6), ('kakuna', 6, 100, 'hmm', 12, 0.55, 6), ('beedrill', 10, 295, 'hmm', 12, 0.45, 6), ('pidgey', 3, 18, 'hmm', 18, 0.75, 4), ('pidgeotto', 11, 300, 'hmm', 18, 0.55, 4), ('pidgeot', 15, 395, 'hmm', 18, 0.45, 4), ('rattata', 3, 35, 'hmm', 18, 0.6, null), ('raticate', 7, 185, 'hmm', 18, 0.5, null), ('spearow', 3, 20, 'hmm', 18, 0.6, 4), ('fearow', 12, 380, 'hmm', 18, 0.5, 4), ('ekans', 20, 69, 'hmm', 6, 0.6, null), ('arbok', 35, 650, 'hmm', 6, 0.5, null), ('pikachu', 4, 60, 'hmm', 7, 0.6, null), ('raichu', 8, 300, 'hmm', 7, 0.5, null), ('sandshrew', 6, 120, 'hmm', 8, 0.6, null), ('sandslash', 10, 295, 'hmm', 8, 0.5, null), ('nidoran-f', 4, 70, 'hmm', 6, 0.75, null), ('nidorina', 8, 200, 'hmm', 6, 0.55, null), ('nidoqueen', 13, 600, 'hmm', 6, 0.45, 8), ('nidoran-m', 5, 90, 'hmm', 6, 0.75, null), ('nidorino', 9, 195, 'hmm', 6, 0.55, null), ('nidoking', 14, 620, 'hmm', 6, 0.45, 8), ('clefairy', 6, 75, 'hmm', 17, 0.6, null), ('clefable', 13, 400, 'hmm', 17, 0.5, null), ('vulpix', 6, 99, 'hmm', 1, 0.6, null), ('ninetales', 11, 199, 'hmm', 1, 0.5, null), ('jigglypuff', 5, 55, 'hmm', 18, 0.6, 17), ('wigglytuff', 10, 120, 'hmm', 18, 0.5, 17), ('zubat', 8, 75, 'hmm', 6, 0.6, 4), ('golbat', 16, 550, 'hmm', 6, 0.5, 4), ('oddish', 5, 54, 'hmm', 3, 0.75, 6), ('gloom', 8, 86, 'hmm', 3, 0.55, 6), ('vileplume', 12, 186, 'hmm', 3, 0.45, 6), ('paras', 3, 54, 'hmm', 12, 0.6, 3), ('parasect', 10, 295, 'hmm', 12, 0.5, 3), ('venonat', 10, 300, 'hmm', 12, 0.6, 6), ('venomoth', 15, 125, 'hmm', 12, 0.5, 6), ('diglett', 2, 8, 'hmm', 8, 0.6, null), ('dugtrio', 7, 333, 'hmm', 8, 0.5, null), ('meowth', 4, 42, 'hmm', 18, 0.6, null), ('persian', 10, 320, 'hmm', 18, 0.5, null), ('psyduck', 8, 196, 'hmm', 2, 0.6, null), ('golduck', 17, 766, 'hmm', 2, 0.5, null), ('mankey', 5, 280, 'hmm', 5, 0.6, null), ('primeape', 10, 320, 'hmm', 5, 0.5, null), ('growlithe', 7, 190, 'hmm', 1, 0.6, null), ('arcanine', 19, 1550, 'hmm', 1, 0.5, null), ('poliwag', 6, 124, 'hmm', 2, 0.75, null), ('poliwhirl', 10, 200, 'hmm', 2, 0.55, null), ('poliwrath', 13, 540, 'hmm', 2, 0.45, 5), ('abra', 9, 195, 'hmm', 10, 0.75, null), ('kadabra', 13, 565, 'hmm', 10, 0.55, null), ('alakazam', 15, 480, 'hmm', 10, 0.45, null), ('machop', 8, 195, 'hmm', 5, 0.75, null), ('machoke', 15, 705, 'hmm', 5, 0.55, null), ('machamp', 16, 1300, 'hmm', 5, 0.45, null), ('bellsprout', 7, 40, 'hmm', 3, 0.75, 6), ('weepinbell', 10, 64, 'hmm', 3, 0.55, 6), ('victreebel', 17, 155, 'hmm', 3, 0.45, 6), ('tentacool', 9, 455, 'hmm', 2, 0.6, 6), ('tentacruel', 16, 550, 'hmm', 2, 0.5, 6), ('geodude', 4, 200, 'hmm', 9, 0.75, 8), ('graveler', 10, 1050, 'hmm', 9, 0.55, 8), ('golem', 14, 3000, 'hmm', 9, 0.45, 8), ('ponyta', 10, 300, 'hmm', 1, 0.6, null), ('rapidash', 17, 950, 'hmm', 1, 0.5, null), ('slowpoke', 12, 360, 'hmm', 2, 0.6, 10), ('slowbro', 16, 785, 'hmm', 2, 0.5, 10), ('magnemite', 3, 60, 'hmm', 7, 0.6, 14), ('magneton', 10, 600, 'hmm', 7, 0.5, 14), ('farfetchd', 8, 150, 'hmm', 18, 0.65, 4), ('doduo', 14, 392, 'hmm', 18, 0.6, 4), ('dodrio', 18, 852, 'hmm', 18, 0.5, 4), ('seel', 11, 900, 'hmm', 2, 0.6, null), ('dewgong', 17, 1200, 'hmm', 2, 0.5, 11), ('grimer', 9, 300, 'hmm', 6, 0.6, null), ('muk', 12, 300, 'hmm', 6, 0.5, null), ('shellder', 3, 40, 'hmm', 2, 0.6, null), ('cloyster', 15, 1325, 'hmm', 2, 0.5, 11), ('gastly', 13, 1, 'hmm', 13, 0.75, 6), ('haunter', 16, 1, 'hmm', 13, 0.55, 6), ('gengar', 15, 405, 'hmm', 13, 0.45, 6), ('onix', 88, 2100, 'hmm', 9, 0.65, 8), ('drowzee', 10, 324, 'hmm', 10, 0.6, null), ('hypno', 16, 756, 'hmm', 10, 0.5, null), ('krabby', 4, 65, 'hmm', 2, 0.6, null), ('kingler', 13, 600, 'hmm', 2, 0.5, null), ('voltorb', 5, 104, 'hmm', 7, 0.6, null), ('electrode', 12, 666, 'hmm', 7, 0.5, null), ('exeggcute', 4, 25, 'hmm', 3, 0.6, 10), ('exeggutor', 20, 1200, 'hmm', 3, 0.5, 10), ('cubone', 4, 65, 'hmm', 8, 0.6, null), ('marowak', 10, 450, 'hmm', 8, 0.5, null), ('hitmonlee', 15, 498, 'hmm', 5, 0.65, null), ('hitmonchan', 14, 502, 'hmm', 5, 0.65, null), ('lickitung', 12, 655, 'hmm', 18, 0.65, null), ('koffing', 6, 10, 'hmm', 6, 0.6, null), ('weezing', 12, 95, 'hmm', 6, 0.6, null), ('rhyhorn', 10, 1150, 'hmm', 8, 0.6, 9), ('rhydon', 19, 1200, 'hmm', 8, 0.5, 9), ('chansey', 11, 346, 'hmm', 18, 0.65, null), ('tangela', 10, 350, 'hmm', 3, 0.65, null), ('kangaskhan', 22, 800, 'hmm', 18, 0.65, null), ('horsea', 4, 80, 'hmm', 2, 0.6, null), ('seadra', 12, 250, 'hmm', 2, 0.5, null), ('goldeen', 6, 150, 'hmm', 2, 0.6, null), ('seaking', 13, 390, 'hmm', 2, 0.5, null), ('staryu', 8, 345, 'hmm', 2, 0.6, null), ('starmie', 11, 800, 'hmm', 2, 0.5, 10), ('mr-mime', 13, 545, 'hmm', 10, 0.65, 17), ('scyther', 15, 560, 'hmm', 12, 0.65, 4), ('jynx', 14, 406, 'hmm', 11, 0.65, 10), ('electabuzz', 11, 300, 'hmm', 7, 0.65, null), ('magmar', 13, 445, 'hmm', 1, 0.65, null), ('pinsir', 15, 550, 'hmm', 12, 0.65, null), ('tauros', 14, 884, 'hmm', 18, 0.65, null), ('magikarp', 9, 100, 'hmm', 2, 0.6, null), ('gyarados', 65, 2350, 'hmm', 2, 0.5, 4), ('lapras', 25, 2200, 'hmm', 2, 0.65, 11), ('ditto', 3, 40, 'hmm', 18, 0.65, null), ('eevee', 3, 65, 'hmm', 18, 0.6, null), ('vaporeon', 10, 290, 'hmm', 2, 0.5, null), ('jolteon', 8, 245, 'hmm', 7, 0.5, null), ('flareon', 9, 250, 'hmm', 1, 0.5, null), ('porygon', 8, 365, 'hmm', 18, 0.65, null), ('omanyte', 4, 75, 'hmm', 9, 0.6, 2), ('omastar', 10, 350, 'hmm', 9, 0.5, 2), ('kabuto', 5, 115, 'hmm', 9, 0.6, 2), ('kabutops', 13, 405, 'hmm', 9, 0.6, 2), ('aerodactyl', 18, 590, 'hmm', 9, 0.65, 4), ('snorlax', 21, 4600, 'hmm', 18, 0.65, null), ('articuno', 17, 554, 'hmm', 11, 0.05, 4), ('zapdos', 16, 526, 'hmm', 7, 0.05, 4), ('moltres', 20, 600, 'hmm', 1, 0.05, 4), ('dratini', 18, 33, 'hmm', 15, 0.75, null), ('dragonair', 40, 165, 'hmm', 15, 0.55, null), ('dragonite', 22, 2100, 'hmm', 15, 0.45, 4), ('mewtwo', 20, 1220, 'hmm', 10, 0.05, null), ('mew', 4, 40, 'hmm', 10, 0.05, null);

-- Evoluções
INSERT INTO pokemon_evolucao (pokemon_id, evolucao_id, experiencia_evoluir) VALUES  (1, 2, 100), (2, 3, 100), (4, 5, 100), (5, 6, 100), (7, 8, 100), (8, 9, 100), (10, 11, 100), (11, 12, 100), (13, 14, 100), (14, 15, 100), (16, 17, 100), (17, 18, 100), (19, 20, 100), (21, 22, 100), (23, 24, 100), (25, 26, 100), (27, 28, 100), (29, 30, 100), (30, 31, 100), (32, 33, 100), (33, 34, 100), (35, 36, 100), (37, 38, 100), (39, 40, 100), (41, 42, 100), (43, 44, 100), (44, 45, 100), (46, 47, 100), (48, 49, 100), (50, 51, 100), (52, 53, 100), (54, 55, 100), (57, 58, 100), (58, 59, 100), (60, 61, 100), (61, 62, 100), (63, 64, 100), (64, 65, 100), (66, 67, 100), (67, 68, 100), (69, 70, 100), (70, 71, 100), (72, 73, 100), (74, 75, 100), (75, 76, 100), (77, 78, 100), (79, 80, 100), (81, 82, 100), (84, 85, 100), (86, 87, 100), (88, 89, 100), (90, 91, 100), (92, 93, 100), (93, 94, 100), (95, 96, 100), (98, 99, 100), (100, 101, 100), (102, 103, 100), (104, 105, 100), (109, 110, 100), (111, 112, 100), (116, 117, 100), (118, 119, 100), (120, 121, 100), (129, 130, 100), (138, 139, 100), (140, 141, 100), (147, 148, 100), (148, 149, 100);
