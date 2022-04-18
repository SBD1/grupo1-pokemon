--- Exemplo de transaction para venda de item
BEGIN;
CALL vende_item(1, 'Ash Ketchum', 1);
COMMIT;

BEGIN
CALL evoluir_pokemon_com_item(1, 133, 1,15);
COMMIT;