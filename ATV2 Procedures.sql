-- 1
DELIMITER //
CREATE PROCEDURE clientes_fieis(IN limite DECIMAL(10,2))
BEGIN
  SELECT c.nome, SUM(v.valor) AS total_compras
  FROM vendas v
  JOIN clientes c ON v.cod_cliente = c.id_cliente
  GROUP BY c.nome
  HAVING total_compras >= limite;
END;
DELIMITER //

CALL clientes_fieis(100);

-- 2. 
DELIMITER //
CREATE PROCEDURE relatorio_vendas_cliente ()
BEGIN
  SELECT c.nome AS cliente, COUNT(v.id_venda) AS qtd_vendas,
         SUM(v.valor) AS total_gasto, AVG(v.valor) AS media_venda
  FROM vendas v
  JOIN clientes c ON v.cod_cliente = c.id_cliente
  GROUP BY c.nome
  ORDER BY total_gasto DESC;
END;
DELIMITER //
CALL relatorio_vendas_cliente();

-- 3
DELIMITER //
CREATE PROCEDURE produtos_por_fornecedor ()
BEGIN
  SELECT f.nome AS fornecedor, p.nome AS produto, p.preco, c.nome AS categoria
  FROM fornecedores f
  JOIN produtos p ON f.id_fornecedor = p.cod_fornecedor
  JOIN categoria c ON p.cod_categoria = c.id_categoria
  ORDER BY f.nome, p.nome;
END;
DELIMITER //

CALL produtos_por_fornecedor();

-- 4
DELIMITER //
CREATE PROCEDURE produto_estoque (
    IN limite INT
)
BEGIN
    SELECT p.id_produto, p.nome, e.quantidade
    FROM produtos p
    JOIN estoque e ON p.id_produto = e.cod_produto
    WHERE e.quantidade < limite;
END 
//

CALL produto_estoque(25);

-- 5
DEMILITER //
CREATE PROCEDURE minimo_vendas (
    IN minimo_vendas INT
)
BEGIN
    SELECT f.id_funcionario, f.nome, COUNT(v.id_venda) AS total_vendas
    FROM funcionarios f
    JOIN vendas v ON f.id_funcionario = v.cod_vendedor
    GROUP BY f.id_funcionario, f.nome
    HAVING COUNT(v.id_venda) >= minimo_vendas;
END;
//
CALL minimo_vendas(0);

DELIMITER //
CREATE PROCEDURE produtos_categoria (
    IN nome_categoria VARCHAR(100)
)
BEGIN
    SELECT p.id_produto, p.nome, p.detalhes, p.preco, p.tamanho, p.cor, p.marca
    FROM produtos p
    JOIN categoria c ON p.cod_categoria = c.id_categoria
    WHERE c.nome = nome_categoria;
END;
 //
DELIMITER ;

CALL produtos_categoria('Camisetas');






















