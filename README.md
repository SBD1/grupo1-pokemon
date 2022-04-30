# Pokémon

## Descrição

Repositório destinado a disciplina de Sistemas de bancos de dados (SBD1)

# Alunos

| Matrícula  | Aluno             |
| ---------- | ----------------- |
| 19/0010495 | Arthur Matos      |
| 17/0145514 | Iuri Severo       |
| 17/0013910 | João Pedro Guedes |
| 17/0039803 | Lucas Medeiros    |
| 19/0020601 | Victor Buendia    |
# Link para apresentação final
https://www.youtube.com/watch?v=C9UhEnSbU2c

# Utilização do Docker

A recomendação, para correção do Módulo 5, é seguir os passos a seguir:

1. Preparação
2. Banco de Dados

## Preparação

Antes de executar qualquer comando, é importante abrir o jogo em ambiente de desenvolvimento e entrar na pasta:

  	/game

Depois, é preciso dar build e subir o container:

  	sudo docker-compose up --build

## Container

Para entrar no container do jogo e realizar alterações, execute:

  	docker-compose exec game /bin/bash

## Executável

Para executar a main do jogo e vê-lo em execução:

  	docker-compose exec game python3 main.py

## Banco de Dados

Para entrar no container do banco de dados (postgres):

  	docker-compose exec db psql -U postgres

Depois, para entrar na database do jogo, utilize:

  	\c pokemon;