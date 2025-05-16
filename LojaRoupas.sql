create schema Loja_Roupa;
use Loja_Roupa;

create table categoria(
id_categoria int primary key auto_increment,
nome varchar(100),
descricao varchar(100)
);

create table fornecedores(
id_fornecedor int primary key auto_increment,
nome varchar(100),
endereco varchar(255),
telefone varchar(100),
email varchar(150),
cnpj varchar(50)
);

create table produtos(
id_produto int primary key auto_increment,
nome varchar(100),
descricao varchar(250),
preco decimal(10,2),
tamanho varchar(100),
cor varchar(100),
marca varchar(100),
cod_categoria int,
cod_fornecedor int,
foreign key (cod_categoria) references categoria(id_categoria),
foreign key (cod_fornecedor) references fornecedores (id_fornecedor)
);

create table estoque(
id_estoque int primary key auto_increment,
cod_produto int,
quantidade int,
data_entrada date,
data_saida date null,
foreign key (cod_produto) references produtos(id_produto)
);

create table clientes(
id_cliente int primary key auto_increment,
nome varchar(100),
endereco varchar(100),
telefone varchar(100),
email varchar(100)
);

create table funcionarios(
id_funcionario int primary key auto_increment,
CPF varchar(35),
nome varchar(100),
cargo varchar(100),
telefone varchar(100),
email varchar(100)
);

create table promocao(
id_promocao int primary key auto_increment,
data_comeco date,
data_fim date,
desconto decimal(10,2),
descricao varchar(100)
);

create table vendas(
id_venda int primary key auto_increment,
data_venda date,
cod_cliente int,
cod_vendedor int,
desconto decimal (10, 2),
valor decimal(10, 2),
foreign key (cod_cliente) references clientes (id_cliente),
foreign key (cod_vendedor) references funcionarios (id_funcionario)
);

create table produto_venda(
id_venda int,
id_produto int,
quantidade int,
valor decimal(10, 2),
primary key (id_venda, id_produto),
foreign key (id_venda) references vendas (id_venda),
foreign key (id_produto) references produtos (id_produto)
);

-- Segunda parte da atividade para alterar a estrutura da tabela --


alter table clientes add column cadastro_data date;
alter table fornecedores modify telefone varchar(20);
alter table funcionarios modify CPF varchar(14);
alter table fornecedores modify column cnpj varchar(50) not null;
alter table categoria modify descricao varchar(250);
alter table funcionarios add unique (CPF);
alter table clientes MODIFY cadastro_data DATE DEFAULT CURRENT_DATE;
alter table fornecedores modify cnpj varchar(18);
alter table produtos change column descricao detalhes varchar(250);
alter table clientes add unique (email);

                    -- inserçao de dados na tabela --

insert into categoria (nome, descricao) values
	('Camisetas', 'Roupas leves de algodão'),
	('Calças', 'Calças jeans e sociais'),
	('Vestidos', 'Diversos tipos de vestidos'),
	('Sapatos', 'Calçados em geral'),
	('Acessórios', 'Bolsas, cintos, etc.'),
	('Jaquetas', 'Roupas de frio'),
	('Shorts', 'Roupas para o verão'),
	('Esportivo', 'Roupas para esporte'),
	('Infantil', 'Roupas para crianças'),
	('Moda íntima', 'Roupas íntimas')
;

insert into fornecedores (nome, endereco, telefone, email, cnpj) values
	('FashionTex', 'Rua das Flores, 100', '11999998888', 'contato@fashiontex.com', '12.345.678/0001-01'),
	('ModaVip', 'Av. Brasil, 200', '11888887777', 'vendas@modavip.com', '23.456.789/0001-02'),
	('JeansWorld', 'Rua Azul, 300', '11777776666', 'info@jeansworld.com', '34.567.890/0001-03'),
	('Calçadão', 'Av. Paulista, 1500', '11666665555', 'atendimento@calcadao.com', '45.678.901/0001-04'),
	('TopLook', 'Rua Central, 50', '11555554444', 'suporte@toplook.com', '56.789.012/0001-05'),
	('KidsWear', 'Av. Infantil, 75', '11444443333', 'kids@kidswear.com', '67.890.123/0001-06'),
	('AtivaSport', 'Rua Fit, 30', '11333332222', 'contato@ativasport.com', '78.901.234/0001-07'),
	('LuxModa', 'Rua da Moda, 10', '11222221111', 'luxo@luxmoda.com', '89.012.345/0001-08'),
	('FrioBom', 'Av. Neve, 123', '11111110000', 'jaquetas@friobom.com', '90.123.456/0001-09'),
	('BelaIntima', 'Rua Rosa, 400', '11900009999', 'vendas@belaintima.com', '01.234.567/0001-10')
;

insert into produtos (nome, descricao, preco, tamanho, cor, marca, cod_categoria, cod_fornecedor) values
	('Camiseta Básica', 'Camiseta algodão branca', 39.90, 'M', 'Branca', 'FashionTex', 1, 1),
	('Calça Jeans Slim', 'Jeans azul escuro', 99.90, 'G', 'Azul', 'JeansWorld', 2, 3),
	('Vestido Floral', 'Vestido estampado leve', 149.90, 'M', 'Rosa', 'ModaVip', 3, 2),
	('Tênis Esportivo', 'Tênis para corrida', 199.90, '42', 'Preto', 'AtivaSport', 4, 7),
	('Bolsa Couro', 'Bolsa feminina de couro', 229.90, 'Único', 'Marrom', 'TopLook', 5, 5),
	('Jaqueta Jeans', 'Jaqueta para meia-estação', 159.90, 'G', 'Azul', 'FrioBom', 6, 9),
	('Short Jeans', 'Shorts para verão', 79.90, 'P', 'Azul claro', 'JeansWorld', 7, 3),
	('Conjunto Fitness', 'Conjunto legging + top', 139.90, 'M', 'Preto/Rosa', 'AtivaSport', 8, 7),
	('Macacão Infantil', 'Roupinha para bebê', 59.90, 'P', 'Colorido', 'KidsWear', 9, 6),
	('Sutiã Renda', 'Moda íntima feminina', 49.90, 'M', 'Vermelho', 'BelaIntima', 10, 10)
;

insert into estoque (cod_produto, quantidade, data_entrada, data_saida) values
	(1, 50, '2025-01-10', NULL),
	(2, 40, '2025-01-12', NULL),
	(3, 30, '2025-01-15', NULL),
	(4, 25, '2025-01-20', NULL),
	(5, 60, '2025-01-25', NULL),
	(6, 20, '2025-02-01', NULL),
	(7, 35, '2025-02-03', NULL),
	(8, 15, '2025-02-05', NULL),
	(9, 45, '2025-02-10', NULL),
	(10, 55, '2025-02-15', NULL)
;

insert into clientes (nome, endereco, telefone, email) values
	('Ana Silva', 'Rua A, 123', '11911112222', 'ana@email.com'),
	('Bruno Souza', 'Rua B, 456', '11922223333', 'bruno@email.com'),
	('Carlos Lima', 'Av. C, 789', '11933334444', 'carlos@email.com'),
	('Daniela Ramos', 'Rua D, 321', '11944445555', 'daniela@email.com'),
	('Eduardo Pereira', 'Av. E, 654', '11955556666', 'eduardo@email.com'),
	('Fernanda Costa', 'Rua F, 987', '11966667777', 'fernanda@email.com'),
	('Gabriel Rocha', 'Rua G, 147', '11977778888', 'gabriel@email.com'),
	('Helena Martins', 'Av. H, 258', '11988889999', 'helena@email.com'),
	('Isabela Torres', 'Rua I, 369', '11999990000', 'isabela@email.com'),
	('João Oliveira', 'Av. J, 741', '11900001111', 'joao@email.com')
;

insert into funcionarios (CPF, nome, cargo, telefone, email) values
	('12345678900', 'Luiz Almeida', 'Vendedor', '11912345678', 'luiz@loja.com'),
	('23456789011', 'Marina Costa', 'Caixa', '11923456789', 'marina@loja.com'),
	('34567890122', 'Rafael Gomes', 'Gerente', '11934567890', 'rafael@loja.com'),
	('45678901233', 'Camila Lima', 'Estoquista', '11945678901', 'camila@loja.com'),
	('56789012344', 'Thiago Souza', 'Vendedor', '11956789012', 'thiago@loja.com'),
	('67890123455', 'Amanda Rocha', 'Caixa', '11967890123', 'amanda@loja.com'),
	('78901234566', 'Pedro Santos', 'Vendedor', '11978901234', 'pedro@loja.com'),
	('89012345677', 'Juliana Reis', 'Supervisora', '11989012345', 'juliana@loja.com'),
	('90123456788', 'Felipe Mota', 'Repositor', '11990123456', 'felipe@loja.com'),
	('01234567899', 'Renata Dias', 'RH', '11901234567', 'renata@loja.com')
;

insert into promocao (data_comeco, data_fim, desconto, descricao) values
	('2025-03-01', '2025-03-10', 10.00, 'Semana da mulher'),
	('2025-04-01', '2025-04-05', 15.00, 'Páscoa'),
	('2025-05-01', '2025-05-12', 20.00, 'Dia das mães'),
	('2025-06-01', '2025-06-15', 25.00, 'Inverno'),
	('2025-07-01', '2025-07-10', 10.00, 'Férias de Julho'),
	('2025-08-01', '2025-08-12', 15.00, 'Dia dos pais'),
	('2025-09-01', '2025-09-10', 20.00, 'Primavera'),
	('2025-10-01', '2025-10-12', 10.00, 'Dia das crianças'),
	('2025-11-01', '2025-11-30', 30.00, 'Black Friday'),
	('2025-12-01', '2025-12-25', 20.00, 'Natal')
;

insert into vendas (data_venda, cod_cliente, cod_vendedor, desconto, valor) values
	('2025-03-01', 1, 1, 5.00, 150.00),
	('2025-03-02', 2, 2, 0.00, 90.00),
	('2025-03-03', 3, 3, 10.00, 200.00),
	('2025-03-04', 4, 4, 0.00, 50.00),
	('2025-03-05', 5, 5, 5.00, 120.00),
	('2025-03-06', 6, 6, 10.00, 180.00),
	('2025-03-07', 7, 7, 0.00, 75.00),
	('2025-03-08', 8, 8, 15.00, 210.00),
	('2025-03-09', 9, 9, 0.00, 99.00),
	('2025-03-10', 10, 10, 20.00, 300.00)
;

insert into produto_venda (id_venda, id_produto, quantidade, valor) values
	(1, 1, 2, 79.80),
	(2, 2, 1, 99.90),
	(3, 3, 1, 149.90),
	(4, 4, 1, 199.90),
	(5, 5, 1, 229.90),
	(6, 6, 1, 159.90),
	(7, 7, 2, 159.80),
	(8, 8, 1, 139.90),
	(9, 9, 1, 59.90),
	(10, 10, 1, 49.90)
;

							-- updates e deletes --
DELETE FROM vendas WHERE id_venda = 6;
DELETE FROM produtos WHERE id_produto = 8;
DELETE FROM fornecedores WHERE id_fornecedor = 5;
DELETE FROM clientes WHERE id_cliente = 10;
DELETE FROM estoque WHERE quantidade = 0;
DELETE FROM funcionarios WHERE cargo = 'estagiario';
DELETE FROM estoque WHERE cod_produto = 9;
DELETE FROM clientes WHERE telefone IS NULL OR telefone = '';
DELETE FROM produtos WHERE preco = 0;
DELETE FROM fornecedores WHERE LENGTH(cnpj) < 10;


update estoque set quantidade = 50 where cod_produto = 3;
update produtos set preco = preco * 1.10 where marca = 'Nike';
update promocao set desconto = 25.00 where id_promocao = 2;
update clientes set nome = 'Alex Telles' where id_cliente = 1;
update produtos set cor = 'Preto' where id_produto = 7;
update promocao set desconto = 0.20 where id_promocao = 4;
update funcionarios set cargo = 'Diretora pessoal' where nome = 'Juliana Reis';
update categoria set descricao = 'Calças jeans e formais' where nome = 'calças';
update clientes set nome = 'Carlos Limamei' where nome = 'Carlos Lima';
update categoria set nome ='Jaqueta' where nome = 'Jaquetas';

								-- relatorios --
                                
SELECT p.nome, c.nome AS categoria, f.nome AS fornecedor
FROM produtos p
JOIN categoria c ON p.cod_categoria = c.id_categoria
JOIN fornecedores f ON p.cod_fornecedor = f.id_fornecedor;

SELECT p.nome, e.quantidade
FROM produtos p
JOIN estoque e ON p.id_produto = e.cod_produto;

SELECT p.nome, e.quantidade
FROM produtos p
JOIN estoque e ON p.id_produto = e.cod_produto
WHERE e.quantidade < 5;

SELECT v.id_venda, c.nome AS cliente, f.nome AS funcionario, v.valor
FROM vendas v
JOIN clientes c ON v.cod_cliente = c.id_cliente
JOIN funcionarios f ON v.cod_vendedor = f.id_funcionario;

SELECT p.nome, pv.quantidade
FROM produtos_vendas pv
JOIN produtos p ON pv.id_produto = p.id_produto
JOIN vendas v ON pv.id_venda = v.id_venda
WHERE v.data_venda = '2025-05-10';

SELECT c.nome, SUM(v.valor) AS total_compras
FROM vendas v
JOIN clientes c ON v.cod_cliente = c.id_cliente
GROUP BY c.nome;

SELECT f.nome, COUNT(*) AS total_vendas, SUM(v.valor) AS total
FROM vendas v
JOIN funcionarios f ON v.cod_vendedor = f.id_funcionario
GROUP BY f.nome;

SELECT c.nome
FROM clientes c
WHERE c.id_cliente IN (
  SELECT cod_cliente
  FROM vendas
  GROUP BY cod_cliente
  HAVING SUM(valor) > 500
);

SELECT * FROM promocao
WHERE CURRENT_DATE BETWEEN data_comeco AND data_fim;

SELECT DISTINCT p.nome
FROM produtos p
JOIN produtos_vendas pv ON p.id_produto = pv.id_produto
JOIN vendas v ON pv.id_venda = v.id_venda
JOIN promocao pr ON v.data_venda BETWEEN pr.data_comeco AND pr.data_fim;

-- 11
SELECT nome
FROM produtos
WHERE id_produto NOT IN (SELECT id_produto FROM produtos_vendas);

-- 12
SELECT MONTH(data_venda) AS mes, SUM(valor) AS total
FROM vendas
GROUP BY mes;

SELECT f.nome, COUNT(p.id_produto) AS total_produtos
FROM fornecedores f
JOIN produtos p ON f.id_fornecedor = p.cod_fornecedor
GROUP BY f.nome;

SELECT p.nome, SUM(pv.quantidade) AS total_vendido
FROM produtos_vendas pv
JOIN produtos p ON pv.id_produto = p.id_produto
GROUP BY p.nome
ORDER BY total_vendido DESC
LIMIT 1;

SELECT c.nome, SUM(v.valor) AS total
FROM vendas v
JOIN clientes c ON v.cod_cliente = c.id_cliente
GROUP BY c.nome
ORDER BY total DESC
LIMIT 5;


SELECT v.id_venda
FROM produtos_vendas
GROUP BY id_venda
HAVING COUNT(*) > 1;


SELECT p.nome, SUM(pv.quantidade * pv.valor) AS lucro_total
FROM produtos p
JOIN produtos_vendas pv ON p.id_produto = pv.id_produto
GROUP BY p.nome;


SELECT v.id_venda, v.valor, v.desconto
FROM vendas v
WHERE v.desconto > (v.valor * 0.2);


SELECT * FROM vendas
WHERE valor > 1000;

SELECT DISTINCT c.nome
FROM clientes c
JOIN vendas v ON c.id_cliente = v.cod_cliente
JOIN produtos_vendas pv ON v.id_venda = pv.id_venda
JOIN produtos p ON pv.id_produto = p.id_produto
JOIN categoria ct ON p.cod_categoria = ct.id_categoria
WHERE ct.nome = 'Camisas';

CREATE VIEW vw_produtos_categorias AS
SELECT p.nome, c.nome AS categoria FROM produtos p
JOIN categoria c ON p.cod_categoria = c.id_categoria;

CREATE VIEW vw_estoque_atual AS
SELECT p.nome, e.quantidade FROM produtos p
JOIN estoque e ON p.id_produto = e.cod_produto;

CREATE VIEW vw_vendas_clientes_funcionarios AS
SELECT v.*, c.nome AS cliente, f.nome AS funcionario
FROM vendas v
JOIN clientes c ON v.cod_cliente = c.id_cliente
JOIN funcionarios f ON v.cod_vendedor = f.id_funcionario;

CREATE VIEW vw_total_vendas_cliente AS
SELECT cod_cliente, SUM(valor) AS total
FROM vendas
GROUP BY cod_cliente;

CREATE VIEW vw_produtos_nunca_vendidos AS
SELECT * FROM produtos
WHERE id_produto NOT IN (SELECT id_produto FROM produtos_vendas);

CREATE VIEW vw_vendas_maiores_1000 AS
SELECT * FROM vendas WHERE valor > 1000;

CREATE VIEW vw_clientes_fiéis AS
SELECT cod_cliente, COUNT(*) AS compras
FROM vendas
GROUP BY cod_cliente
HAVING COUNT(*) > 5;

CREATE VIEW vw_promocoes_ativas AS
SELECT * FROM promocao
WHERE CURRENT_DATE BETWEEN data_comeco AND data_fim;

CREATE VIEW vw_lucro_por_produto AS
SELECT p.nome, SUM(pv.valor * pv.quantidade) AS lucro
FROM produtos p
JOIN produtos_vendas pv ON p.id_produto = pv.id_produto
GROUP BY p.nome;

CREATE VIEW vw_vendas_com_desconto_alto AS
SELECT * FROM vendas
WHERE desconto > (valor * 0.2);

       -- Script para destruir tudo dentro do banco de dados --
	
-- drop database loja_roupa;
create schema Loja_roupa;



