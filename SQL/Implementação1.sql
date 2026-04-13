CREATE SCHEMA UNIVERSIDADE;

CREATE TYPE UNIVERSIDADE.grau AS ENUM ('Bacharelado', 'Licenciatura Plena');
CREATE TYPE UNIVERSIDADE.turno AS ENUM ('Vespertino', 'Matutino', 'Noturno', 'Turno Indefinido');
CREATE TYPE UNIVERSIDADE.nivel AS ENUM ('GRADUAÇÃO', 'LATO', 'RESIDÊNCIA', 'MESTRADO', 'DOUTORADO');

CREATE TABLE UNIVERSIDADE.curso(
  nome VARCHAR(150),
  grau UNIVERSIDADE.grau,
  nivel UNIVERSIDADE.nivel,
  turno UNIVERSIDADE.turno,
  campus VARCHAR(150),
  coordenador VARCHAR(255)
);

INSERT INTO UNIVERSIDADE.curso(nome, grau, nivel, turno, campus, coordenador)
VALUES
('CIÊNCIA DA COMPUTAÇÃO', 'Bacharelado', 'GRADUAÇÃO', 'Vespertino', 'FUNDACAO UNIVERSIDADE FEDERAL DE SERGIPE', 'GILTON JOSÉ FERREIRA DA SILVA, MICHEL DOS SANTOS SOARES');

-- só funciona se a tabela existir
SELECT * FROM UNIVERSIDADE.discente;