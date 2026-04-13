CREATE SCHEMA universidade;

CREATE TYPE universidade.tipo_status_discente 
AS ENUM ('ATIVO', 'CANCELADO', 'TRANCADO', 'GRADUADO');

CREATE TABLE universidade.discente(
    matricula VARCHAR(20) PRIMARY KEY,
    nome_discente VARCHAR(255) NOT NULL,
    ano_ingresso SMALLINT,
    periodo_ingresso SMALLINT,
    status_discente universidade.tipo_status_discente,
    nome_curso VARCHAR(255)
);

INSERT INTO universidade.discente
(matricula, nome_discente, ano_ingresso, periodo_ingresso, status_discente, nome_curso)
VALUES
('2023000387801', 'Joseph', 2023, 1 , 'ATIVO', 'ENGENHARIA DA COMPUTAÇÃO'),

('18200002112', 'Pedro de Alcântara Francisco Antônio João Carlos Xavier de Paula Miguel Rafael Joaquim José Gonzaga Pascoal Cipriano Serafim de Bragança e Bourbon', 1820, 1, 'ATIVO', 'DIREITO'),

('202500032413','ÁBIAN MACHADO',2025,1,'ATIVO', 'Engenharia de Computação Bacharelado/São Cristóvão (Vespertino)'),

('2025000324133','ALUNO 2',2025,2,'ATIVO','Engenharia de Computação Bacharelado/São Cristóvão (Vespertino)'),

('2025000324132','b',2025,1,'ATIVO','Engenharia de Computação Bacharelado/São Cristóvão (Vespertino)'),

('1','a',NULL, NULL , NULL,  NULL),

('20250003241329','c',2025,1,'ATIVO','Engenharia de Computação Bacharelado/São Cristóvão (Vespertino)');