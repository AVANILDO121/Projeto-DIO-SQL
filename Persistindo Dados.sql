-- Persistindo dados
use ecommerce;
delete from fornecedor;
INSERT INTO clientes (Fname, Minit ,Lname ,Nasc, CPF
, Rua, Num, Bairro, Cidade, Cep, Complemento, Estado)
	VALUES('Maria','M','Silva','1994-02-21','1234678900','silva de prata','29','Carangola','Cidade das Flores','57444-181',null,'Pénsilvania'),
		  ('Matheus','O','Pimentel','1999-02-04','98765432100','almeida','289','Centro','Cidade das Flores','57444-111',null,'Pénsilvania'),
          ('Ricardo','F','Silva','1987-07-21','45678913000','almeida vinha','1009','Centro','Cidade dasFlores','57444-475',null,'Pénsilvania'),
          ('Julia','S','França','2002-02-22','78912345600','Lareijras','861','Centro','Cidade dasFlores','57474-141',null,'Pénsilvania'),
          ('Roberta','G','Assis','1999-09-11','98745631000','avenida koller','19','Ccentro','Cidade dasFlores','58474-221',null,'Pénsilvania'),
          ('Isabela','M','Cruz','2009-05-04','65478912300','almeda flores','28','Centro','Cidade dasFlores','57444-177',null,'Pénsilvania');
          
          
INSERT INTO product(Pname, ProdutoPcriança, categoria, avaliação, size)
	VALUES ('Fone',false,'Eletrônico','4',null),
		   ('Barbie',true,'Brinquedos','3',null),
           ('Body',true,'Vestimenta','5',null),
           ('Microfone',false,'Eletrônico','4',null),
           ('chapa',false,'Eletrodoméstico','4','3x24x32'),
           ('Farinha',false,'Alimentos','2',null),
           ('Fire Stick',false,'Eletrônico','3',null);

INSERT INTO pedido(idPedidoClient, pedidoStatus, descrição, Frete, pagamento) VALUES
					(1,default,'compra via app',null,1),
                    (2,default,'compra via app',50,0),
                    (3,'Confirmado',null,null,1),
                    (4,default,'compra via web site',150,0);
                    
                    
INSERT INTO Produto_Pedido(idPoproduto, idPopedido, poquantidade, poStatus) VALUES
						(1,1,2,default),
                        (2,1,1,default),
                        (3,2,1,default);
                        
INSERT INTO estoque(lugar, quantidade) VALUES
					('Rio de Janeiro',1000),
                    ('Rio de Janeiro',500),
                    ('São Paulo',10),
                    ('São Paulo',100),
                    ('São Paulo',10),
                    ('Brasília',60);

INSERT INTO p_em_estoque(idLproduto, idLlocal, location) VALUES
						(1,2,'RJ'),
                        (2,6,'GO');

INSERT INTO fornecedor(Rsocial, CNPJ, contato) VALUES
	('Almeida e filhos', 123456789123456,'21985474'),
    ('Eletrônicos Silva', 854519649143457,'21985484'),
    ('Eletrônicos Valma', 934567893934695,'21975474');

INSERT INTO produtofornecedor(idPffornecedor, idPfproduto, quantidade) VALUES
					(1,1,500),
                    (1,2,400),
                    (2,4,633),
                    (3,3,5),
                    (2,5,10);
                    
INSERT INTO vendedor( Rsocial, AbstName, CNPJ, CPF,location, contato) VALUES
					('Tech eletronics', null, 123456789456321, null,'Rio de Janeiro', 219946287),
                    ('Botique Durgas', null, null,123456783,'Rio de Janeiro', 219567895),
                    ('Kids World', null, 456789123654485, null,'São Paulo', 1198657484);


INSERT INTO  Pvendedor(idPvendedor, idPproduto, Pquantidade) VALUES
					(1,6,80),
                    (2,7,10);

-- Recuperando o número de clientes
SELECT count(*) FROM clientes;

-- Recuperando os pedidos feitos por cada cliente
SELECT * FROM clientes c, pedido p WHERE c.idClient = idpedidoClient;

-- Filtrando a busca
SELECT concat(Fname,' ',Lname) AS Cliente,idPedido AS Num_Pedido,
pedidoStatus AS Situação FROM clientes c, pedido p WHERE c.idClient = idpedidoClient;

-- Adicionando mais um pedido
INSERT INTO pedido(idPedidoClient, pedidoStatus, descrição, Frete, pagamento) VALUES
					(2,default,'compra via app',null,1);
                    
-- Solicitando todos os clientes até os que não fez pedido
SELECT * FROM clientes LEFT OUTER JOIN pedido ON idClient = idpedidoClient;

-- Vendo quem fez algum pedido
SELECT * FROM clientes  INNER JOIN pedido ON idClient = idpedidoClient
						INNER JOIN produto_pedido ON idPopedido = idpedido;
                        
-- Filtrando com count, recuperando quantos pedidos foram realizados por cada cliente
SELECT idClient,Fname, count(*) AS Núm_de_Pedidos FROM clientes   INNER JOIN pedido ON idClient = idpedidoClient
						INNER JOIN produto_pedido ON idPopedido = idpedido
                        GROUP BY idClient;
                        
                        
