create database pokemon;
CREATE SEQUENCE serie START 1;

CREATE DOMAIN moeda AS DECIMAL(7,2) NOT NULL CHECK(VALUE >= 0);

CREATE DOMAIN taxa_captura AS DECIMAL(3,2) NOT NULL CHECK(VALUE > 0 AND VALUE <= 1);

CREATE DOMAIN nome AS VARCHAR(50) NOT NULL;

CREATE TABLE mapa(
    id serie,
    CONSTRAINT mapa_pk PRIMARY KEY(id)
);

CREATE TABLE regiao(
    id serie,
    entrada INT NOT NULL,
    id_mapa serie NOT NULL,
    CONSTRAINT regiao_pk PRIMARY KEY(id),
    CONSTRAINT id_mapa_regiao_fk FOREIGN KEY(id_mapa) REFERENCES mapa(id)
);

CREATE TABLE posicao(
    id serie,
    id_regiao serie NOT NULL,
    norte serie,
    sul serie,
    leste serie,
    oeste serie,
    cima serie,
    baixo serie,
    CONSTRAINT posicao_pk PRIMARY KEY(id),
    CONSTRAINT id_regiao_posicao_fk FOREIGN KEY(id_regiao) REFERENCES regiao(id),
    CONSTRAINT norte_posicao_fk FOREIGN KEY(norte) REFERENCES posicao(id),
    CONSTRAINT sul_posicao_fk FOREIGN KEY(sul) REFERENCES posicao(id),
    CONSTRAINT leste_posicao_fk FOREIGN KEY(leste) REFERENCES posicao(id),
    CONSTRAINT oeste_posicao_fk FOREIGN KEY(oeste) REFERENCES posicao(id),
    CONSTRAINT cima_posicao_fk FOREIGN KEY(cima) REFERENCES posicao(id),
    CONSTRAINT baixo_posicao_fk FOREIGN KEY(baixo) REFERENCES posicao(id)
);

CREATE TABLE npc(
    id serie,
    fala varchar(200) NOT NULL, --- NPC terá apenas uma fala?
    profissao varchar(10) CHECK (profissao IN ('professor', 'vendedor')),
    id_posicao serie NOT NULL,
    CONSTRAINT npc_pk PRIMARY KEY(id),
    CONSTRAINT id_posicao_npc_fk FOREIGN KEY(id_posicao) REFERENCES posicao (id)
);

CREATE TABLE treinador(
    nome nome,
    nivel INT NOT NULL CHECK(nivel >= 0),
    dinheiro moeda DEFAULT 0,
    insignia varchar(20) CHECK (insignia IN ('iniciante', 'aprendiz', 'profissional', 'mestre')),
    id_posicao serie NOT NULL,
    id_professor serie NOT NULL,
    CONSTRAINT treinador_pk PRIMARY KEY(nome),
    CONSTRAINT id_posicao_treinador_fk FOREIGN KEY(id_posicao) REFERENCES posicao (id),
    CONSTRAINT id_professor_treinador_fk FOREIGN KEY(id_professor) REFERENCES npc (id)
    --- É possível criar uma restrição para que o professor seja uma NPC com profissão == professor?
);

CREATE TABLE elemento(
    id serie,
    nome nome CHECK (nome IN ('fogo', 'água', 'grama', 'voador', 'lutador', 'veneno', 'elétrico', 'terra', 'pedra', 'psiquico', 'gelo', 'inseto', 'fantasma', 'ferro', 'dragão', 'sombrio', 'fada')),
    CONSTRAINT elemento_pk PRIMARY KEY(id),
    CONSTRAINT nome_elemento_sk UNIQUE(nome)
);

CREATE TABLE mochila(
    id nome,
    capacidade_da_mochila INT NOT NULL,
    dinheiro_maximo INT NOT NULL,
    CONSTRAINT mochila_pk PRIMARY KEY(id),
    CONSTRAINT id_treinador_fk FOREIGN KEY(id) REFERENCES treinador(nome)
);

CREATE TABLE pokedex(
    id nome,
    CONSTRAINT pokedex_pk PRIMARY KEY(id),
    CONSTRAINT id_treinador_fk FOREIGN KEY(id) REFERENCES treinador(nome)
);

CREATE TABLE candy(
    id serie,
    nome nome,
    preco moeda,
    aumento_experiencia INT NOT NULL,
    CONSTRAINT candy_pk PRIMARY KEY(id),
    CONSTRAINT nome_candy_sk UNIQUE(nome)
);

CREATE TABLE berry(
    id serie,
    nome nome,
    preco moeda,
    aumento_taxa_captura taxa_captura,
    CONSTRAINT berry_pk PRIMARY KEY(id),
    CONSTRAINT nome_berry_sk UNIQUE(nome)
);

CREATE TABLE evostone(
    id serie,
    nome nome,
    preco moeda,
    id_elemento serie NOT NULL,
    CONSTRAINT evostone_pk PRIMARY KEY(id),
    CONSTRAINT nome_evostone_sk UNIQUE(nome),
    CONSTRAINT id_elemento_evostone_fk FOREIGN KEY (id_elemento) REFERENCES elemento (id)
);

CREATE TABLE especializacao_do_item(
    id_item serie,
    papel varchar(10) NOT NULL CHECK (papel IN ('evostone', 'berry', 'candy', 'pokebola')),
    CONSTRAINT especializacao_do_item_pk PRIMARY KEY(id_item)
);

CREATE TABLE instancia_item(
    id serie,
    id_item serie NOT NULL,
    CONSTRAINT instancia_item_pk PRIMARY KEY(id),
    CONSTRAINT id_item_instancia_item_fk FOREIGN KEY (id_item) REFERENCES especializacao_do_item (id_item)
);

CREATE TABLE npc_guarda_instancia_de_item(
    id_npc serie NOT NULL,
    id_instancia_item serie,
    CONSTRAINT npc_guarda_instancia_de_item_pk PRIMARY KEY(id_npc, id_instancia_item),
    CONSTRAINT id_npc_npc_guarda_instancia_de_item_fk FOREIGN KEY(id_npc) REFERENCES npc (id),
    CONSTRAINT id_instancia_item_npc_guarda_instancia_de_item_fk FOREIGN KEY(id_instancia_item) REFERENCES instancia_item (id)
);

CREATE TABLE mochila_guarda_instancia_de_item(
    id_mochila nome NOT NULL,
    id_instancia_item serie,
    CONSTRAINT mochila_guarda_instancia_de_item_pk PRIMARY KEY(id_instancia_item),
    CONSTRAINT id_mochila_mochila_guarda_instancia_de_item_fk FOREIGN KEY(id_mochila) REFERENCES mochila (id),
    CONSTRAINT id_instancia_item_mochila_guarda_instancia_de_item_fk FOREIGN KEY(id_instancia_item) REFERENCES instancia_item (id)
);

CREATE TABLE instancia_item_posicao(
    id_posicao serie NOT NULL,
    id_instancia_item serie,
    CONSTRAINT instancia_item_posicao_pk PRIMARY KEY(id_posicao),
    CONSTRAINT instancia_item_posicao_sk UNIQUE(id_instancia_item),
    CONSTRAINT id_posicao_instancia_item_posicao_fk FOREIGN KEY(id_posicao) REFERENCES posicao (id),
    CONSTRAINT id_instancia_instancia_item_posicao_fk FOREIGN KEY(id_instancia_item) REFERENCES instancia_item (id)
);

CREATE TABLE pokemon(
    id serie,
    especie varchar(50) NOT NULL,
    experiencia_evoluir INT,
    tamanho DECIMAL(6,2) NOT NULL,
    peso DECIMAL(6,2) NOT NULL,
    descricao varchar(999) NOT NULL,
    id_evolucao serie,
    elemento1 serie NOT NULL,
    taxa_captura taxa_captura,
    elemento2 serie,
    CONSTRAINT pokemon_pk PRIMARY KEY(id),
    CONSTRAINT especie_pokemon_sk UNIQUE(especie),
    CONSTRAINT id_evolucao_pokemon_fk FOREIGN KEY(id_evolucao) REFERENCES pokemon(id),
    CONSTRAINT elemento1_pokemon_fk FOREIGN KEY(elemento1) REFERENCES elemento(id),
    CONSTRAINT elemento2_pokemon_fk FOREIGN KEY(elemento2) REFERENCES elemento(id)
    --Adicionar imagem posteriormente--
);

CREATE TABLE instancia_pokemon(
    id serie,
    id_pokemon serie NOT NULL,
    experiencia INT NOT NULL,
    genero CHAR(1) CHECK(genero IN ('M', 'F')),

    CONSTRAINT instancia_pokemon_pk PRIMARY KEY(id),
    CONSTRAINT id_pokemon_instancia_pokemon_fk FOREIGN KEY(id_pokemon) REFERENCES pokemon(id)
);

CREATE TABLE registra(
    id_pokemon serie,
    id_pokedex nome,
    qtd_vista INT DEFAULT 0 NOT NULL,
    qtd_capturada INT DEFAULT 0 NOT NULL,

    CONSTRAINT registra_pk PRIMARY KEY(id_pokemon, id_pokedex),
    CONSTRAINT id_pokemon_registra_fk FOREIGN KEY(id_pokemon) REFERENCES pokemon(id),
    CONSTRAINT id_pokedex_registra_fk FOREIGN KEY(id_pokedex) REFERENCES pokedex(id)
);

CREATE TABLE pokebola(
    id serie,
    preco moeda,
    nome nome CHECK(nome IN ('Pokeball', 'Great Ball', 'Ultra Ball', 'Master Ball')),
    id_captura serie,

    CONSTRAINT pokebola_pk PRIMARY KEY(id)
    -- CONSTRAINT id_captura_pokebola_fk FOREIGN KEY(id_captura) REFERENCES captura(id)
);

CREATE TABLE vende(
    id_instancia_item serie,
    treinador nome,
    id_npc serie NOT NULL,
    CONSTRAINT vende_pk PRIMARY KEY(id_instancia_item),
    CONSTRAINT treinador_vende_fk FOREIGN KEY(treinador) REFERENCES treinador (nome),
    CONSTRAINT id_npc_vende_fk FOREIGN KEY(id_npc) REFERENCES npc (id)
);
