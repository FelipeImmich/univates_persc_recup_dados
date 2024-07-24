--Listar a quantidade total estocada de cada produto nos depósitos 
--(soma dos estoques de todos os depósitos juntos para cada item)
select id_mercadoria as id, descricao, sum(quant) as estoque
	from mercadoria_deposito join mercadoria using (id_mercadoria)
group by id, descricao
order by id

--Essa quantidade total levantada no exercício anterior
--(a soma dos estoques dos depósitos) deveria fechar com o estoque de cada item
--registrado na tabela mercadoria. Listar os produtos onde há diferença entre o
--estoque registrado na tabela mercadoria e a soma dos estoques daquele item nos
--depósitos
select * from(select id_mercadoria as id, descricao, sum(quant) as estoque_real, estoque
	from mercadoria_deposito join mercadoria using (id_mercadoria)
group by id, descricao, estoque)
where estoque_real <> estoque
order by id 

--Listar o total que nossa empresa vendeu para cada município
select id_municipio, nome, sum(total_pedido) from pedido
join (select id_municipio, id_pessoa from pessoa) on id_cliente = id_pessoa
join municipio using(id_municipio)
join (select numero_pedido as numero, sum(quant*preco_unitario) as total_pedido from itens_pedido
	group by numero_pedido) as tot_ped
using (numero)
group by id_municipio, nome
order by id_municipio

--Listar o total que cada vendedor da nossa empresa vendeu para cada município.
select nome_vend, nome, sum(total_pedido) from pedido
join (select id_municipio, id_pessoa from pessoa) on id_cliente = id_pessoa
join municipio using(id_municipio)
join (select nome as nome_vend, id_pessoa as id_vendedor from pessoa) using (id_vendedor)
join (select numero_pedido as numero, sum(quant*preco_unitario) as total_pedido from itens_pedido
	group by numero_pedido) as tot_ped
using (numero)
group by nome_vend, nome
order by nome_vend