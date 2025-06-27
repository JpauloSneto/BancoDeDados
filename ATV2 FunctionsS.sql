use Loja_roupa;

SELECT p.nome AS produto, c.nome AS categoria, f.nome AS fornecedor
FROM produtos p
JOIN categoria c ON p.cod_categoria = c.id_categoria
JOIN fornecedores f ON p.cod_fornecedor = f.id_fornecedor
;

-- 1. 
DELIMITER //
CREATE FUNCTION CalcularIdadeCliente(p_id_cliente INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_data_cadastro DATE;
    SELECT cadastro_data INTO v_data_cadastro FROM clientes WHERE id_cliente = p_id_cliente;
    IF v_data_cadastro IS NULL THEN
        RETURN NULL;
    END IF;
    RETURN TIMESTAMPDIFF(YEAR, v_data_cadastro, CURRENT_DATE());
END //
DELIMITER ;

-- Teste da Function: CalcularIdadeCliente
SELECT
    c.nome,
    c.cadastro_data,
    CalcularIdadeCliente(c.id_cliente) AS tempo_cadastro_anos
FROM clientes c
WHERE c.id_cliente = 5;


-- 2.
DELIMITER //
CREATE FUNCTION CalcularValorTotalVendaProduto(p_id_venda INT, p_id_produto INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_quantidade INT;
    DECLARE v_valor_unitario DECIMAL(10,2);

    SELECT quantidade, valor INTO v_quantidade, v_valor_unitario
    FROM produto_venda
    WHERE id_venda = p_id_venda AND id_produto = p_id_produto;

    IF v_quantidade IS NULL OR v_valor_unitario IS NULL THEN
        RETURN 0.00;
    END IF;

    RETURN v_quantidade * v_valor_unitario;
END //
DELIMITER ;

-- Teste da Function: CalcularValorTotalVendaProduto
SELECT
    pv.id_venda,
    pv.id_produto,
    pv.quantidade,
    pv.valor,
    CalcularValorTotalVendaProduto(pv.id_venda, pv.id_produto) AS subtotal_calculado
FROM produto_venda pv
WHERE pv.id_venda = 1 AND pv.id_produto = 1;


-- 3. 
DELIMITER //
CREATE FUNCTION ObterEstoqueAtualProduto(p_id_produto INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_quantidade INT;
    SELECT quantidade INTO v_quantidade FROM estoque WHERE cod_produto = p_id_produto;
    IF v_quantidade IS NULL THEN
        RETURN 0;
    END IF;
    RETURN v_quantidade;
END //
DELIMITER ;

-- Teste da Function: ObterEstoqueAtualProduto
SELECT
    p.nome AS nome_produto,
    ObterEstoqueAtualProduto(p.id_produto) AS estoque_atual
FROM produtos p
WHERE p.id_produto = 2; 

-- 4. 
DELIMITER //
CREATE FUNCTION ObterDescontoPromocaoAtiva(p_data DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_desconto DECIMAL(10,2) DEFAULT 0.00;
    SELECT MAX(desconto) INTO v_desconto
    FROM promocao
    WHERE p_data BETWEEN data_comeco AND data_fim;
    RETURN IFNULL(v_desconto, 0.00);
END //
DELIMITER ;

-- Teste da Function: ObterDescontoPromocaoAtiva
SELECT ObterDescontoPromocaoAtiva('2025-03-05') AS desconto_em_marco; 
SELECT ObterDescontoPromocaoAtiva('2025-01-01') AS desconto_em_janeiro; 


-- 5. 
DELIMITER //
CREATE FUNCTION FormatarTelefone(p_telefone VARCHAR(20))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE v_telefone_limpo VARCHAR(20);
    SET v_telefone_limpo = REGEXP_REPLACE(p_telefone, '[^0-9]', '');

    IF LENGTH(v_telefone_limpo) = 11 THEN
        RETURN CONCAT('(', SUBSTRING(v_telefone_limpo, 1, 2), ') ', SUBSTRING(v_telefone_limpo, 3, 5), '-', SUBSTRING(v_telefone_limpo, 8, 4));
    ELSEIF LENGTH(v_telefone_limpo) = 10 THEN
        RETURN CONCAT('(', SUBSTRING(v_telefone_limpo, 1, 2), ') ', SUBSTRING(v_telefone_limpo, 3, 4), '-', SUBSTRING(v_telefone_limpo, 7, 4));
    ELSE
        RETURN p_telefone; -- Retorna o original se não puder formatar
    END IF;
END //
DELIMITER ;

-- Teste da Function: FormatarTelefone
SELECT FormatarTelefone('11987654321') AS telefone_formatado_1;
SELECT FormatarTelefone('2134567890') AS telefone_formatado_2;
SELECT FormatarTelefone('99999') AS telefone_nao_formatado;

-- 6. 
DELIMITER //
CREATE FUNCTION ObterPrecoComDescontoPromocional(p_id_produto INT, p_data_venda DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_preco_original DECIMAL(10,2);
    DECLARE v_desconto_promocional DECIMAL(10,2);

    SELECT preco INTO v_preco_original FROM produtos WHERE id_produto = p_id_produto;
    SET v_desconto_promocional = ObterDescontoPromocaoAtiva(p_data_venda);

    IF v_preco_original IS NULL THEN
        RETURN NULL;
    END IF;

    RETURN v_preco_original * (1 - v_desconto_promocional);
END //
DELIMITER ;

-- Teste da Function: ObterPrecoComDescontoPromocional
SELECT
    p.nome,
    p.preco AS preco_original,
    ObterPrecoComDescontoPromocional(p.id_produto, '2025-03-05') AS preco_com_desconto_marco,
    ObterPrecoComDescontoPromocional(p.id_produto, '2025-01-01') AS preco_com_desconto_janeiro
FROM produtos p
WHERE p.id_produto = 1; 















