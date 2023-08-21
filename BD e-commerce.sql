-- Banco de dados E-commerce DIO.
CREATE DATABASE ecommerce;
USE ecommerce;

-- Tabela cliente

CREATE TABLE clientes(
	idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(10) ,
    Minit CHAR(3),
    Lname VARCHAR(20),
    Nasc DATE NOT NULL,
    CPF CHAR(11) NOT NULL,
    Rua VARCHAR(15) NOT NULL,
    Num VARCHAR(8) NOT NULL DEFAULT 'S/N',
    Bairro VARCHAR(15) NOT NULL,
    Cidade VARCHAR(18) NOT NULL,
    Cep VARCHAR(10) NOT NULL,
    Complemento VARCHAR(45),
    Estado VARCHAR(18) NOT NULL,
	CONSTRAINT unique_cpf_client UNIQUE(CPF)
    );
    
    ALTER TABLE clientes AUTO_INCREMENT=1;
    
-- Tabela Produto
-- size == Dimensão
CREATE TABLE product(
	idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(10) NOT NULL,
    ProdutoPcriança BOOL DEFAULT FALSE,
    Categoria ENUM('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos','Eletrodoméstico',
    'Automotivo','Bebês','Beleza','Jogos','Livros','Pet', 'Ferramentas','Esportes'),
    avaliação FLOAT DEFAULT 0,
    size VARCHAR(10)
    );

  ALTER TABLE product AUTO_INCREMENT=1;
  
-- Tabela pagamento

CREATE TABLE pagamento(
	idClient int,
	id_pagamento int NOT NULL AUTO_INCREMENT,
	tipo_pagamento ENUM('Boleto','Cartão de Crédito','Cartão de Debito','Pix'),
	limite_Disponivel FLOAT,
	PRIMARY KEY(idClient, id_pagamento),
	CONSTRAINT fk_pagamento_pedido FOREIGN KEY (id_pagamento) REFERENCES pedido(idPedido)
);

-- Tabela Pedido
CREATE TABLE pedido(
	idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idpedidoClient INT,
    pedidoStatus ENUM('Em Processamento', 'Cancelado', 'Confirmado') DEFAULT 'Em Processamento',
    descrição VARCHAR(255),
    frete FLOAT DEFAULT 15,
    pagamento BOOL NOT NULL,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (idpedidoClient) REFERENCES clientes(idClient)
);

-- Tabela Estoque 
CREATE TABLE estoque(
	idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    lugar  VARCHAR(55),
    quantidade INT DEFAULT 0
);

-- Tabela Fornecedor
CREATE TABLE fornecedor(
	idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    Rsocial VARCHAR(255) NOT NULL,
    CNPJ CHAR(15) NOT NULL,
    contato VARCHAR(13) NOT NULL,
    CONSTRAINT fornecedor_unique UNIQUE (CNPJ)
);
ALTER TABLE fornecedor AUTO_INCREMENT=1;

-- Tabela Vendedor
CREATE TABLE vendedor(
	idVendedor INT AUTO_INCREMENT PRIMARY KEY,
    Rsocial VARCHAR(255) NOT NULL,
    AbstName VARCHAR(255),
    CNPJ CHAR(15),
    CPF CHAR(11),
    location VARCHAR(255) NOT NULL,
    contato VARCHAR(13) NOT NULL,
    CONSTRAINT fornecedor_cnpj_unique UNIQUE (CNPJ),
    CONSTRAINT fornecedor_cpf_unique UNIQUE (CPF)
);
ALTER TABLE vendedor AUTO_INCREMENT=1;

-- Produto Vendedor
CREATE TABLE Pvendedor(
	idPvendedor INT,
    idPproduto INT,
    Pquantidade INT DEFAULT 1,
    PRIMARY KEY (idPvendedor, idPproduto),
    CONSTRAINT fk_produto_vendedor FOREIGN KEY (idPvendedor) REFERENCES vendedor(idVendedor),
    CONSTRAINT fk_produto_produto FOREIGN KEY (idPproduto) REFERENCES product(idProduct)
    );

-- Produto/Pedido
CREATE TABLE Produto_Pedido(
	idPoproduto INT,
    idPopedido INT,
    poquantidade INT DEFAULT 1,
    poStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idPoproduto, idPopedido),
    CONSTRAINT fk_Po_produto FOREIGN KEY (idPoproduto) REFERENCES product(idProduct),
    CONSTRAINT fk_Po_pedido FOREIGN KEY (idPopedido) REFERENCES pedido(idPedido)
    );
    

-- Produto em estoque
CREATE TABLE p_em_estoque(
	idLproduto INT,
    idLlocal INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idLproduto, idLlocal),
    CONSTRAINT fk_Lproduto FOREIGN KEY (idLproduto) REFERENCES product(idProduct),
    CONSTRAINT fk_Llocal FOREIGN KEY (idLlocal) REFERENCES estoque(idEstoque)
    );

-- Produto/fornecedor
CREATE TABLE produtofornecedor(
	idPffornecedor INT,
    idPfproduto INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (idPffornecedor, idPfproduto),
    CONSTRAINT fk_pf_fornecedor FOREIGN KEY (idPffornecedor) REFERENCES fornecedor(idFornecedor),
    CONSTRAINT fk_pf_produto FOREIGN KEY (idPfproduto) REFERENCES product(idProduct)
    );
SHOW DATABASES;
SELECT * FROM referential_constraints 
WHERE constraint_schema='ecommerce';