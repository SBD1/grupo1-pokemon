\c pokemon

--- Atributo derivado Nível da Entidade Instância Pokemon
CREATE OR REPLACE FUNCTION get_instancia_pokemon_nivel(_id INTEGER)
  RETURNS INTEGER AS $$
BEGIN
  RETURN (SELECT experiencia FROM instancia_pokemon WHERE id=_id) / 100;
END;
$$ LANGUAGE plpgsql;


-- Função que retorna o id do item a partir do id da intância
CREATE OR REPLACE FUNCTION get_id_item (id_instancia INTEGER)
  RETURNS INTEGER AS $$
BEGIN
  RETURN (SELECT id_item FROM instancia_item WHERE id=id_instancia);
END;
$$ LANGUAGE plpgsql;


-- Função que retorna o papel do item a partir do id dele
CREATE OR REPLACE FUNCTION get_papel_item (_id_item INTEGER)
  RETURNS VARCHAR(10) AS $$
BEGIN
  RETURN (SELECT papel FROM especializacao_do_item WHERE id_item=_id_item);
END;
$$ LANGUAGE plpgsql;

-- Função que retorna o preço do item a partir do id dele
CREATE OR REPLACE FUNCTION get_preco_item (_id_item INTEGER, tabela regclass)
  RETURNS SETOF moeda AS $func$
BEGIN
  RETURN QUERY EXECUTE 'SELECT preco FROM ' || tabela || ' WHERE id=' || _id_item;
END;
$func$ LANGUAGE plpgsql;


-- Procedure para vender um item, deve ser usada dentro de uma Transaction
CREATE OR REPLACE PROCEDURE vende_item(id_instancia INTEGER, _nome_treinador nome, id_npc INTEGER)
  AS $$

	DECLARE
		_id_item INTEGER;
		_papel_item VARCHAR(10);
		_preco_item moeda DEFAULT 0;

  BEGIN
		_id_item = get_id_item(id_instancia);
		_papel_item = get_papel_item(_id_item);
		_preco_item = get_preco_item(_id_item, _papel_item);
    
    -- raise notice '_id_item: % %', _id_item, E'\n';
    -- raise notice '_papel_item: % %', _papel_item, E'\n';
    -- raise notice '_preco_item: % %', _preco_item, E'\n';

    INSERT INTO vende (treinador, id_instancia_item, id_npc) VALUES
    (_nome_treinador, id_instancia, id_npc);

    INSERT INTO mochila_guarda_instancia_de_item (id_mochila, id_instancia_item) VALUES
    (_nome_treinador, id_instancia);

    -- raise notice 'dinheiro atual: % %', (SELECT dinheiro FROM treinador WHERE nome = _nome_treinador), E'\n';
    -- raise notice 'dinheiro pós compra: % %', (SELECT dinheiro FROM treinador WHERE nome = _nome_treinador) - _preco_item, E'\n';

    UPDATE treinador
      SET dinheiro = dinheiro - _preco_item
      WHERE nome = _nome_treinador;

    DELETE FROM npc_guarda_instancia_de_item
      WHERE id_instancia_item = id_instancia;
	END;
$$ LANGUAGE plpgsql;


--- Atributo derivado Descrição Visível da Entidade Registra
CREATE OR REPLACE FUNCTION get_registra_descricao_visivel(_id_pokemon INTEGER)
  RETURNS VARCHAR(1500) AS $$
DECLARE
  _pokemon_name VARCHAR(50);
  _pokemon_descricao VARCHAR(999);
  _elemento1 INTEGER;
  _elemento2 INTEGER;
  _output VARCHAR(1500);
  _pokemon_evolucao INTEGER[];
BEGIN
  SELECT INITCAP(especie), descricao, elemento1, elemento2 
    INTO _pokemon_name, _pokemon_descricao, _elemento1, _elemento2 
  FROM pokemon WHERE id=_id_pokemon;

  -- raise notice 'pokemon_name: % %', _pokemon_name, E'\n';
  -- raise notice 'pokemon_descricao: % %', _pokemon_descricao, E'\n';
  -- raise notice 'elementos: % | % %', _elemento1, _elemento2, E'\n';

  _output := CONCAT(
    _pokemon_name, E'\n', _pokemon_descricao, E'\n',
    'Element(s): ', (SELECT INITCAP(nome) FROM elemento WHERE id=_elemento1)
  );

  IF _elemento2 IS NOT NULL THEN
    _output := CONCAT(
      _output, ', ', (SELECT INITCAP(nome) FROM elemento WHERE id=_elemento2)
    );
  END IF;
  _output := CONCAT(_output, E'\n');

  _pokemon_evolucao := ARRAY(SELECT evolucao_id FROM pokemon_evolucao WHERE pokemon_id = _id_pokemon);
  -- raise notice 'evolucao: % %', _pokemon_evolucao, E'\n'; 
  
  IF ARRAY_LENGTH(_pokemon_evolucao, 1) > 0 THEN
    _output := CONCAT(_output, 'Evolution(s):');
    FOR i IN 1..ARRAY_LENGTH(_pokemon_evolucao, 1) LOOP
      -- raise notice 'i %, _pokemon_evolucao[i] % %', i, _pokemon_evolucao[i], E'\n';
      _output := CONCAT(
        _output, ' ',
        (SELECT INITCAP(especie) FROM pokemon WHERE id = _pokemon_evolucao[i])
      );
      IF i + 1 > ARRAY_LENGTH(_pokemon_evolucao, 1) THEN
        _output := CONCAT(_output, E'\n');
      ELSE
        _output := CONCAT(_output, ',');
      END IF;
    END LOOP;
    _output := CONCAT(_output, E'\n');
  END IF;
  RETURN _output;
END;
$$ LANGUAGE plpgsql;


--- Atributo derivado Nro de Pokemons Vistos da Entidade Pokedex
CREATE OR REPLACE FUNCTION get_pokedex_nro_pokemons_vistos(_id nome)
  RETURNS INTEGER AS $$
BEGIN
  RETURN (SELECT COUNT(*) FROM registra WHERE id_pokedex = _id);
END;
$$ LANGUAGE plpgsql;


--- Atributo derivado Nro de Pokemons Capturados da Entidade Pokedex
CREATE OR REPLACE FUNCTION get_pokedex_nro_pokemons_capturados(_id nome)
  RETURNS INTEGER AS $$
BEGIN
  RETURN (SELECT COUNT(*) FROM captura WHERE id_treinador = _id);
END;
$$ LANGUAGE plpgsql;


--- Atributo posição do treinador
CREATE OR REPLACE FUNCTION get_player_position(_id nome)
  RETURNS INTEGER AS $$
BEGIN
  RETURN (SELECT id_posicao FROM treinador WHERE nome = _id);
END;
$$ LANGUAGE plpgsql;


--- Validar a passagem para nova regiao
CREATE OR REPLACE FUNCTION valid_region_change(_id_posicao INTEGER, _id_treinador nome)
  RETURNS INTEGER AS $$
DECLARE
  _entrada INTEGER;
  _output INTEGER;
  _pokemons_count INTEGER;
BEGIN
  _entrada := (SELECT r.entrada FROM regiao r WHERE r.id = (SELECT p.id_regiao FROM posicao p WHERE p.id = _id_posicao));
  IF _entrada = 0 THEN
    _output := 1;
  ELSE
    _pokemons_count := (SELECT COUNT(*) FROM captura WHERE id_treinador = _id_treinador);
    IF _pokemons_count >= _entrada THEN
      _output := 1;
    ELSE
      _output := 0;
    END IF;
  END IF;
  RETURN _output;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_possiveis_evolucoes(_id_pokemon INTEGER, _id_item INTEGER)
  RETURNS INTEGER AS $$
BEGIN
  RETURN (SELECT COUNT(*) FROM pokemon_evolucao_item WHERE pokemon_id = _id_pokemon and item_id = _id_item);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_evolucao_id(_id_pokemon INTEGER, _id_item INTEGER)
  RETURNS INTEGER AS $$
BEGIN
  RETURN (SELECT evolucao_id FROM pokemon_evolucao_item WHERE pokemon_id = _id_pokemon and item_id = _id_item);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE evoluir_pokemon_com_item(id_instancia_pokemon INTEGER, id_pokemon INTEGER, id_item INTEGER, _id_instancia_item INTEGER)
  AS $$

	DECLARE
    _evolucoes_count INTEGER;
    _pokemon_evolucao_id INTEGER;

  BEGIN
    _evolucoes_count = get_possiveis_evolucoes(id_pokemon, id_item);
    _pokemon_evolucao_id = get_evolucao_id(id_pokemon, id_item);
    IF _evolucoes_count != 0 THEN
      UPDATE instancia_pokemon
      SET id_pokemon = _pokemon_evolucao_id
      WHERE id = id_instancia_pokemon;
      DELETE FROM mochila_guarda_instancia_de_item as m
      WHERE m.id_instancia_item = _id_instancia_item;
    ELSE
      RAISE EXCEPTION 'Pokemon não evolui usando esse item --> %', id_pokemon
      USING HINT = 'Opa, você não pode utilizar esse item nesse pokémon';
    END IF;
  
	END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_candy_id(id_instancia INTEGER)
  RETURNS INTEGER AS $$
BEGIN
  RETURN (SELECT id_item FROM instancia_item WHERE id = id_instancia);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_candy_xp(candy_id INTEGER)
  RETURNS INTEGER AS $$
BEGIN
  RETURN (SELECT aumento_experiencia FROM candy WHERE id = candy_id);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE usar_candy_pokemon(id_instancia_pokemon INTEGER, _id_instancia_item INTEGER)
  AS $$
	DECLARE
  aumento_de_xp INTEGER;
  id_item INTEGER;
  BEGIN

    id_item = get_candy_id(_id_instancia_item);
    aumento_de_xp = get_candy_xp(id_item);
    UPDATE instancia_pokemon
    SET experiencia = experiencia + aumento_de_xp
    WHERE id = id_instancia_pokemon;

    DELETE FROM mochila_guarda_instancia_de_item as m
    WHERE m.id_instancia_item = _id_instancia_item;

	END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE pegar_item_do_chao(_id_instancia_item INTEGER, _nome_treinador nome)
  AS $$
  BEGIN
    DELETE FROM instancia_item_posicao
    where id_instancia_item = _id_instancia_item;

    INSERT INTO mochila_guarda_instancia_de_item (id_mochila, id_instancia_item)
    VALUES  (_nome_treinador, _id_instancia_item);

  END;
$$ LANGUAGE plpgsql;


--- Conferir se um item existe
CREATE OR REPLACE FUNCTION check_item_exists(_id_instancia_item INTEGER)
  RETURNS BOOLEAN AS $$
BEGIN
  RETURN (SELECT count(*) FROM instancia_item WHERE id = _id_instancia_item);
END;
$$ LANGUAGE plpgsql;

--- Conferir se um pokemon existe
CREATE OR REPLACE FUNCTION check_pokemon_exists(_id_instancia_pokemon INTEGER)
  RETURNS BOOLEAN AS $$
BEGIN
  RETURN (SELECT count(*) FROM instancia_pokemon WHERE id = _id_instancia_pokemon);
END;
$$ LANGUAGE plpgsql;

--- Conferir se possui o item na mochila
CREATE OR REPLACE FUNCTION check_backpack_has_item(_id_mochila nome, _id_instancia_item INTEGER)
  RETURNS BOOLEAN AS $$
BEGIN
  RETURN (SELECT count(*) FROM mochila_guarda_instancia_de_item WHERE id_instancia_item=_id_instancia_item and id_mochila=_id_mochila);
END;
$$ LANGUAGE plpgsql;

--- Taxa de captura da pokebola
CREATE OR REPLACE FUNCTION get_pokeball_catch_rate(_id INTEGER)
  RETURNS DECIMAL(2,1) AS $$
DECLARE
  _nome nome DEFAULT '';
BEGIN
  SELECT nome INTO _nome FROM pokebola WHERE id=_id;
  RETURN 
    (CASE WHEN _nome = 'Great Ball'  THEN 1.5
      WHEN _nome = 'Ultra Ball' THEN 2.0
      WHEN _nome = 'Master Ball' THEN 100.0
      ELSE 1.0
    END);  
END;
$$ LANGUAGE plpgsql;


--- TRIGGERS ---

CREATE OR REPLACE FUNCTION verificar_evolucao_pokemon() RETURNS trigger AS $verificar_evolucao_pokemon$
    DECLARE
        info_evolucao pokemon_evolucao%ROWTYPE;
    BEGIN
        SELECT * INTO info_evolucao FROM pokemon_evolucao as p WHERE p.pokemon_id = new.id_pokemon;
        IF(new.experiencia >= info_evolucao.experiencia_evoluir AND info_evolucao.necessita_de_item <> true) THEN
            new.id_pokemon = info_evolucao.evolucao_id;
        END IF;
        return new;
    END;

$verificar_evolucao_pokemon$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_verificar_evolucao_pokemon ON instancia_pokemon;
CREATE TRIGGER trigger_verificar_evolucao_pokemon
BEFORE UPDATE OF experiencia ON instancia_pokemon
FOR EACH ROW
EXECUTE FUNCTION verificar_evolucao_pokemon();


CREATE OR REPLACE FUNCTION verificar_limite_mochila() RETURNS trigger AS $verificar_limite_mochila$
    DECLARE
        capacidade_mochila INTEGER;
        qnt_items_na_mochila INTEGER;
    BEGIN
        SELECT capacidade INTO capacidade_mochila FROM mochila WHERE id = NEW.id_mochila;
        SELECT COUNT(*) INTO qnt_items_na_mochila FROM mochila_guarda_instancia_de_item WHERE id_mochila = NEW.id_mochila;

        IF qnt_items_na_mochila = capacidade_mochila THEN
            RAISE EXCEPTION 'Limite máximo da mochila alcançado. Não é possível adicionar mais items.';
        END IF;
        RETURN NEW;
    END;
$verificar_limite_mochila$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS  trigger_verificar_limite_mochila ON mochila_guarda_instancia_de_item;
CREATE TRIGGER trigger_verificar_limite_mochila
BEFORE INSERT ON mochila_guarda_instancia_de_item
FOR EACH ROW
EXECUTE FUNCTION verificar_limite_mochila();


CREATE OR REPLACE FUNCTION verificar_id_professor_treinador() RETURNS trigger AS $verificar_id_professor_treinador$
    DECLARE
        profissao_npc nome DEFAULT '';
    BEGIN
        SELECT profissao INTO profissao_npc FROM npc WHERE id = NEW.id_professor;
        IF LOWER(profissao_npc) <> 'professor' THEN
            RAISE EXCEPTION 'Somente NPCs com a profissão de professor podem ser adicionados no campo "id_professor".';
        END IF;
        RETURN NEW;
    END;
$verificar_id_professor_treinador$ LANGUAGE plpgsql;

DROP TRIGGER  IF EXISTS  trigger_verificar_id_professor_treinador ON treinador;
CREATE TRIGGER trigger_verificar_id_professor_treinador
BEFORE INSERT OR UPDATE ON treinador
FOR EACH ROW
EXECUTE FUNCTION verificar_id_professor_treinador();



CREATE OR REPLACE FUNCTION verificar_id_npc_vendedor() RETURNS trigger AS $verificar_id_npc_vendedor$
    DECLARE
        profissao_npc nome DEFAULT '';
    BEGIN
        SELECT profissao INTO profissao_npc FROM npc WHERE id = NEW.id_npc;
        IF LOWER(profissao_npc) <> 'vendedor' THEN
            RAISE EXCEPTION 'Somente NPCs com a profissão de vendedor podem ser adicionados nas tabelas de vende e de npc_guarda_instancia_de_item.';
        END IF;
        RETURN NEW;
    END;
$verificar_id_npc_vendedor$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_verificar_id_npc_vendedor ON vende;

CREATE TRIGGER trigger_verificar_id_npc_vendedor
BEFORE INSERT OR UPDATE ON vende
FOR EACH ROW
EXECUTE FUNCTION verificar_id_npc_vendedor();

DROP TRIGGER IF EXISTS trigger_verificar_id_npc_vendedor ON npc_guarda_instancia_de_item;

CREATE TRIGGER trigger_verificar_id_npc_vendedor
BEFORE INSERT OR UPDATE ON npc_guarda_instancia_de_item
FOR EACH ROW
EXECUTE FUNCTION verificar_id_npc_vendedor();
