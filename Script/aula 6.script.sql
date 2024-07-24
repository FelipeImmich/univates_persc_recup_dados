select * from public.cliente
select * from public.deposito
select * from public.fornecedor
select * from public.fornecedor_mercadoria
select * from public.itens_pedido
select * from public.mercadoria
select * from public.mercadoria_deposito
select * from public.municipio
select * from public.pedido
select * from public.pessoa
select * from public.regiao
select * from public.vendedor

--EXERCICIO 01
select p.nome from cliente c, pessoa p
where c.id_cliente = p.id_pessoa

--EXERCICIO 02
select p.nome from cliente c, pessoa p
where c.id_cliente = p.id_pessoa
and p.id_municipio = '1'

--EXERCICIO 03
select p.nome from cliente c, pessoa p, municipio m
where c.id_cliente = p.id_pessoa
and m.populacao > '10000'
and p.id_municipio = m.id_municipio

--EXERCICIO 04
select p.nome from cliente c, pessoa p, itens_pedido i, pedido pe
where c.id_cliente = p.id_pessoa
and pe.id_cliente = c.id_cliente
and pe.numero = i.numero_pedido
and i.id_mercadoria = '15'

--EXERCICIO 05
select p.nome from vendedor v, pessoa p
where v.id_vendedor = p.id_pessoa
and v.sigla_regiao = 'SUL'
order by nome

--EXERCICIO 06
select a.nome nome_vendedor, b.nome nome_chefe from vendedor v, pessoa a, pessoa b
where v.id_chefe = b.id_pessoa
and a.id_pessoa = v.id_vendedor
order by a.nome

--EXERCICIO 07
select p.nome 
from vendedor v, pessoa p, itens_pedido i, pedido pe
where v.id_vendedor = p.id_pessoa
and pe.id_vendedor = v.id_vendedor
and pe.numero = i.numero_pedido
and i.id_mercadoria = '16'
order by p.nome

--EXERCICIO 08
select p.nome, p.logradouro, p.numero from cliente c, pessoa p
where c.id_cliente = p.id_pessoa
and p.id_municipio = '1'

--EXERCICIO 09
select m.id_mercadoria
from  mercadoria m left join itens_pedido i ON m.id_mercadoria = i.id_mercadoria
where i.id_mercadoria is NULL
order by m.id_mercadoria

--EXERCICIO 10
SELECT DISTINCT p.numero,p.data_emissao, pv.nome nome_vendedor, pc.nome nome_cliente, m.nome municipio
from pedido p, pessoa pv, pessoa pc, municipio m, vendedor v, cliente c
where v.id_vendedor = pv.id_pessoa
and c.id_cliente = pc.id_pessoa
and p.id_cliente = c.id_cliente
and p.id_vendedor = v.id_vendedor
and pc.id_municipio = m.id_municipio
order by nome_cliente

--EXERCICIO 11
select m.descricao
from mercadoria_deposito md, mercadoria m
where m.id_mercadoria = md.id_mercadoria
and md.id_deposito = '1'
order by m.descricao

--EXERCICIO 12
select m.descricao, md.id_deposito, md.quant
from mercadoria_deposito md, mercadoria m
where m.id_mercadoria = md.id_mercadoria
order by m.descricao

--EXERCICIO 13
