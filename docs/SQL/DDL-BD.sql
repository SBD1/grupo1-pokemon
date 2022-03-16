create database pokemon;
CREATE SEQUENCE serie START 1;

CREATE DOMAIN moeda AS DECIMAL(7,2) CHECK(
    VALUE > 0
);

CREATE TABLE mapa(
    id serie,
    CONSTRAINT mapa_pk PRIMARY KEY(id)
);

CREATE TABLE elemento(
    id serie,
    nome varchar(20) NOT NULL CHECK (nome IN ('fogo', 'água', 'grama', 'voador', 'lutador', 'veneno', 'elétrico', 'terra', 'pedra', 'psiquico', 'gelo', 'inseto', 'fantasma', 'ferro', 'dragão', 'sombrio', 'fada')),
    CONSTRAINT elemento_pk PRIMARY KEY(id),
    CONSTRAINT nome_elemento_sk UNIQUE(nome)
);

CREATE TABLE mochila(
    id serie,
    capacidade_da_mochila INT NOT NULL,
    CONSTRAINT mochila_pk PRIMARY KEY(id)
);

CREATE TABLE pokedex(
    id serie,
    num_pokemons_capturados INT DEFAULT 0,
    num_pokemons_vistos INT DEFAULT 0,
    CONSTRAINT pokedex_pk PRIMARY KEY(id)
);

CREATE TABLE candy(
    id serie,
    nome varchar(20) NOT NULL,
    preco moeda NOT NULL,
    aumento_experiencia INT NOT NULL,
    CONSTRAINT candy_pk PRIMARY KEY(id),
    CONSTRAINT nome_candy_sk UNIQUE(nome)
);

CREATE TABLE berry(
    id serie,
    nome varchar(20) NOT NULL,
    preco moeda NOT NULL,
    aumento_taxa_captura DECIMAL(3, 2) NOT NULL CHECK(aumento_taxa_captura > 0 AND aumento_taxa_captura <=1),
    CONSTRAINT berry_pk PRIMARY KEY(id),
    CONSTRAINT nome_berry_sk UNIQUE(nome)
);

CREATE TABLE evostone(
    id serie,
    nome varchar(50),
    preco moeda NOT NULL,
    id_elemento serie NOT NULL,
    CONSTRAINT evostone_pk PRIMARY KEY(id),
    CONSTRAINT nome_evostone_sk UNIQUE(nome),
    CONSTRAINT id_elemento_evostone_fk FOREIGN KEY (id_elemento) REFERENCES elemento (id)
);


