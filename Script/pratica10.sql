--1.Listar o nome dos alunos que estudam na turma 4 ou na turma 5.
select nome from aluno 
join contrato using(cod_alu)
where num_turma = 4
union
select nome from aluno 
join contrato using(cod_alu)
where num_turma = 5
order by nome

--2.Listar o nome dos alunos que estudam na turma 4 e também na turma 5 (inserir mais alunos em uma das turmas para que o resultado apresente algum nome comum às duas turmas).
insert into aluno values (2,'Joao Silva', 'Rua da flores, 1050','2004-02-09','11122233300','1111111111',2);
insert into aluno values (3,'Evelin Reis', 'Rua Ermindo Lohman,10','1997-09-01','99144233300','2111211121',2);
insert into contrato values (10,3,4,300);
insert into contrato values (9,2,4,300);
insert into contrato values (11,3,5,200);
insert into contrato values (12,2,5,200);

select nome from aluno 
join contrato using(cod_alu)
where num_turma = 4
intersect
select nome from aluno 
join contrato using(cod_alu)
where num_turma = 5
order by nome

--3.Listar o nome de todos os alunos da escola, exceto os alunos que estudam na turma 4.
select nome from aluno 
join contrato using(cod_alu)
except
select nome from aluno 
join contrato using(cod_alu)
where num_turma = 4
order by nome

--4.Listar o nome das mercadorias que estão em algum depósito da região Norte (NRT).
select distinct descricao from mercadoria_deposito
join (select * from deposito join municipio using (id_municipio) where sigla_regiao = 'NRT') using (id_deposito)
join mercadoria using (id_mercadoria)
order by descricao

--5.Listar o valor total (preço de venda x quantidade) dos estoques de cada um dos depósitos (número do depósito e valor total).
select id_deposito, cast(sum(quant*preco_venda)as numeric(10,2)) as vlr_total
from mercadoria_deposito
join mercadoria using (id_mercadoria)
group by id_deposito
order by id_deposito

--6.Listar o valor total (preço de venda x quantidade) dos estoques de cada um dos depósitos, mas SOMENTE considerar as mercadorias que foram vendidas a partir de agosto de 2021.
select id_deposito, cast(sum(quant*preco_venda)as numeric(10,2)) as vlr_total
from mercadoria_deposito
join (select * from mercadoria where data_ultima_venda >= '2021-08-01') using (id_mercadoria)
group by id_deposito
order by id_deposito

--7.Listar o valor total (preço de venda x quantidade) dos estoques de cada um dos depósitos, mas SOMENTE considerar as mercadorias que já foram vendidas pelo menos uma vez pelo vendedor 01 (Juarez Silva).
select id_deposito, cast(sum(quant*preco_venda)as numeric(10,2)) as vlr_total
from mercadoria_deposito
join (select id_mercadoria from itens_pedido join pedido on (numero_pedido = numero) where id_vendedor = 1) using (id_mercadoria)
join mercadoria using(id_mercadoria)
group by id_deposito
order by id_deposito

--8.Listar o nome dos vendedores que já venderam Espeto (id = 15) ou que venderam alguma coisa em junho de 2021.

select nome from pessoa join vendedor on id_pessoa = id_vendedor
join (select numero, id_vendedor from pedido 
	join (select * from itens_pedido where id_mercadoria = 15)
	on (numero_pedido=numero)) using (id_vendedor)
union
select nome from pessoa join vendedor on id_pessoa = id_vendedor
join (select numero, id_vendedor from pedido where data_emissao between ('2021-06-01') and ('2021-06-30'))
using (id_vendedor)

--9.Listar o nome dos vendedores que já venderam mais do que 1000 reais exceto os vendedores que venderam UM item por 1000 reais ou mais.
select nome from pessoa join vendedor on id_pessoa = id_vendedor
join (select sum(soma) as soma_vendas, id_vendedor from pedido 
	join (select numero_pedido, sum(quant*preco_unitario) as soma
	from itens_pedido group by numero_pedido)
	on (numero = numero_pedido) group by id_vendedor) using (id_vendedor)
except
select nome from pessoa join vendedor on id_pessoa = id_vendedor
join (select numero, id_vendedor from pedido 
	join (select * from itens_pedido where preco_unitario > 1000)
	on (numero = numero_pedido)) using (id_vendedor)