SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

BEGIN 
	DECLARE -- Falta ajeitar aqui o _id_treinador, id_instancia e testar se _preco_item vem certo
		_id_item = get_id_item(id_instancia); -- ! id_instancia
		_papel_item = get_papel_item(_id_item);
		_preco_item = get_preco_item(_id_item, _papel_item);
		_nome_treinador = (SELECT nome FROM treinador WHERE id = id_treinador); -- ! id_treinador

INSERT INTO vende (treinador, id_instancia_item, id_npc) VALUES
	(_nome_treinador, id_instancia, id_npc); -- ! id_npc, id_instancia, _nome_treinador

INSERT INTO mochila_guarda_instancia_de_item (id_mochila, id_instancia_item) VALUES
	(_id_mochila, id_instancia); -- ! id_instancia

UPDATE treinador
	SET dinheiro = dinheiro - _preco_item
	WHERE nome = _nome_treinador; -- ! _nome_treinador

DELETE FROM npc_guarda_instancia_de_item
	WHERE id_instancia_item = id_instancia; -- ! id_instancia

COMMIT;