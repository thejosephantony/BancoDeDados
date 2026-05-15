CREATE SCHEMA cinema;

CREATE TABLE cinema.usuario (
    login VARCHAR(50) PRIMARY KEY,
    senha VARCHAR(50),
    data_cadastro DATE,
    email VARCHAR(100)
);

CREATE TABLE cinema.cargo (
    id_cargo INT PRIMARY KEY,
    descricao VARCHAR(100),
    salario NUMERIC(10,2)
);

CREATE TABLE cinema.estudio (
    id_estudio INT PRIMARY KEY,
    nome VARCHAR(100),
    patrimonio NUMERIC(12,2)
);

CREATE TABLE cinema.diretor (
    id_diretor INT PRIMARY KEY,
    login VARCHAR(50),
    cargo INT,
    estudio INT,
    FOREIGN KEY (login) REFERENCES cinema.usuario(login),
    FOREIGN KEY (cargo) REFERENCES cinema.cargo(id_cargo),
    FOREIGN KEY (estudio) REFERENCES cinema.estudio(id_estudio)
);

CREATE TABLE cinema.assinante (
    id_assinante INT PRIMARY KEY,
    login VARCHAR(50),
    FOREIGN KEY (login) REFERENCES cinema.usuario(login)
);

CREATE TABLE cinema.filme (
    id_filme INT PRIMARY KEY,
    titulo VARCHAR(100),
    filme_anterior INT,
    estudio INT,
    FOREIGN KEY (filme_anterior) REFERENCES cinema.filme(id_filme),
    FOREIGN KEY (estudio) REFERENCES cinema.estudio(id_estudio)
);

CREATE TABLE cinema.direcao (
    id_filme INT,
    id_diretor INT,
    PRIMARY KEY (id_filme, id_diretor),
    FOREIGN KEY (id_filme) REFERENCES cinema.filme(id_filme),
    FOREIGN KEY (id_diretor) REFERENCES cinema.diretor(id_diretor)
);

CREATE TABLE cinema.avaliacao (
    id_assinante INT,
    id_filme INT,
    nota NUMERIC(3,1),
    valor_pago NUMERIC(10,2),
    PRIMARY KEY (id_assinante, id_filme),
    FOREIGN KEY (id_assinante) REFERENCES cinema.assinante(id_assinante),
    FOREIGN KEY (id_filme) REFERENCES cinema.filme(id_filme)  
);
INSERT INTO cinema.usuario VALUES
('ana', '123', '1975-04-10', 'ana@email.com'),
('bruno', '123', '1982-07-21', 'bruno@email.com'),
('carla', '123', '1991-02-15', 'carla@email.com'),
('daniel', '123', '2001-11-30', 'daniel@email.com'),
('eduarda', '123', '1988-05-05', 'eduarda@email.com'),
('felipe', '123', '1969-09-12', 'felipe@email.com'),
('giovana', '123', '1995-01-19', 'giovana@email.com'),
('henrique', '123', '1980-12-01', 'henrique@email.com');

INSERT INTO cinema.cargo VALUES
(1, 'Diretor Principal', 12000.00),
(2, 'Diretor Assistente', 7500.00),
(3, 'Produtor Executivo', 15000.00);

INSERT INTO cinema.estudio VALUES
(1, 'PIXAR', 9000000.00),
(2, 'DREAMWORKS', 7000000.00),
(3, 'GHIBLI', 5000000.00);

INSERT INTO cinema.diretor VALUES
(1, 'ana', 1, 1),
(2, 'bruno', 2, 1),
(3, 'carla', 1, 2),
(4, 'daniel', 3, 3),
(5, 'felipe', 2, 2);

INSERT INTO cinema.assinante VALUES
(1, 'eduarda'),
(2, 'giovana'),
(3, 'henrique'),
(4, 'carla'),
(5, 'bruno');

INSERT INTO cinema.filme VALUES
(1, 'Toy Planet', NULL, 1),
(2, 'Toy Planet 2', 1, 1),
(3, 'Dragons Fire', NULL, 2),
(4, 'Dragons Fire 2', 3, 2),
(5, 'Castle Wind', NULL, 3),
(6, 'Castle Wind Return', 5, 3);

INSERT INTO cinema.direcao VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 3),
(4, 3),
(5, 4);

INSERT INTO cinema.avaliacao VALUES
(1, 1, 9.0, 20.00),
(2, 1, 8.5, 25.00),
(3, 1, 7.0, 18.00),
(1, 2, 9.5, 30.00),
(2, 2, 8.0, 28.00),
(3, 2, 9.0, 32.00),
(4, 2, 7.5, 22.00),
(1, 3, 8.0, 19.00),
(2, 3, 7.0, 21.00),
(1, 4, 9.0, 26.00),
(2, 5, 10.0, 35.00),
(3, 5, 9.5, 33.00);