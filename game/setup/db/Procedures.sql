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
  RETURN QUERY EXECUTE 'SELECT preco FROM ' || tabela || ' WHERE id=_id_item';
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