CREATE DATABASE Projeto_Madre2023;
GO
USE Projeto_Madre2023;

--Tabela Perfil
CREATE TABLE Perfil (Id_Perfil INTEGER IDENTITY PRIMARY KEY,
					 Nome_Perfil VARCHAR(30) NOT NULL,
					 Descricao_Perfil VARCHAR(500) NOT NULL);

INSERT INTO	Perfil	(Nome_Perfil, Descricao_Perfil)
VALUES				('Urbano Moderno',			'A atração pelo ritmo e pela energia das cidades é o que estimula todos os seus destinos. Você busca explorar as nuances culturais, a arquitetura, a gastronomia, adora fazer compras e sempre interessado em explorar a vida noturna e a vida cotidiana das áreas urbanas.'),
					('Explorador Cultural',		'Você é o típico perfil de viajante que não pode ficar longe de museus e centros históricos de cidades coloniais é fascinado por diferentes culturas, ama aprender sobre a história dos lugares, procura autenticidade nas experiências, gosta de se envolver com os habitantes locais. O gastar muito ou pouco para você depende do que a cultura do lugar exige, normalmente lê tudo e estuda muito antes de embarcar.'),
					('Aventureiro Audacioso',	'Sem medo de desafios você prefere viagens para buscar experiências extremas, gosta de testar seus limites físicos e mentais, prefere locais menos explorados, o principal objetivo é experimentar atividades radicais que incluem atividades ao ar livre, como caminhadas, trilhas, escaladas, rafting, bungee jumping, mergulho em cavernas e outras atividades radicais.'),
					('Relaxamento e Bem-estar', 'Relaxar é a palavra principal quando você resolve planejar uma viagem, busca locais que ofereçam tranquilidade, foca em destinos com ambientes naturais deslumbrantes e atividades que promovam o bem-estar, descanso, lazer e relaxamento.'),
					('Viajante Gastronômico',	'A culinária sempre está no centro de sua experiência de viagem, por isso viajar para se deliciar com os sabores únicos de diferentes culturas e regiões é o principal objetivo da sua viagem, entendendo que a comida é uma forma poderosa de explorar a diversidade cultural do mundo.');
SELECT * FROM Perfil;

--Tabela Usuario
CREATE TABLE Usuario (CPF_Usuario CHAR(11) PRIMARY KEY NOT NULL,
					  Id_Perfil INTEGER REFERENCES Perfil (Id_Perfil)ON DELETE NO ACTION,
					  Nome_Usuario VARCHAR(60) NOT NULL,
					  RG_Usuario VARCHAR(20) NOT NULL ,
					  Orgao_emissor VARCHAR(6) NOT NULL,   
					  Nascimento DATE NOT NULL,
					  Telefone VARCHAR(20) NOT NULL,
					  Email VARCHAR(50) NOT NULL UNIQUE,
					  Sexo CHAR(1) NOT NULL
					  CHECK(Sexo = 'M' OR Sexo ='F'));

INSERT INTO Usuario (CPF_Usuario, Id_Perfil,  Nome_Usuario, RG_Usuario, Orgao_emissor, Nascimento , Telefone, Email, Sexo)
VALUES				('12329912447', 1, 'Rafaela', '98543262', 'SDS-PE', '30/05/2005', '(81)986716273', 'rafaelacavalcanti15@gmail.com', 'F'),
					('12152796470', 2, 'Rennan', '10457072', 'SDS-PE', '28/07/2004', '(81)996520004', 'rennancorrea280704@gmail.com', 'M'),
					('02724159446', 3, 'Rachel', '65234155', 'SDS-PE', '20/04/1978', '(81)996542881' , 'rachelcavalcanti15@gmail.com', 'F'),
					('78945612303', 4, 'Ckely', '15975362', 'SDS-PE', '27/06/1979', '(81)995426814' , 'ckelyagata@gmail.com', 'F'),
					('69852314725', 5, 'Roberio', '75326887', 'SDS-PE', '21/11/2001', '(81)915842682', 'roberioneto@gamil.com', 'F');

SELECT * FROM Usuario;

--tabela agencia 
CREATE TABLE Agencia   (CNPJ_Agencia CHAR(14) PRIMARY KEY NOT NULL,
					    Nome_Agencia VARCHAR(50) NOT NULL,
						Email VARCHAR(50) NOT NULL UNIQUE,
						Telefone VARCHAR(20) NOT NULL,  
						Logradouro VARCHAR(50) NOT NULL,
						Numero VARCHAR(10) NOT NULL,
						Cidade VARCHAR(50) NOT NULL,
						Estado CHAR(2) NOT NULL,      
						Bairro VARCHAR(50) NOT NULL,
						Complemento VARCHAR(50) NOT NULL,
						CEP CHAR(8) NOT NULL DEFAULT 50000000);

INSERT INTO Agencia (CNPJ_Agencia, Nome_Agencia, Email, Telefone, Logradouro, Numero, Cidade, Estado,Bairro,Complemento,Cep )
VALUES				('14785236985632', 'CVC', 'agenciacvc@gmail.com', '(81)957463214', 'Rua do jangadeiro', '248','Jaboat�o dos Guararapes', 'PE','Candeias', 'sala 702', '54430315'),
					('89563214785692', 'Decolar', 'decolaragencia@gmail.com', '(84)987456321', 'Rua metropoles','458', 'Cabo branco', 'RN', 'mossoro','sala 801', '36521478'),
					('96321054789652', 'Smiles', 'smilesAgenciaturismo@gmail.com', '(11)99987456', 'Rua do bom jesus', '123', 'Sorocaba', 'SP', 'campina', 'Sala 201', '54430312'); 

SELECT * FROM Agencia;


--tabela pacote
CREATE TABLE Pacote  (Cod_Pacote INTEGER IDENTITY PRIMARY KEY,
					  CNPJ_Agencia CHAR(14) REFERENCES Agencia (Cnpj_Agencia),
					  Tipo_Acomodacao VARCHAR(15) NOT NULL
					  CHECK (Tipo_Acomodacao IN ('Single', 'Duplo', 'Triplo')),
					  Nome_Pacote VARCHAR(60) NOT NULL,
					  Periodo VARCHAR(10) NOT NULL,
					  Descricao_Pacote VARCHAR(100) NOT NULL,
					  Destino VARCHAR(100) NOT NULL,
					  Valor MONEY NOT NULL);

INSERT INTO Pacote (CNPJ_Agencia,  Tipo_Acomodacao, Nome_Pacote, Periodo, Descricao_Pacote, Destino, Valor)
VALUES			   ('14785236985632' , 'Single', 'Pacote Natal na Argentina', '7 dias', 'Uma Viagem inesquecível', 'Argentina', '4000'),
				   ('89563214785692', 'Triplo', 'Pacote Reveillon na França' , '5 dias', 'A viagem dos sonhos', 'Paris, Nice' , ' 7000'),
				   ('96321054789652', 'Triplo', 'Pacote Verão Europeu', '15 dias' , 'O verão mais desejado', 'Espanha, Portugal, Belgica', '10000');	   

SELECT * FROM Pacote;


-- tabela relacionamento usuario e pacote 
CREATE TABLE Usuario_Pacote(CPF_Usuario CHAR(11) REFERENCES Usuario (CPF_Usuario),
							Cod_Pacote INTEGER REFERENCES Pacote (Cod_Pacote) ,
							PRIMARY KEY (CPF_Usuario , Cod_Pacote));

INSERT INTO Usuario_Pacote (CPF_Usuario, Cod_Pacote)
VALUES					   ('12329912447', '2'),
						   ('12152796470', '3'),
						   ('02724159446', '1'),
						   ('78945612303', '2'),
						   ('69852314725', '3');

SELECT * FROM Usuario_Pacote;

--Table Quiz
CREATE TABLE Quiz (Cod_Quiz INTEGER IDENTITY(1000,10) PRIMARY KEY,
				   CPF_Usuario CHAR(11) REFERENCES Usuario (CPF_Usuario),
				   Data DATE NOT NULL); 

INSERT INTO Quiz (CPF_Usuario, Data)
VALUES			 ('12329912447', '21/11/2023'),
				 ('12152796470', '20/11/2023'),
				 ('02724159446', '19/11/2023'),
				 ('78945612303', '18/11/2023'),
				 ('69852314725', '22/11/2023');

SELECT * FROM Quiz;

-- tabela questãoo
CREATE TABLE Questao (Id_Questao INTEGER IDENTITY PRIMARY KEY,
					  Descricao_Questao VARCHAR(100) NOT NULL);

INSERT INTO Questao (Descricao_Questao)
VALUES				('1. O que mais atrai você em uma viagem?'),
					('2. Qual é o ambiente que você prefere em suas viagens? '),
					('3. O que você busca em uma experiência de viagem?	'),
					('4. Qual é a sua abordagem em relação à culinária durante as viagens?'),
				    ('5. O que é mais importante em suas escolhas de destinos?	'),
				    ('6. Qual tipo de atividade você mais gosta durante as viagens?'),
				    ('7. Qual é a sua reação a experiências emocionantes e radicais?'),
				    ('8. Como você se sente sobre explorar áreas naturais e paisagens?'),
					('9. Qual é o seu objetivo principal ao viajar?				'),
					('10. O que você mais gosta de explorar durante uma viagem?	');
SELECT * FROM Questao;

-- tabela relacionamento quiz e quest�o 
CREATE TABLE Quiz_Questao (Cod_Quiz INTEGER REFERENCES Quiz (Cod_Quiz) ,
						   Id_Questao INTEGER REFERENCES Questao (Id_Questao),
						   PRIMARY KEY (Cod_Quiz , Id_Questao));

INSERT INTO Quiz_Questao (Cod_Quiz, Id_Questao)
VALUES					 (1000, 1),
						 (1010, 2),
						 (1020, 3), 
						 (1030, 4),
						 (1040, 5),
						 (1000, 6),
						 (1010, 7),
						 (1020, 8),
						 (1030, 9),
						 (1040, 10);

SELECT * FROM Quiz_Questao;

-- tabela Alternativa
CREATE TABLE Alternativa (Cod_Alternativa INTEGER IDENTITY PRIMARY KEY,
						  Id_Questao INTEGER REFERENCES Questao (Id_Questao),
						  Id_Perfil INTEGER REFERENCES Perfil (Id_Perfil),
						  Descricao_Alternativa VARCHAR(100) NOT NULL);

INSERT INTO Alternativa (Id_Questao, Id_Perfil, Descricao_Alternativa)
VALUES					('1' , '1', 'a)Relaxar em praias paradisíacas.'),
						('1' , '2', 'b)Explorar a história e a cultura dos destinos.'),
						('1' , '3', 'c)Aventurar-se em atividades ao ar livre.'),
						('1' , '4', 'd)Desfrutar da vida noturna e do entretenimento.'),
						('1' , '5', 'e)Saborear a culinária local.'),
						('2' , '1', 'a)Destinos urbanos e agitados.'),
						('2' , '2', 'b)Locais ricos em história e cultura.'),
						('2' , '3', 'c)Paisagens naturais e ao ar livre.'),
						('2' , '4', 'd)Lugares tranquilos e relaxantes.'),
						('2' , '5', 'e)Cidades com cenários gastronômicos.'),
						('3' , '1', 'a)Conexões sociais e eventos animados.'),
						('3' , '2', 'b)Aprendizado sobre diferentes culturas e tradições.'),
						('3' , '3', 'c)Aventuras emocionantes e adrenalina.'),
						('3' , '4', 'd)Entretenimento noturno e atividades variadas.'),
						('3' , '5', 'e)Exploração da culinária local e sabores únicos.'),
						('4' , '1', 'a)Explorar restaurantes e experimentar pratos locais.'),
						('4' , '2', 'b)Valorizar a história culinária e pratos tradicionais.'),
						('4' , '3', 'c)Priorizar a comida rápida para mais tempo de exploração.'),
						('4' , '4', 'd)Gostar de refeições tranquilas e relaxantes.'),
						('4' , '5', 'e)Descobrir sabores autênticos e produtos locais.'),
						('5' , '1', 'a)Vida noturna vibrante e atividades sociais.'),
						('5' , '2', 'b)Patrimônio cultural, museus e locais históricos.'),
						('5' , '3', 'c)Acesso a trilhas, esportes e aventuras.'),
						('5' , '4', 'd)Ambientes tranquilos e escapadas relaxantes.'),
						('5' , '5', 'e)Cenário gastronômico e experiências culinárias'),
						('6' , '1', 'a)Festejar em bares e clubes.'),
						('6' , '2', 'b)Explorar museus e locais culturais.'),
						('6' , '3', 'c)Praticar esportes e atividades ao ar livre.'),
						('6' , '4', 'd)Relaxar em praias ou spas.'),
						('6' , '5', 'e)Degustar iguarias locais em restaurantes.'),
						('7' , '1', 'a)Festejar em bares e clubes.'),
						('7' , '2', 'b)Gosto de um equilíbrio entre aventura e tranquilidade.'),
						('7' , '3', 'c)Prefiro experiências culturais e sociais.'),
						('7' , '4', 'd)Prefiro evitar atividades muito emocionantes.'),
						('7' , '5', 'e)Gosto de um toque de aventura em minhas viagens.'),
						('8' , '1', 'a)Amo explorar praias, montanhas e florestas.'),
						('8' , '2', 'b)Gosto de um equilíbrio entre ambientes urbanos e naturais.'),
						('8' , '3', 'c)Prefiro interagir com culturas locais.'),
						('8' , '4', 'd)Prefiro ambientes urbanos e culturais.'),
						('8' , '5', 'e)Gosto de cenários naturais para atividades ao ar livre.'),
						('9' , '1', 'a)Encontrar entretenimento noturno e socializar.'),
						('9' , '2', 'b)Aprender sobre diferentes culturas e tradições..'),
						('9' , '3', 'c)Buscar aventuras e desafios emocionantes.'),
						('9' , '4', 'd)Relaxar e escapar da rotina.'),
						('9' , '5', 'e)Explorar sabores culinários únicos.'),
						('10' , '1', 'a)Vida noturna, festas e eventos sociais.'),
						('10' , '2', 'b)Museus, monumentos históricos e locais culturais.'),
						('10' , '3', 'c)Trilhas, esportes ao ar livre e atividades radicais.'),
						('10' , '4', 'd)Ambientes tranquilos e paisagens naturais.'),
						('10' , '5', 'e)Restaurantes, mercados locais e experiências gastronômicas');

SELECT * FROM Alternativa;


-- tabela proposta
CREATE TABLE Proposta  (Id_Proposta INTEGER IDENTITY PRIMARY KEY,
					    CPF_Usuario CHAR(11) REFERENCES Usuario (CPF_Usuario),
						Local_Saida VARCHAR(50) NOT NULL,
						Destino VARCHAR(50) NOT NULL,
						Data_Ida DATE NOT NULL,
						Data_Volta DATE NOT NULL,
						Qtd_Quartos INTEGER NOT NULL,
						Tipo_Acomodacao VARCHAR(15) NOT NULL
					    CHECK (Tipo_Acomodacao IN ('Single', 'Duplo', 'Triplo')));

INSERT INTO Proposta (CPF_Usuario, Local_Saida, Destino, Data_Ida, Data_Volta, Qtd_Quartos, Tipo_Acomodacao)
VALUES               ('12329912447', 'São paulo', 'Recife', '22/11/2023', '30/11/2023', '3', 'Single'),
					 ('12152796470', 'Brasilia', 'Portugal', '28/11/2023', '25/11/2023', '2', 'Duplo'), 
					 ('02724159446', 'França', 'Belgica', '27/11/2023', '10/12/2023', '2', 'Triplo'), 
					 ('78945612303', 'São paulo', 'Orlando', '24/11/2023', '30/11/2023', '3', 'Duplo'), 
					 ('69852314725', 'Recife', 'Belo-Horizonte', '29/11/2023', '11/12/2023', '4', 'Duplo'); 

SELECT * FROM Proposta;

-- tabela de tipo de passageiro 
CREATE TABLE Tipo_Passageiro   (Cod_Passageiro INTEGER IDENTITY PRIMARY KEY,
								Nome_Passageiro VARCHAR(60) NOT NULL,
								CPF_Passageiro CHAR(11) NOT NULL UNIQUE,
								RG_Passageiro VARCHAR(20) NOT NULL,
								Orgao_emissor VARCHAR(6) NOT NULL,
								Nascimento DATE NOT NULL,
								Telefone VARCHAR(20) NOT NULL);

INSERT INTO Tipo_Passageiro (Nome_Passageiro, CPF_Passageiro, RG_Passageiro, Orgao_emissor, Nascimento,Telefone)
VALUES						('Priscila', '11111111111', '88888888', 'SDS-PE', '30/05/2005', '999999999'), 
							('Julia',    '22222222222', '88888888', 'SDS-PE', '30/05/2005', '999999999'),
							('Kayo',     '33333333333', '88888888', 'SDS-PE', '30/05/2005', '999999999'),
							('Jose',     '44444444444', '88888888', 'SDS-PE', '30/05/2005', '999999999'), 
							('Joao',     '55555555555', '88888888', 'SDS-PE', '30/05/2005', '999999999');
						
SELECT * FROM Tipo_Passageiro;

-- tabela de relacionamento proposta e passageiro
CREATE TABLE Proposta_Passageiro(Id_Proposta INTEGER IDENTITY REFERENCES Proposta (Id_Proposta),
								 Cod_Passageiro INTEGER REFERENCES Tipo_Passageiro (Cod_Passageiro)
								 PRIMARY KEY (Id_Proposta, Cod_Passageiro));

INSERT INTO Proposta_Passageiro (Cod_Passageiro)    
VALUES							('1'),
								('2'),
								('3'),
								('4'),
								('5');

SELECT * FROM Proposta_Passageiro;

-- tabela pais 
CREATE TABLE Pais (Cod_Pais INTEGER IDENTITY PRIMARY KEY,
					Descricao_Pais VARCHAR(50) NOT NULL);

INSERT INTO Pais (Descricao_Pais)
VALUES			 ('Brasil'),
				 ('Portugal'),
				 ('Espanha');

SELECT * FROM Pais;

-- tabela ponto 
CREATE TABLE Ponto (Id_Ponto INTEGER IDENTITY PRIMARY KEY,
					Cod_Pais INTEGER REFERENCES Pais (Cod_Pais),
					Nome_Ponto VARCHAR(50) NOT NULL,
					Cidade VARCHAR(50) NOT NULL,
					Descricao_Ponto VARCHAR(100) NOT NULL DEFAULT('Lugar Perfeito'));
					

INSERT INTO Ponto (Cod_Pais, Nome_Ponto, Cidade, Descricao_Ponto)
VALUES			  ('1' , 'Cristo redentor', 'Rio de Janeiro', 'é mágico'),
				  ('2', 'Mercado da ribeira', 'Lisboa ', 'Otimo para comer'),
				  ('3', 'praias de Ibiza', 'Ibiza' , 'praias paradisiacas');

SELECT * FROM Ponto;	

-- tabela de relacionamento pacote e ponto 
CREATE TABLE Pacote_Ponto  (Cod_Pacote INTEGER REFERENCES Pacote(Cod_Pacote),
							Id_Ponto INTEGER REFERENCES Ponto (Id_Ponto),
							PRIMARY KEY(Cod_Pacote, Id_Ponto));

INSERT INTO Pacote_Ponto (Cod_Pacote, Id_Ponto)
VALUES					 ('2', '1'),
						 ('3', '2'),
						 ('1', '3');

SELECT * FROM Pacote_Ponto;

-- tabela de relacionamento proposta e ponto 
CREATE TABLE  Proposta_Ponto(Id_Proposta INTEGER REFERENCES Proposta (Id_Proposta),
							 Id_Ponto INTEGER REFERENCES Ponto (Id_Ponto)
							 PRIMARY KEY (Id_Proposta, Id_Ponto));

INSERT INTO Proposta_Ponto (Id_Proposta ,Id_Ponto)
VALUES					   ('2' , '1'),
						   ('3' , '2'),
						   ('4' , '3'),
						   ('5' , '2'),
						   ('1' , '3');

SELECT * FROM Proposta_Ponto;

-- tabela de relacionamento perfil e ponto 
CREATE TABLE Perfil_Ponto  (Id_Perfil INTEGER REFERENCES Perfil (Id_Perfil),
							Id_Ponto INTEGER REFERENCES Ponto (Id_Ponto)
							PRIMARY KEY(Id_Perfil,Id_Ponto));

INSERT INTO Perfil_Ponto	(Id_Perfil , Id_Ponto )
VALUES						('1', '1'),
							('2', '2'),
							('3', '3');

SELECT * FROM Perfil_Ponto;

-- uso de join e AS ****
SELECT 
    p.Nome_Perfil,
	q.Descricao_Questao,
	a.Descricao_Alternativa

FROM 
    Questao AS q
INNER JOIN 
    Alternativa AS a ON q.Id_Questao = a.Id_Questao
INNER JOIN 
    Perfil AS p ON a.Id_Perfil = p.Id_Perfil;

-- INDEX
SELECT 
    q.Descricao_Questao,
	a.Descricao_Alternativa
	FROM 
    Questao AS q
	INNER JOIN 
    Alternativa AS a ON q.Id_Questao = a.Id_Questao

	CREATE INDEX idx_teste on Questao(Id_Questao);

-- Utilizar as funções de agregação (SUM, COUNT, AVG, MAX, MIN);
-- COUNT 
SELECT Sexo, Count(*) AS 'Qtd'
FROM Usuario
GROUP BY Sexo;

-- MIN 
SELECT MIN(Valor) AS menorValor
FROM Pacote;


-- MAX 
SELECT MAX(Valor)  AS maiorValor
FROM Pacote;

-- SUM 
SELECT SUM(Valor) AS SomaTotal
FROM Pacote;

-- AVG
SELECT AVG(Valor) AS media
FROM Pacote;


-- automação (trigger ) 
CREATE TRIGGER inclusao
ON 
		Pais
FOR 
		INSERT
AS 
		PRINT 'Registro INSERIDO com sucesso!!!';

-- Inserir na tabela 
INSERT INTO Pais
VALUES ('Argentina');


-- Stored Procedures
CREATE PROCEDURE SP_Mensagem 
AS
PRINT 'Bem-vindo ao site Países Perfeitos';
EXECUTE SP_Mensagem ;


--FUNCTION 
-- CRIAMOS UMA FUCTION PE PASSAMOS UM VALOR DE UM PACOR=TE X E ESSA FUNÇÃO DIZ SE ELE É UM VALOR ESPERADO OU NÃO

CREATE FUNCTION F_Pacote(@valor FLOAT)
		RETURNS VARCHAR(50)
AS
BEGIN
DECLARE @Media FLOAT, @Retorno VARCHAR(50)
SET @Media = (@valor)/3
IF @Media < 4000
SET @Retorno = 'valor menor que o menor pacote'
ELSE 
SET @Retorno = 'valor acima do esperado'
RETURN (@Retorno)
END;

SELECT dbo.F_Pacote(35000);