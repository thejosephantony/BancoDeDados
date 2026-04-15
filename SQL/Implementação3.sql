CREATE SCHEMA universidade;

CREATE TYPE universidade.tipo_status_discente AS ENUM ('ATIVO', 'CANCELADO', 'TRANCADO', 'GRADUADO');

CREATE TYPE universidade.tipo_nivel AS ENUM ('GRADUACAO', 'MESTRADO', 'LATO', 'DOUTORADO');

CREATE TYPE universidade.tipo_grau AS ENUM ('BACHARELADO', 'LICENCIATURA PLENA' );

CREATE TYPE universidade.tipo_turno AS ENUM ('Matutino', 'Noturno', 'Vespertino', 'Turno Indefinido');

CREATE TABLE universidade.curso(
  	idcurso SERIAL,
	nome VARCHAR,
  	grau universidade.tipo_grau,
  	nivel universidade.tipo_nivel,
  	turno universidade.tipo_turno,
  	campus VARCHAR,
  	coordenador VARCHAR,
  	PRIMARY KEY(idcurso),
  	UNIQUE(nome, nivel, turno, campus)
);

INSERT INTO universidade.curso(nome, grau, nivel, turno, campus, coordenador)
VALUES
('SISTEMAS DE INFORMAÇÃO', 'BACHARELADO', 'GRADUACAO', 'Matutino', 'Itabaiana', 'RAPHAEL PEREIRA DE OLIVEIRA'),
('CIÊNCIA DA COMPUTAÇAO', 'BACHARELADO', 'GRADUACAO', 'Vespertino', 'SÃO CRISTOVAO', 'RODOLFO BOTTO'),
('CIÊNCIA DA COMPUTAÇÃO', NULL, 'MESTRADO', 'Vespertino', 'SÃO CRISTOVAO', 'ADMILSON RIBAMAR'),
('ENGENHARIA DE COMPUTAÇÃO','BACHARELADO', 'GRADUACAO', 'Vespertino', 'SAO CRISTOVAO', 'JÂNIO CANUTO');



CREATE TABLE universidade.discente(
	matricula NUMERIC(13) PRIMARY KEY,
  	nome_discente VARCHAR NOT NULL,
  	ano_ingresso SMALLINT,
  	periodo_ingresso SMALLINT,
  	status_discente universidade.tipo_status_discente,
  	curso INT,
  	FOREIGN KEY (curso) REFERENCES universidade.curso (idcurso)
);

INSERT INTO universidade.discente 
VALUES
(202500032413,'ÁBIAN MACHADO',2025,1,'ATIVO', 4),
(202300038780, 'JOSEPH ANTONY', 2023, 1, 'ATIVO', 4),
(202500100587, 'ABRAÃO NUNES DE OLIVEIRA', 2025, 2, 'ATIVO', 2 )