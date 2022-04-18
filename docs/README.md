# Grupo1 - Gotta Catch 'Em All
Repositório para o desenvolvimento do projeto de Pokémon do Grupo 1, Gotta Catch 'Em All, na disciplina SBD1, com o professor Maurício Serrano.

## Time
<div class="container">
    <div class="row">
        <div class="col-sm container-img">
            <img src="https://github.com/Arthur-Gaudium.png" alt="Arthur Matos" class="img-thumbnail image">
            <div class="middle">
                <div class="text">
                    Arthur Matos <br/> 19/0010495
                </div>
            </div>
        </div>
        <div class="col-sm container-img">
            <img src="https://github.com/iurisevero.png" alt="Iuri Severo" class="img-thumbnail image">
            <div class="middle">
                <div class="text">
                    Iuri Severo <br/> 17/0145514
                </div>
            </div>
        </div>
        <div class="col-sm container-img">
            <img src="https://github.com/sudjoao.png" alt="João Pedro Guedes" class="img-thumbnail image">
            <div class="middle">
                <div class="text">
                    João Pedro Guedes <br/> 17/0013910
                </div>
            </div>
        </div>
    </div>
    <br/>
    <div class="row">
        <div class="col-sm container-img">
            <img src="https://github.com/medeiroslucas.png" alt="Lucas Medeiros" class="img-thumbnail image">
            <div class="middle">
                <div class="text">
                    Lucas Medeiros <br/>  17/0039803 
                </div>
            </div>
        </div>
        <div class="col-sm container-img">
            <img src="https://github.com/Victor-Buendia.png" alt="Victor Buendia" class="img-thumbnail image">
            <div class="middle">
                <div class="text">
                    Victor Buendia <br/> 19/0020601
                </div>
            </div>
        </div>
        <div class="col-sm container-img">
        </div>
    </div>
</div>

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