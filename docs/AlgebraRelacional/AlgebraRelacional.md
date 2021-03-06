# Álgebra Relacional

|    Data    | Versão | Descrição | Autor |
| :---: | :----: | :---: | :---: |
| 12/04/2022 | 0.1 | Criação do documento de álgebra relacional | [Iuri Severo](https://github.com/iurisevero)

Este documento servirá para mapear os códigos referentes à Álgebra Relacional, _Triggers_, _Stored Procedures_ e _Transactions_. Esses códigos serão aplicados diretamente no jogo ou na criação do banco de dados para ao qual ele irá se referir.

Os documentos desenvolvidos no módulo 4, [SQL](../SQL/SQL.md) foram utilizados como base para toda documentação apresentada nessa página.

## Stored Procedures e Triggers

Os _Stored Procedures_ são partes do código escrito em PL/SQL para realizar alguma tarefa específica. Os _Stored Procedures_ podem ser invocados explicitamente pelo usuário. É como um programa java, ele pode receber alguma entrada como parâmetro, então pode fazer algum processamento e retornar valores.

Por outro lado, _Trigger_ é um _Stored Procedure_ que é executado automaticamente quando eventos acontecem (por exemplo, atualização, inserção, exclusão). Os _Triggers_ são mais como manipuladores de eventos que são executados no evento específico. O _Trigger_ não pode receber entrada e não pode retornar valores.

Os _Stored Procedures_ e _Triggers_ desenvolvidos pelo grupo podem ser vistos nos arquivos:
- [StoredProcedures.sql](https://raw.githubusercontent.com/SBD1/grupo1-pokemon/main/docs/AlgebraRelacional/StoredProcedures.sql)
- [Triggers.sql](https://raw.githubusercontent.com/SBD1/grupo1-pokemon/main/docs/AlgebraRelacional/Triggers.sql)

## Transactions

Uma _Transaction_ simboliza uma unidade de trabalho executada dentro de um sistema de gerenciamento de banco de dados (ou sistema similar), sobre um banco de dados, e tratada de maneira coerente e confiável, independente de outras transações.

As _Transactions_ que serão executadas no jogo podem ser vistas no arquivo [Transactions.sql](https://raw.githubusercontent.com/SBD1/grupo1-pokemon/main/docs/AlgebraRelacional/Transactions.sql).

## Outros

Por fim, foram levantadas algumas funções que serão utilizadas para realizar as mecânicas do jogo. Essas podem ser encontradas no arquivo [SQL-Mecanicas.sql](https://raw.githubusercontent.com/SBD1/grupo1-pokemon/main/docs/AlgebraRelacional/SQL-Mecanicas.sql).

# Referências
- [Difference between stored procedure and triggers in SQL](https://www.tutorialspoint.com/difference-between-stored-procedure-and-triggers-in-sql#:~:text=Stored%20procedures%20can%20be%20invoked,update%2C%20insert%2C%20delete).)
- [Transação (banco de dados)](https://pt.wikipedia.org/wiki/Transa%C3%A7%C3%A3o_(banco_de_dados))