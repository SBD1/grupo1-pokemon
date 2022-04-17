CREATE OR REPLACE FUNCTION verificar_evolucao_pokemon() RETURNS trigger AS $verificar_evolucao_pokemon$
    DECLARE
        info_evolucao pokemon_evolucao%ROWTYPE;
    BEGIN
        SELECT * INTO info_evolucao FROM pokemon_evolucao as p WHERE p.pokemon_id = new.id_pokemon;
        IF(new.experiencia >= info_evolucao.experiencia_evoluir) THEN
            new.id_pokemon = info_evolucao.evolucao_id;
            return new;
        END IF;
        RETURN NULL;
    END;

$verificar_evolucao_pokemon$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_evolucao_pokemon
BEFORE UPDATE OF experiencia ON instancia_pokemon
FOR EACH ROW
EXECUTE FUNCTION verificar_evolucao_pokemon();