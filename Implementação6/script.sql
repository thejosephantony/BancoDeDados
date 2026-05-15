-- 1)
-- SELECT login FROM cinema.usuario
-- WHERE data_cadastro >= DATE '1980-01-01'
-- ORDER BY email ASC;

-- 2)Para cada filme cadastrado, liste o e-mail dos assinantes que avaliaram o filme, o e-mail dos diretores que dirigiram o filme e o título do filme, somente dos filmes cujo estúdio seja 'PIXAR'.
-- SELECT a.email AS email_assinante,
--        d.email AS email_diretor,
--        f.titulo
-- FROM cinema.filme f
-- INNER JOIN cinema.estudio e
--     ON f.estudio = e.id_estudio
-- INNER JOIN cinema.avaliacao ava
--     ON f.id_filme = ava.id_filme
-- INNER JOIN cinema.assinante ass
--     ON ava.id_assinante = ass.id_assinante
-- INNER JOIN cinema.usuario a
--     ON ass.login = a.login
-- INNER JOIN cinema.direcao di
--     ON f.id_filme = di.id_filme
-- INNER JOIN cinema.diretor dr
--     ON di.id_diretor = dr.id_diretor
-- INNER JOIN cinema.usuario d
--     ON dr.login = d.login
-- WHERE e.nome = 'PIXAR';

-- Liste o título do filme e o título do seu filme anterior, somente daqueles filmes que possuem filme anterior cadastrado.

-- SELECT f.titulo, fa.filme_anterior
-- FROM cinema.filme f
-- INNER JOIN cinema.filme fa
-- ON f.filme_anterior = fa.id_filme;


-- Liste o login e o nome do estúdio dos diretores que não possuem direção cadastrada.

SELECT dir.login,
       es.nome AS estudio
FROM cinema.diretor dir
INNER JOIN cinema.estudio es
    ON dir.estudio = es.id_estudio
LEFT JOIN cinema.direcao di
    ON dir.id_diretor = di.id_diretor
WHERE di.id_diretor IS NULL;
