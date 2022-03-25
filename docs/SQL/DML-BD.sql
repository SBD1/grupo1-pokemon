-- Arquivo para popular pokémons --
-- INSERT group 0: ELEMENTO
INSERT INTO elemento (nome) VALUES ('fogo'), ('água'), ('grama'), ('voador'), ('lutador'), ('veneno'), ('elétrico'), ('terra'), ('pedra'), ('psiquico'), ('gelo'), ('inseto'), ('fantasma'), ('ferro'), ('dragão'), ('sombrio'), ('fada');

-- INSERT group 2: NPC, TREINADOR, MOCHILA, POKEDEX
-- TODO: Quando o mapa for criado, corrigir NPCs e Professor

-- Treinador
INSERT INTO treinador (nome, nivel, dinheiro, insignia, id_posicao, id_professor) VALUES ('Ash Ketchum', 0, 0.00, 'iniciante', 1, 1);

-- Professor
INSERT INTO npc (nome, fala, profissao, id_posicao) VALUES 
('Professor Oak','Olá treinador!! Bem vindo a sua jornada, escolha um pokemon e comece sua aventura!', 'professor', 0),
('Vendedor June','Bem vindo a minha lojinha! Fique avontade!!', 'vendedor', 0),
('Vendedora May','Ei muleque, não toque em nada que não vá pagar!!', 'vendedor', 0),
('Vendedor July','Olá treinador!! Bem vindo a sua jornada, escolha um pokemon e comece sua aventura!', 'vendedor', 0),
('Vendedora April','Olá treinador!! Bem vindo a sua jornada, escolha um pokemon e comece sua aventura!', 'vendedor', 0),
('Aventureiro Jonas','Fazem alguns meses desde que sai da minha cidade natal para minha jornada, é um pouco solitário mas é uma experiência incrível', 'aventureiro', 0),
('BugCatcher April','Insetos!! Insetos!! Procuro apenas pokemons Insetos!!', 'bugcatcher', 0);

-- Mochila
INSERT INTO mochila (id, capacidade, dinheiro_maximo) VALUES ('Ash Ketchum', 50, 500.00);

-- Pokedex
INSERT INTO pokedex (id) VALUES ('Ash Ketchum');




