--1.Listar o número do contrato e a soma das parcelas pagas por cada contrato
select num_contr as numero_contrato, sum(valor_pago) as pago
	from parcela
group by (num_contr)
order by (num_contr)


--2.Listar o nome dos alunos e valor pago por eles até o momento em cada contrato
select nome, num_contr, pago from aluno
join contrato using (cod_alu)
join (select num_contr, sum(valor_pago) as pago from parcela
group by num_contr) using (num_contr)
order by nome


--3.Listar o código dos alunos, o número da turma e a média das notas daquele aluno naquela turma 
select cod_alu, num_turma, media_nota from contrato join prova using (num_turma)
left join (select cod_prova, cod_alu, avg(nota) as media_nota from nota
group by cod_prova, cod_alu) using (cod_prova, cod_alu)
order by cod_alu



--4.Listar o nome dos alunos, o número da turma e a média das notas daquele aluno naquela turma
select nome, num_turma, media_nota from contrato join prova using (num_turma)
left join (select cod_prova, cod_alu, avg(nota) as media_nota from nota
group by cod_prova, cod_alu) using (cod_prova, cod_alu)
join aluno using(cod_alu)
order by nome
	
--5.Listar o nome dos alunos, a descrição da turma e número de aulas que cada aluno participou
select nome, descricao, numero_aulas_presente from aluno
	join (select cod_alu, num_turma, count(data_aula) as numero_aulas_presente from presenca
	group by num_turma, cod_alu) using(cod_alu)
	join turma using (num_turma)
	order by nome

--6.Definir os municípios dos alunos conforme o quadro abaixo 
--1°
create table municipio
(
	cod_municipio INTEGER PRIMARY KEY,
	nome VARCHAR(50),
	uf CHAR(2),
)
--2°
ALTER TABLE aluno 
ADD COLUMN cod_municipio INTEGER;

--3°
ALTER TABLE aluno
ADD CONSTRAINT fk_municipio
FOREIGN KEY (cod_municipio) REFERENCES municipio;

--4°
INSERT INTO municipio VALUES (1,'Lajeado','RS')
INSERT INTO municipio VALUES (2,'Porto Alegre','RS')
INSERT INTO municipio VALUES (3,'Florianopolis','SC')

UPDATE aluno SET cod_municipio = 1 WHERE cod_alu = 1;
UPDATE aluno SET cod_municipio = 2 WHERE cod_alu = 42;
UPDATE aluno SET cod_municipio = 1 WHERE cod_alu = 56;
UPDATE aluno SET cod_municipio = 3 WHERE cod_alu = 77;
UPDATE aluno SET cod_municipio = 1 WHERE cod_alu = 455;
UPDATE aluno SET cod_municipio = 3 WHERE cod_alu = 782;

--7.Exibir quantos alunos são do estado RS 4
SELECT count(cod_alu) AS quantidade_alunos_rs
FROM aluno
JOIN (SELECT cod_municipio FROM municipio WHERE UF = 'RS') using (cod_municipio)

--8.Exibir quantos alunos do RS frequentam por dia da semana (onde há turmas ocorrendo)
SELECT SUM(+1) AS Alunos_RS , dia_semana 
FROM aluno
JOIN (SELECT cod_municipio, UF FROM municipio WHERE UF = 'RS') USING (cod_municipio)
JOIN (SELECT num_turma, cod_alu FROM contrato) USING (cod_alu)
JOIN (SELECT * FROM ocorrencia) USING (num_turma)
GROUP BY (dia_semana)

--9.Listar o número e nome das turmas (descrição) com a média de preços dos contratos daquela turma
SELECT num_turma, descricao, media FROM turma
JOIN (SELECT num_turma, AVG(valor) AS media FROM contrato GROUP BY (num_turma)) USING (num_turma)

--10.Listar o total dos contratos realizados por município. Listar o nome do município e o total 
select nome, count(num_contr) from contrato
join (select municipio.nome, cod_alu from aluno join municipio using(cod_municipio)) using (cod_alu)
group by nome
order by nome


--[Desafio] Exibir o nome dos alunos com o número do contrato onde pelo menos duas parcelas não pagas (não precisam estar atrasadas, apenas não pagas)
--[Desafio] Exibir o nome dos alunos e o saldo devedor (não pago) dos dos alunos cujo saldo devedor é de pelo menos 100,00
--[Desafio] Exibir o nome dos alunos que participaram de pelos 5 aulas de qualquer turma na escola, pois serão os alunos que terão direito ao desconto extra de 10% na próxima mensalidade 


