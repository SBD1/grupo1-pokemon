# Modelo Relacional Normalizado

|    Data    | Versão | Descrição | Autor |
| :---: | :----: | :---: | :---: |
| 28/02/2022 | 0.1 | Adição MREL 0.1 | [Iuri Severo](https://github.com/iurisevero), [Victor Buendia](https://github.com/Victor-Buendia), [João Pedro José](https://github.com/sudjoao) e [Arthur Matos](https://github.com/Arthur-Gaudium) |

## O que é?

A normalização é o processo de organização de dados em um banco de dados. Onde, de acordo com regras pré estabelicidas, reformulamos algumas partes do Modelo Relaiconal para padronizá-lo.

## MREL Normalizado V0.1

![MREL Normalizado v0.1](../Assets/Images/MRELNormalizado/MRELNormalizado_v0.1.png)

As modificações realizadas ao normalizar o MREL foram:
- Criação de nova tabela (EvoCaptura) seguindo a Segunda Forma normal;
- Adição do atributo posição no NPC;
- Referência a chave secundária captura na pokebola.

Além disso, foi realizada uma análise, imagem abaixo, para saber se era preciso aplicar a 4 forma nominal no ternário Venda, realizado por treinador, npc e instancia de item e foi constatado que não fazia sentido.

![Analise 4FN](../Assets/Images/MRELNormalizado/Tabela4FN.png)




