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
INSERT INTO pokemon (especie, experiencia_evoluir, tamanho, peso, descricao, id_evolucao,elemento1,  taxa_captura, elemento2) VALUES  ('bulbasaur', 100, 7, 69, 'hmm', 2, 3, 0.75, 6),('ivysaur', 100, 10, 130, 'hmm', 3, 3, 0.55, 6),('venusaur', 100, 20, 1000, 'hmm', null, 3, 0.45, 6),('charmander', 100, 6, 85, 'hmm', 5, 1, 0.75, null),('charmeleon', 100, 11, 190, 'hmm', 6, 1, 0.55, null),('charizard', 100, 17, 905, 'hmm', null, 1, 0.45, 4),('squirtle', 100, 5, 90, 'hmm', 8, 2, 0.75, null),('wartortle', 100, 10, 225, 'hmm', 9, 2, 0.55, null),('blastoise', 100, 16, 855, 'hmm', null, 2, 0.45, null),('caterpie', 100, 3, 29, 'hmm', 11, 12, 0.75, null),('metapod', 100, 7, 99, 'hmm', 12, 12, 0.55, null),('butterfree', 100, 11, 320, 'hmm', null, 12, 0.45, 4),('weedle', 100, 3, 32, 'hmm', 14, 12, 0.75, 6),('kakuna', 100, 6, 100, 'hmm', 15, 12, 0.55, 6),('beedrill', 100, 10, 295, 'hmm', null, 12, 0.45, 6),('pidgey', 100, 3, 18, 'hmm', 17, 18, 0.75, 4),('pidgeotto', 100, 11, 300, 'hmm', 18, 18, 0.55, 4),('pidgeot', 100, 15, 395, 'hmm', null, 18, 0.45, 4),('rattata', 100, 3, 35, 'hmm', 20, 18, 0.6, null),('raticate', 100, 7, 185, 'hmm', null, 18, 0.5, null),('spearow', 100, 3, 20, 'hmm', 22, 18, 0.6, 4),('fearow', 100, 12, 380, 'hmm', null, 18, 0.5, 4),('ekans', 100, 20, 69, 'hmm', 24, 6, 0.6, null),('arbok', 100, 35, 650, 'hmm', null, 6, 0.5, null),('pikachu', 100, 4, 60, 'hmm', 26, 7, 0.6, null),('raichu', 100, 8, 300, 'hmm', null, 7, 0.5, null),('sandshrew', 100, 6, 120, 'hmm', 28, 8, 0.6, null),('sandslash', 100, 10, 295, 'hmm', null, 8, 0.5, null),('nidoran-f', 100, 4, 70, 'hmm', 30, 6, 0.75, null),('nidorina', 100, 8, 200, 'hmm', 31, 6, 0.55, null),('nidoqueen', 100, 13, 600, 'hmm', null, 6, 0.45, 8),('nidoran-m', 100, 5, 90, 'hmm', 33, 6, 0.75, null),('nidorino', 100, 9, 195, 'hmm', 34, 6, 0.55, null),('nidoking', 100, 14, 620, 'hmm', null, 6, 0.45, 8),('clefairy', 100, 6, 75, 'hmm', 36, 17, 0.6, null),('clefable', 100, 13, 400, 'hmm', null, 17, 0.5, null),('vulpix', 100, 6, 99, 'hmm', 38, 1, 0.6, null),('ninetales', 100, 11, 199, 'hmm', null, 1, 0.5, null),('jigglypuff', 100, 5, 55, '40', null, 18, 0.6, 17),('wigglytuff', 100, 10, 120, 'hmm', null, 18, 0.5, 17),('zubat', 100, 8, 75, 'hmm', 42, 6, 0.6, 4),('golbat', 100, 16, 550, 'hmm', null, 6, 0.5, 4),('oddish', 100, 5, 54, 'hmm', 44, 3, 0.75, 6),('gloom', 100, 8, 86, 'hmm', 45, 3, 0.55, 6),('vileplume', 100, 12, 186, 'hmm', null, 3, 0.45, 6),('paras', 100, 3, 54, 'hmm', 47, 12, 0.6, 3),('parasect', 100, 10, 295, 'hmm', null, 12, 0.5, 3),('venonat', 100, 10, 300, 'hmm', 49, 12, 0.6, 6),('venomoth', 100, 15, 125, 'hmm', null, 12, 0.5, 6),('diglett', 100, 2, 8, 'hmm', 51, 8, 0.6, null),('dugtrio', 100, 7, 333, 'hmm', null, 8, 0.5, null),('meowth', 100, 4, 42, 'hmm', 53, 18, 0.6, null),('persian', 100, 10, 320, 'hmm', null, 18, 0.5, null),('psyduck', 100, 8, 196, 'hmm', 55, 2, 0.6, null),('golduck', 100, 17, 766, 'hmm', null, 2, 0.5, null),('mankey', 100, 5, 280, 'hmm', null, 5, 0.6, null),('primeape', 100, 10, 320, 'hmm', 58, 5, 0.5, null),('growlithe', 100, 7, 190, 'hmm', 59, 1, 0.6, null),('arcanine', 100, 19, 1550, 'hmm', null, 1, 0.5, null),('poliwag', 100, 6, 124, 'hmm', 61, 2, 0.75, null),('poliwhirl', 100, 10, 200, 'hmm', 62, 2, 0.55, null),('poliwrath', 100, 13, 540, 'hmm', null, 2, 0.45, 5),('abra', 100, 9, 195, 'hmm', 64, 10, 0.75, null),('kadabra', 100, 13, 565, 'hmm', 65, 10, 0.55, null),('alakazam', 100, 15, 480, 'hmm', null, 10, 0.45, null),('machop', 100, 8, 195, 'hmm', 67, 5, 0.75, null),('machoke', 100, 15, 705, 'hmm', 68, 5, 0.55, null),('machamp', 100, 16, 1300, 'hmm', null, 5, 0.45, null),('bellsprout', 100, 7, 40, 'hmm', 70, 3, 0.75, 6),('weepinbell', 100, 10, 64, 'hmm', 71, 3, 0.55, 6),('victreebel', 100, 17, 155, 'hmm', null, 3, 0.45, 6),('tentacool', 100, 9, 455, 'hmm', 73, 2, 0.6, 6),('tentacruel', 100, 16, 550, 'hmm', null, 2, 0.5, 6),('geodude', 100, 4, 200, 'hmm', 75, 9, 0.75, 8),('graveler', 100, 10, 1050, 'hmm', 75, 9, 0.55, 8),('golem', 100, 14, 3000, 'hmm', null, 9, 0.45, 8),('ponyta', 100, 10, 300, 'hmm', 78, 1, 0.6, null),('rapidash', 100, 17, 950, 'hmm', null, 1, 0.5, null),('slowpoke', 100, 12, 360, 'hmm', 80, 2, 0.6, 10),('slowbro', 100, 16, 785, 'hmm', null, 2, 0.5, 10),('magnemite', 100, 3, 60, 'hmm', 82, 7, 0.6, 14),('magneton', 100, 10, 600, 'hmm', null, 7, 0.5, 14),('farfetchd', 100, 8, 150, 'hmm', null, 18, 0.65, 4),('doduo', 100, 14, 392, 'hmm', 85, 18, 0.6, 4),('dodrio', 100, 18, 852, 'hmm', null, 18, 0.5, 4),('seel', 100, 11, 900, 'hmm', 87, 2, 0.6, null),('dewgong', 100, 17, 1200, 'hmm', null, 2, 0.5, 11),('grimer', 100, 9, 300, 'hmm', 89, 6, 0.6, null),('muk', 100, 12, 300, 'hmm', null, 6, 0.5, null),('shellder', 100, 3, 40, 'hmm', 91, 2, 0.6, null),('cloyster', 100, 15, 1325, 'hmm', null, 2, 0.5, 11),('gastly', 100, 13, 1, 'hmm', 93, 13, 0.75, 6),('haunter', 100, 16, 1, 'hmm', 94, 13, 0.55, 6),('gengar', 100, 15, 405, 'hmm', null, 13, 0.45, 6),('onix', 100, 88, 2100, 'hmm', 96, 9, 0.65, 8),('drowzee', 100, 10, 324, 'hmm', null, 10, 0.6, null),('hypno', 100, 16, 756, 'hmm', null, 10, 0.5, null),('krabby', 100, 4, 65, 'hmm', 99, 2, 0.6, null),('kingler', 100, 13, 600, 'hmm', null, 2, 0.5, null),('voltorb', 100, 5, 104, 'hmm', 101, 7, 0.6, null),('electrode', 100, 12, 666, 'hmm', null, 7, 0.5, null),('exeggcute', 100, 4, 25, 'hmm', 103, 3, 0.6, 10),('exeggutor', 100, 20, 1200, 'hmm', null, 3, 0.5, 10),('cubone', 100, 4, 65, 'hmm', 105, 8, 0.6, null),('marowak', 100, 10, 450, 'hmm', null, 8, 0.5, null),('hitmonlee', 100, 15, 498, 'hmm', null, 5, 0.65, null),('hitmonchan', 100, 14, 502, 'hmm', null, 5, 0.65, null),('lickitung', 100, 12, 655, 'hmm', null, 18, 0.65, null),('koffing', 100, 6, 10, 'hmm', 110, 6, 0.6, null),('weezing', 100, 12, 95, 'hmm', null, 6, 0.6, null),('rhyhorn', 100, 10, 1150, 'hmm', 112, 8, 0.6, 9),('rhydon', 100, 19, 1200, 'hmm', null, 8, 0.5, 9),('chansey', 100, 11, 346, 'hmm', null, 18, 0.65, null),('tangela', 100, 10, 350, 'hmm', null, 3, 0.65, null),('kangaskhan', 100, 22, 800, 'hmm', null, 18, 0.65, null),('horsea', 100, 4, 80, 'hmm', 117, 2, 0.6, null),('seadra', 100, 12, 250, 'hmm', null, 2, 0.5, null),('goldeen', 100, 6, 150, 'hmm', 119, 2, 0.6, null),('seaking', 100, 13, 390, 'hmm', null, 2, 0.5, null),('staryu', 100, 8, 345, 'hmm', 121, 2, 0.6, null),('starmie', 100, 11, 800, 'hmm', null, 2, 0.5, 10),('mr-mime', 100, 13, 545, 'hmm', null, 10, 0.65, 17),('scyther', 100, 15, 560, 'hmm', null, 12, 0.65, 4),('jynx', 100, 14, 406, 'hmm', null, 11, 0.65, 10),('electabuzz', 100, 11, 300, 'hmm', null, 7, 0.65, null),('magmar', 100, 13, 445, 'hmm', null, 1, 0.65, null),('pinsir', 100, 15, 550, 'hmm', null, 12, 0.65, null),('tauros', 100, 14, 884, 'hmm', null, 18, 0.65, null),('magikarp', 100, 9, 100, 'hmm', 130, 2, 0.6, null),('gyarados', 100, 65, 2350, 'hmm', null, 2, 0.5, 4),('lapras', 100, 25, 2200, 'hmm', null, 2, 0.65, 11),('ditto', 100, 3, 40, 'hmm', null, 18, 0.65, null),('eevee', 100, 3, 65, 'hmm', null, 18, 0.6, null),('vaporeon', 100, 10, 290, 'hmm', null, 2, 0.5, null),('jolteon', 100, 8, 245, 'hmm', null, 7, 0.5, null),('flareon', 100, 9, 250, 'hmm', null, 1, 0.5, null),('porygon', 100, 8, 365, 'hmm', null, 18, 0.65, null),('omanyte', 100, 4, 75, 'hmm', 139, 9, 0.6, 2),('omastar', 100, 10, 350, 'hmm', null, 9, 0.5, 2),('kabuto', 100, 5, 115, 'hmm', 141, 9, 0.6, 2),('kabutops', 100, 13, 405, 'hmm', null, 9, 0.6, 2),('aerodactyl', 100, 18, 590, 'hmm', null, 9, 0.65, 4),('snorlax', 100, 21, 4600, 'hmm', null, 18, 0.65, null),('articuno', 100, 17, 554, 'hmm', null, 11, 0.05, 4),('zapdos', 100, 16, 526, 'hmm', null, 7, 0.05, 4),('moltres', 100, 20, 600, 'hmm', null, 1, 0.05, 4),('dratini', 100, 18, 33, 'hmm', 148, 15, 0.75, null),('dragonair', 100, 40, 165, 'hmm', 149, 15, 0.55, null),('dragonite', 100, 22, 2100, 'hmm', null, 15, 0.45, 4),('mewtwo', 100, 20, 1220, 'hmm', null, 10, 0.05, null),('mew', 100, 4, 40, 'hmm', null, 10, 0.05, null);

