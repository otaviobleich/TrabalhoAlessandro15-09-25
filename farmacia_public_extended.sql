
-- Banco de Dados: Rede de Farmácias (Fase 02)
-- Tabelas criadas no schema PUBLIC

-- Apagar tabelas antigas (se existirem) para recriar do zero
DROP TABLE IF EXISTS item_venda CASCADE;
DROP TABLE IF EXISTS venda CASCADE;
DROP TABLE IF EXISTS estoque_filial CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS fornecedor CASCADE;
DROP TABLE IF EXISTS produto CASCADE;
DROP TABLE IF EXISTS filial CASCADE;
DROP TABLE IF EXISTS empresa CASCADE;

-- Empresa
CREATE TABLE empresa (
    empresa_id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cnpj VARCHAR(20) UNIQUE
);

-- Filial
CREATE TABLE filial (
    filial_id SERIAL PRIMARY KEY,
    empresa_id INT REFERENCES empresa(empresa_id),
    nome VARCHAR(150) NOT NULL,
    cidade VARCHAR(100)
);

-- Produto
CREATE TABLE produto (
    produto_id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    categoria VARCHAR(100)
);

-- Fornecedor
CREATE TABLE fornecedor (
    fornecedor_id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cnpj VARCHAR(20) UNIQUE
);

-- Cliente
CREATE TABLE cliente (
    cliente_id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(20) UNIQUE
);

-- Estoque por filial
CREATE TABLE estoque_filial (
    estoque_id SERIAL PRIMARY KEY,
    filial_id INT REFERENCES filial(filial_id),
    produto_id INT REFERENCES produto(produto_id),
    quantidade NUMERIC(10,2) DEFAULT 0,
    preco NUMERIC(10,2) DEFAULT 0,
    UNIQUE (filial_id, produto_id)
);

-- Venda
CREATE TABLE venda (
    venda_id SERIAL PRIMARY KEY,
    filial_id INT REFERENCES filial(filial_id),
    cliente_id INT REFERENCES cliente(cliente_id),
    data_venda TIMESTAMP DEFAULT now(),
    total NUMERIC(10,2)
);

-- Itens da venda
CREATE TABLE item_venda (
    item_id SERIAL PRIMARY KEY,
    venda_id INT REFERENCES venda(venda_id) ON DELETE CASCADE,
    produto_id INT REFERENCES produto(produto_id),
    quantidade NUMERIC(10,2) NOT NULL,
    preco NUMERIC(10,2) NOT NULL
);

-- ========================
-- POPULAR AS TABELAS
-- ========================

-- Empresa
INSERT INTO empresa (nome, cnpj) VALUES
('Rede FarmaVida', '12.345.678/0001-90');

-- Filiais
INSERT INTO filial (empresa_id, nome, cidade) VALUES
(1, 'FarmaVida Centro', 'São Paulo'),
(1, 'FarmaVida Zona Sul', 'São Paulo'),
(1, 'FarmaVida Campinas', 'Campinas');

-- 30 Produtos
INSERT INTO produto (nome, categoria) VALUES
('Dipirona 500mg', 'Medicamento'),
('Paracetamol 750mg', 'Medicamento'),
('Ibuprofeno 400mg', 'Medicamento'),
('Amoxicilina 500mg', 'Medicamento'),
('Omeprazol 20mg', 'Medicamento'),
('Vitamina C 1g', 'Suplemento'),
('Polivitamínico A-Z', 'Suplemento'),
('Ômega 3 1000mg', 'Suplemento'),
('Colágeno 2g', 'Suplemento'),
('Creatina 300g', 'Suplemento'),
('Shampoo Anticaspa', 'Higiene'),
('Condicionador Hidratante', 'Higiene'),
('Sabonete Antibacteriano', 'Higiene'),
('Desodorante Aerosol', 'Higiene'),
('Creme Dental Menta', 'Higiene'),
('Escova de Dentes', 'Higiene'),
('Álcool Gel 70%', 'Higiene'),
('Protetor Solar FPS 50', 'Higiene'),
('Fralda G Infantil', 'Higiene'),
('Lenço Umedecido', 'Higiene'),
('Seringa 5ml', 'Material Médico'),
('Algodão 500g', 'Material Médico'),
('Esparadrapo 10m', 'Material Médico'),
('Atadura 3m', 'Material Médico'),
('Gaze Esterilizada', 'Material Médico'),
('Luvas Descartáveis', 'Material Médico'),
('Máscara Cirúrgica', 'Material Médico'),
('Termômetro Digital', 'Material Médico'),
('Aparelho de Pressão', 'Material Médico'),
('Oxímetro de Dedo', 'Material Médico');

-- Fornecedores
INSERT INTO fornecedor (nome, cnpj) VALUES
('Farmaco S.A.', '11.111.111/0001-11'),
('Saúde & Vida Ltda', '22.222.222/0001-22');

-- 10 Clientes
INSERT INTO cliente (nome, cpf) VALUES
('João Silva', '111.111.111-11'),
('Maria Oliveira', '222.222.222-22'),
('Carlos Souza', '333.333.333-33'),
('Ana Costa', '444.444.444-44'),
('Pedro Santos', '555.555.555-55'),
('Fernanda Lima', '666.666.666-66'),
('Lucas Almeida', '777.777.777-77'),
('Juliana Rocha', '888.888.888-88'),
('Ricardo Mendes', '999.999.999-99'),
('Patrícia Nunes', '000.000.000-00');

-- Estoque inicial (exemplo com alguns produtos)
INSERT INTO estoque_filial (filial_id, produto_id, quantidade, preco) VALUES
(1, 1, 100, 5.50),
(1, 2, 80, 6.00),
(1, 3, 50, 7.50),
(2, 10, 40, 80.00),
(2, 17, 120, 8.00),
(3, 25, 60, 12.00),
(3, 30, 20, 150.00);

-- Vendas
INSERT INTO venda (filial_id, cliente_id, total) VALUES
(1, 1, 11.00),
(2, 2, 20.00);

-- Itens das vendas
INSERT INTO item_venda (venda_id, produto_id, quantidade, preco) VALUES
(1, 1, 2, 5.50),   -- João comprou 2 Dipironas
(2, 3, 1, 20.00); -- Maria comprou 1 Shampoo (preço fictício)
