--EXERCICIO 1
select p.nome, sum(preco_unitario * quant) as total
from pessoa p 
join vendedor v
on p.id_pessoa = v.id_vendedor
left join pedido using (id_vendedor)
join itens_pedido on pedido.numero = itens_pedido.numero_pedido
group by p.id_pessoa
order by nome

--EXERCICIO 2
select p.nome, sum(preco_unitario * quant) as total
from pessoa p 
join vendedor v
on p.id_pessoa = v.id_vendedor
left join pedido using (id_vendedor)
join itens_pedido on pedido.numero = itens_pedido.numero_pedido
where pedido.data_emissao >= '2021-08-01'
group by p.id_pessoa
order by nome

--EXERCICIO 3
SELECT descricao, id_deposito,logradouro, quant
from mercadoria_deposito 
right join mercadoria using (id_mercadoria)
left join deposito using (id_deposito)
order by descricao

--EXERCICIO 4

SELECT id_deposito, count(id_mercadoria) as quantidade_diferente
from mercadoria_deposito 
right join mercadoria using (id_mercadoria)
join deposito using (id_deposito)
group by mercadoria_deposito.id_deposito

--EXERCICIO 5
select p.nome,extract(year from pedido.data_emissao) as ano,
extract(month from pedido.data_emissao) as mes ,sum(preco_unitario * quant) as total
from pessoa p 
left join pedido on pedido.id_vendedor = p.id_pessoa
join itens_pedido on pedido.numero = itens_pedido.numero_pedido
group by p.id_pessoa,
extract(month from pedido.data_emissao),
extract(year from pedido.data_emissao)
order by nome, ano, mes

--EXERCICIO 6
select p.nome,extract(year from pedido.data_emissao) as ano,
extract(month from pedido.data_emissao) as mes ,sum(preco_unitario * quant) as total
from pessoa p 
left join pedido on pedido.id_vendedor = p.id_pessoa
join itens_pedido on pedido.numero = itens_pedido.numero_pedido
where lower(nome) like 'juarez%silva' 
group by p.id_pessoa,
extract(month from pedido.data_emissao),
extract(year from pedido.data_emissao)
order by ano, mes

--DESAFIO 1
SELECT  round(AVG(mercadoria.preco_venda)2) as media
from mercadoria

--Desafio 2
select descricao,(preco_venda-preco_custo)/preco_custo*100 as percentual_de_lucro
from mercadoria where preco_custo > 0
