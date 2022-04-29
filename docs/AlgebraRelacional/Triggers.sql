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
