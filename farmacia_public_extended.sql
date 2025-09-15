
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
1	"Otavio Bleich Ferreira"	"138.079.139-12"
2	"Marli Ivoni Bleich"	"015.189.569-12"
3	"Carlos de Oliveira"	"123.098.182-12"
4	"Ana Costa"	"098.876.765-90"
5	"Pedro Santos"	"987.674.656-34"
6	"Fernanda Lima"	"368.728.377-27"
7	"Lucas Almeida"	"221.872.361-26"
8	"Juliana Rocha"	"029.742.037-42"
9	"Ricardo Mendes"	"928.364.926-28"
10	"Patrícia Nunes"	"982.093.460-23"
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
