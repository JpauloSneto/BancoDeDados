-- 1
DELIMITER //
CREATE TRIGGER trg_verifica_cpf
BEFORE INSERT ON funcionarios
FOR EACH ROW
BEGIN
  IF EXISTS (SELECT 1 FROM funcionarios WHERE CPF = NEW.CPF) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'CPF já cadastrado para outro funcionário.';
  END IF;
END //
DELIMITER ;

INSERT INTO funcionarios (CPF, nome, cargo, telefone, email)
VALUES ('12345678900', 'Outro Nome', 'RH', '11900000000', 'outro@email.com');
-- 2
DELIMITER //
CREATE TRIGGER trg_verifica_cnpj
BEFORE INSERT ON fornecedores
FOR EACH ROW
BEGIN
  IF EXISTS (SELECT 1 FROM fornecedores WHERE cnpj = NEW.cnpj) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'CNPJ já cadastrado.';
  END IF;
END //

DELIMITER ;
INSERT INTO fornecedores (nome, endereco, telefone, email, cnpj)
VALUES ('Novo Fornecedor', 'Rua Qualquer, 123', '11911112222', 'novo@email.com', '12.345.678/0001-01');

-- 3
DELIMITER //
CREATE TRIGGER trg_limite_preco_produto
BEFORE INSERT ON produtos
FOR EACH ROW
BEGIN
  IF NEW.preco > 5000 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Preço do produto excede o valor permitido.';
  END IF;
END //

DELIMITER ;
INSERT INTO produtos (nome, detalhes, preco, tamanho, cor, marca, cod_categoria, cod_fornecedor)
VALUES ('Jaqueta Luxo', 'Jaqueta exclusiva', 7000.00, 'M', 'Preto', 'LuxModa', 6, 8);

--4 
DELIMITER //
CREATE TRIGGER trg_categoria_maiuscula
BEFORE INSERT ON categoria
FOR EACH ROW
BEGIN
  SET NEW.nome = UPPER(NEW.nome);
END //

DELIMITER ;
INSERT INTO categoria (nome, descricao) VALUES ('camisas polo', 'Camisas sociais');
SELECT * FROM categoria WHERE nome = 'CAMISAS POLO';

-- 5
DELIMITER //
CREATE TRIGGER trg_email_minusculo_funcionario
BEFORE INSERT ON funcionarios
FOR EACH ROW
BEGIN
  SET NEW.email = LOWER(NEW.email);
END //
DELIMITER ;
INSERT INTO funcionarios (CPF, nome, cargo, telefone, email)
VALUES ('11122233344', 'Bruna Teste', 'Analista', '11999997777', 'BRUNA@EMAIL.COM');
SELECT email FROM funcionarios WHERE nome = 'Bruna Teste';

-- 6

DELIMITER //
CREATE TRIGGER trg_preco_negativo
BEFORE INSERT ON produtos
FOR EACH ROW
BEGIN
  IF NEW.preco < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Preço não pode ser negativo';
  END IF;
END;
//
DELIMITER ;
INSERT INTO produtos (nome, detalhes, preco, tamanho, cor, marca, cod_categoria, cod_fornecedor)
VALUES ('Produto Inválido', 'Teste', -10.00, 'M', 'Preto', 'Teste', 1, 1);

