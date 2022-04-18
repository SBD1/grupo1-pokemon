--- Exemplo de transaction para venda de item
BEGIN;
CALL vende_item(1, 'Ash Ketchum', 1);
COMMIT;