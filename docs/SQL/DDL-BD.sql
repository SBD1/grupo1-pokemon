CREATE DOMAIN moeda AS DECIMAL(7,2) NOT NULL CHECK(VALUE >= 0);

CREATE DOMAIN taxa_captura AS DECIMAL(3,2) NOT NULL CHECK(VALUE > 0 AND VALUE <= 1);

CREATE DOMAIN nome AS VARCHAR(50) NOT NULL;

CREATE TABLE mapa(
    id SERIAL,
    CONSTRAINT mapa_pk PRIMARY KEY(id)
);

CREATE TABLE regiao(
    id SERIAL,
    entrada INT NOT NULL,
    id_mapa INT NOT NULL,
    CONSTRAINT regiao_pk PRIMARY KEY(id),
    CONSTRAINT id_mapa_regiao_fk FOREIGN KEY(id_mapa) REFERENCES mapa(id)
);

CREATE TABLE posicao(
    id SERIAL,
    id_regiao INT NOT NULL,
    norte INT,
    sul INT,
    leste INT,
    oeste INT,
    cima INT,
    baixo INT,
    CONSTRAINT posicao_pk PRIMARY KEY(id),
    CONSTRAINT id_regiao_posicao_fk FOREIGN KEY(id_regiao) REFERENCES regiao(id),
    CONSTRAINT norte_posicao_fk FOREIGN KEY(norte) REFERENCES posicao(id),
    CONSTRAINT sul_posicao_fk FOREIGN KEY(sul) REFERENCES posicao(id),
    CONSTRAINT leste_posicao_fk FOREIGN KEY(leste) REFERENCES posicao(id),
    CONSTRAINT oeste_posicao_fk FOREIGN KEY(oeste) REFERENCES posicao(id),
    CONSTRAINT cima_posicao_fk FOREIGN KEY(cima) REFERENCES posicao(id),
    CONSTRAINT baixo_posicao_fk FOREIGN KEY(baixo) REFERENCES posicao(id)
);

CREATE TABLE elemento(
    id SERIAL,
    nome nome CHECK(nome IN('fogo', 'água', 'grama', 'voador', 'lutador', 'veneno', 'elétrico', 'terra', 'pedra', 'psíquico', 'gelo', 'inseto', 'fantasma', 'ferro', 'dragão', 'sombrio', 'fada', 'normal')),
    CONSTRAINT elemento_pk PRIMARY KEY(id),
    CONSTRAINT nome_elemento_sk UNIQUE(nome)
);

CREATE TABLE regiao_possui_elemento(
    id_regiao INT,
    id_elemento INT,
    CONSTRAINT regiao_possui_elemento_pk PRIMARY KEY(id_regiao, id_elemento),
    CONSTRAINT id_regiao_regiao_possui_elemento_fk FOREIGN KEY(id_regiao) REFERENCES regiao(id),
    CONSTRAINT id_elemento_regiao_possui_elemento_fk FOREIGN KEY(id_elemento) REFERENCES elemento(id)
);

CREATE TABLE npc(
    id SERIAL,
    nome nome,
    fala varchar(200) NOT NULL, --- NPC terá apenas uma fala? Sim
    profissao nome, --- CHECK(profissao IN('professor', 'vendedor')), a relação é Parcial, então podem existir outras profissões
    id_posicao INT NOT NULL,
    CONSTRAINT npc_pk PRIMARY KEY(id),
    CONSTRAINT id_posicao_npc_fk FOREIGN KEY(id_posicao) REFERENCES posicao(id)
);

CREATE TABLE treinador(
    nome nome,
    nivel INT NOT NULL CHECK(nivel >= 0),
    dinheiro moeda DEFAULT 0,
    insignia varchar(20) CHECK(insignia IN('iniciante', 'aprendiz', 'profissional', 'mestre')),
    id_posicao INT NOT NULL,
    id_professor INT NOT NULL,
    CONSTRAINT treinador_pk PRIMARY KEY(nome),
    CONSTRAINT id_posicao_treinador_fk FOREIGN KEY(id_posicao) REFERENCES posicao(id),
    CONSTRAINT id_professor_treinador_fk FOREIGN KEY(id_professor) REFERENCES npc(id)
    --- É possível criar uma restrição para que o professor seja uma NPC com profissão == professor?
    -- https://stackoverflow.com/questions/53769118/check-atribute-value-from-another-table-using-a-foreign-key-in-table-creation
);

CREATE TABLE mochila(
    id nome,
    capacidade INT NOT NULL,
    dinheiro_maximo moeda,
    CONSTRAINT mochila_pk PRIMARY KEY(id),
    CONSTRAINT id_treinador_fk FOREIGN KEY(id) REFERENCES treinador(nome)
);

CREATE TABLE pokedex(
    id nome,
    CONSTRAINT pokedex_pk PRIMARY KEY(id),
    CONSTRAINT id_treinador_fk FOREIGN KEY(id) REFERENCES treinador(nome)
);

CREATE TABLE especializacao_do_item(
    id_item SERIAL,
    papel varchar(10) NOT NULL CHECK(papel IN('evostone', 'berry', 'candy', 'pokebola')), -- A gente podia substituir esses textos por iniciais, não? Só pra ocupar menos caractere no banco (menos memória).
    CONSTRAINT especializacao_do_item_pk PRIMARY KEY(id_item)
);

CREATE TABLE candy(
    id INT,
    nome nome,
    preco moeda,
    aumento_experiencia INT NOT NULL,
    CONSTRAINT candy_pk PRIMARY KEY(id),
    CONSTRAINT nome_candy_sk UNIQUE(nome),
    CONSTRAINT id_item_fk FOREIGN KEY(id) REFERENCES especializacao_do_item(id_item)
);

CREATE TABLE berry(
    id INT,
    nome nome,
    preco moeda,
    aumento_taxa_captura taxa_captura,
    CONSTRAINT berry_pk PRIMARY KEY(id),
    CONSTRAINT nome_berry_sk UNIQUE(nome),
    CONSTRAINT id_item_fk FOREIGN KEY(id) REFERENCES especializacao_do_item(id_item)
);

CREATE TABLE evostone(
    id INT,
    nome nome,
    preco moeda,
    id_elemento INT NOT NULL,
    CONSTRAINT evostone_pk PRIMARY KEY(id),
    CONSTRAINT nome_evostone_sk UNIQUE(nome),
    CONSTRAINT id_elemento_evostone_fk FOREIGN KEY(id_elemento) REFERENCES elemento(id),
    CONSTRAINT id_item_fk FOREIGN KEY(id) REFERENCES especializacao_do_item(id_item)
);

CREATE TABLE pokebola(
    id INT,
    nome nome CHECK(nome IN('Pokeball', 'Great Ball', 'Ultra Ball', 'Master Ball')),
    preco moeda,

    CONSTRAINT pokebola_pk PRIMARY KEY(id),
    CONSTRAINT nome_pokebola_sk UNIQUE(nome),
    CONSTRAINT id_item_fk FOREIGN KEY(id) REFERENCES especializacao_do_item(id_item)
);

CREATE TABLE instancia_item(
    id SERIAL,
    id_item INT NOT NULL,
    CONSTRAINT instancia_item_pk PRIMARY KEY(id),
    CONSTRAINT id_item_instancia_item_fk FOREIGN KEY(id_item) REFERENCES especializacao_do_item(id_item)
);

CREATE TABLE instancia_item_posicao(
    id_posicao INT NOT NULL,
    id_instancia_item INT, -- Isso aqui pode ser nulo? Um item sem posição não precisa de uma linha nesta tabela, não?
    CONSTRAINT instancia_item_posicao_pk PRIMARY KEY(id_posicao),
    CONSTRAINT instancia_item_posicao_sk UNIQUE(id_instancia_item),
    CONSTRAINT id_posicao_instancia_item_posicao_fk FOREIGN KEY(id_posicao) REFERENCES posicao(id),
    CONSTRAINT id_instancia_instancia_item_posicao_fk FOREIGN KEY(id_instancia_item) REFERENCES instancia_item(id)
);

CREATE TABLE npc_guarda_instancia_de_item(
    id_npc INT NOT NULL,
    id_instancia_item INT, -- Um item sem NPC não precisa de linha aqui, não?
    CONSTRAINT npc_guarda_instancia_de_item_pk PRIMARY KEY(id_npc, id_instancia_item), -- Se id_instancia_item faz parte de PK, ele nunca vai ser nulo, não?
    CONSTRAINT id_npc_npc_guarda_instancia_de_item_fk FOREIGN KEY(id_npc) REFERENCES npc(id),
    CONSTRAINT id_instancia_item_npc_guarda_instancia_de_item_fk FOREIGN KEY(id_instancia_item) REFERENCES instancia_item(id)
);

CREATE TABLE mochila_guarda_instancia_de_item(
    id_mochila nome NOT NULL,
    id_instancia_item INT, -- Um item sem mochila não precisaria estar aqui, não?
    CONSTRAINT mochila_guarda_instancia_de_item_pk PRIMARY KEY(id_instancia_item),
    CONSTRAINT id_mochila_mochila_guarda_instancia_de_item_fk FOREIGN KEY(id_mochila) REFERENCES mochila(id),
    CONSTRAINT id_instancia_item_mochila_guarda_instancia_de_item_fk FOREIGN KEY(id_instancia_item) REFERENCES instancia_item(id)
);

CREATE TABLE pokemon(
    id SERIAL,
    especie varchar(50) NOT NULL,
    tamanho DECIMAL(6,2) NOT NULL,
    peso DECIMAL(6,2) NOT NULL,
    descricao varchar(999) NOT NULL,
    elemento1 INT NOT NULL,
    taxa_captura taxa_captura,
    elemento2 INT,
    CONSTRAINT pokemon_pk PRIMARY KEY(id),
    CONSTRAINT especie_pokemon_sk UNIQUE(especie),
    CONSTRAINT elemento1_pokemon_fk FOREIGN KEY(elemento1) REFERENCES elemento(id),
    CONSTRAINT elemento2_pokemon_fk FOREIGN KEY(elemento2) REFERENCES elemento(id)
    --Adicionar imagem posteriormente em uma tabela intermediária--
);

CREATE TABLE pokemon_evolucao(
    pokemon_id INT,
    evolucao_id INT,
    experiencia_evoluir INT,
    necessita_de_item BOOLEAN DEFAULT false,
    CONSTRAINT pokemon_evolucao_pk PRIMARY KEY(pokemon_id, evolucao_id),
    CONSTRAINT pokemon_id_pokemon_evolucao_fk FOREIGN KEY(pokemon_id) REFERENCES pokemon(id),
    CONSTRAINT evolucao_id_pokemon_evolucao_fk FOREIGN KEY(evolucao_id) REFERENCES pokemon(id)
);

CREATE TABLE pokemon_evolucao_item(
    pokemon_id INT,
    evolucao_id INT,
    item_id INT,
    CONSTRAINT pokemon_evolucao_item_pk PRIMARY KEY(pokemon_id, evolucao_id),
    CONSTRAINT pokemon_id_pokemon_evolucao_item_fk FOREIGN KEY(pokemon_id) REFERENCES pokemon(id),
    CONSTRAINT evolucao_id_pokemon_evolucao_item_fk FOREIGN KEY(evolucao_id) REFERENCES pokemon(id),
    CONSTRAINT item_id_pokemon_evolucao_item_fk FOREIGN KEY(item_id) REFERENCES instancia_item(id)
);

CREATE TABLE instancia_pokemon(
    id SERIAL,
    id_pokemon INT NOT NULL,
    experiencia INT NOT NULL,
    genero CHAR(1) CHECK(genero IN('M', 'F')),

    CONSTRAINT instancia_pokemon_pk PRIMARY KEY(id),
    CONSTRAINT id_pokemon_instancia_pokemon_fk FOREIGN KEY(id_pokemon) REFERENCES pokemon(id)
);

CREATE TABLE instancia_pokemon_posicao(
    id_posicao INT,
    id_instancia_pokemon INT,
    CONSTRAINT instancia_pokemon_posicao_pk PRIMARY KEY(id_posicao),
    CONSTRAINT instancia_pokemon_posicao_sk UNIQUE(id_instancia_pokemon),
    CONSTRAINT id_posicao_instancia_pokemon_posicao_fk FOREIGN KEY(id_posicao) REFERENCES posicao(id),
    CONSTRAINT id_instancia_pokemon_instancia_pokemon_posicao_fk FOREIGN KEY(id_instancia_pokemon) REFERENCES instancia_pokemon(id)
);

CREATE TABLE registra(
    id_pokemon INT,
    id_pokedex nome,
    qtd_vista INT DEFAULT 0 NOT NULL,
    qtd_capturada INT DEFAULT 0 NOT NULL,

    CONSTRAINT registra_pk PRIMARY KEY(id_pokemon, id_pokedex),
    CONSTRAINT id_pokemon_registra_fk FOREIGN KEY(id_pokemon) REFERENCES pokemon(id),
    CONSTRAINT id_pokedex_registra_fk FOREIGN KEY(id_pokedex) REFERENCES pokedex(id)
);

CREATE TABLE vende(
    id_instancia_item INT,
    treinador nome, --Pode ser NULL? Sem venda não deveria estar aqui, não?
    id_npc INT NOT NULL,
    CONSTRAINT vende_pk PRIMARY KEY(id_instancia_item),
    CONSTRAINT treinador_vende_fk FOREIGN KEY(treinador) REFERENCES treinador(nome),
    CONSTRAINT id_npc_vende_fk FOREIGN KEY(id_npc) REFERENCES npc(id)
);

CREATE TABLE captura(
    id SERIAL,
    id_instancia_pokemon INT,
    id_treinador nome,
    CONSTRAINT captura_pk PRIMARY KEY(id),
    CONSTRAINT captura_sk UNIQUE(id_instancia_pokemon, id_treinador),
    CONSTRAINT id_instancia_pokemon_captura_fk FOREIGN KEY(id_instancia_pokemon) REFERENCES instancia_pokemon(id),
    CONSTRAINT id_treinador_captura_fk FOREIGN KEY(id_treinador) REFERENCES treinador(nome)
);

CREATE TABLE evento_captura(
    id_instancia_pokemon INT,
    id_pokebola INT,
    CONSTRAINT evento_captura_pk PRIMARY KEY(id_instancia_pokemon),
    CONSTRAINT id_instancia_pokemon_evento_captura_fk FOREIGN KEY(id_instancia_pokemon) REFERENCES instancia_pokemon(id),
    CONSTRAINT id_pokebola_evento_captura_fk FOREIGN KEY(id_pokebola) REFERENCES pokebola(id)
);
