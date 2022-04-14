--- Atributo derivado Nível da Entidade Instância Pokemon
CREATE OR REPLACE FUNCTION get_instancia_pokemon_nivel(_id INTEGER)
  RETURNS INTEGER AS $$
BEGIN
  RETURN (SELECT experiencia FROM instancia_pokemon WHERE id=_id) / 100;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNTION get_id_item (id_instancia INTEGER)
  RETURNS INTEGER AS $$
BEGIN
  RETURN (SELECT id_item FROM instancia_item WHERE id=id_instancia)
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNTION get_papel_item (_id_item INTEGER)
  RETURNS VARCHAR(10) AS $$
BEGIN
  RETURN (SELECT papel FROM especializacao_do_item WHERE id_item=_id_item)
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNTION get_preco_item (_id_item INTEGER, tabela TABLE)
  RETURNS moeda AS $$
BEGIN
  RETURN (SELECT preco FROM tabela WHERE id=_id_item)
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