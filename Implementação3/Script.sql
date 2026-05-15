-- =========================================================
-- CONSULTAS COM JOIN - BANCO universidade
-- =========================================================

-- Caso queira usar os nomes das tabelas sem "universidade."
-- descomente a linha abaixo:
-- SET search_path TO universidade;


-- =========================================================
-- 1) Liste o nome das disciplinas que possuem turmas
-- INNER JOIN
-- =========================================================

SELECT DISTINCT 
    d.nome AS disciplina
FROM universidade.turma t
INNER JOIN universidade.disciplina d
ON t.cod_disc = d.cod_disc;


-- =========================================================
-- 2) Liste o nome do estudante e o nome de cada disciplina
-- das turmas que ele está cursando
-- INNER JOIN
-- =========================================================

SELECT 
    u.nome AS estudante,
    d.nome AS disciplina
FROM universidade.usuario u
INNER JOIN universidade.estudante e
ON u.cpf = e.cpf
INNER JOIN universidade.cursa c
ON e.mat_estudante = c.mat_estudante
INNER JOIN universidade.turma t
ON c.id_turma = t.id_turma
INNER JOIN universidade.disciplina d
ON t.cod_disc = d.cod_disc
ORDER BY u.nome, d.nome;


-- =========================================================
-- 3) Liste o nome do aluno e o nome de seu orientador
-- INNER JOIN
-- =========================================================

SELECT 
    ue.nome AS aluno,
    up.nome AS orientador
FROM universidade.estudante e
INNER JOIN universidade.plano pl
ON pl.mat_estudante = e.mat_estudante
INNER JOIN universidade.usuario ue
ON e.cpf = ue.cpf
INNER JOIN universidade.professor p
ON pl.mat_professor = p.mat_professor
INNER JOIN universidade.usuario up
ON p.cpf = up.cpf
ORDER BY ue.nome;


-- =========================================================
-- 4) Liste o nome da disciplina e o nome do seu pré-requisito
-- INNER JOIN / Auto JOIN
-- =========================================================

SELECT 
    d.nome AS disciplina,
    pre.nome AS pre_requisito
FROM universidade.disciplina d
INNER JOIN universidade.disciplina pre
ON d.pre_req = pre.cod_disc
ORDER BY d.nome;


-- =========================================================
-- 5) Liste o nome da disciplina, número da turma e nome do professor
-- das disciplinas que NÃO são pré-requisito
-- OUTER JOIN
-- =========================================================

SELECT 
    d.nome AS disciplina,
    t.numero AS numero_turma,
    u.nome AS professor
FROM universidade.disciplina d
LEFT JOIN universidade.disciplina pre
ON d.cod_disc = pre.pre_req
INNER JOIN universidade.turma t
ON d.cod_disc = t.cod_disc
INNER JOIN universidade.leciona l
ON t.id_turma = l.id_turma
INNER JOIN universidade.professor p
ON l.mat_professor = p.mat_professor
INNER JOIN universidade.usuario u
ON p.cpf = u.cpf
WHERE pre.cod_disc IS NULL
ORDER BY d.nome, t.numero, u.nome;


-- =========================================================
-- 6) Mesma consulta anterior, mas usando RIGHT JOIN
-- equivalente ao LEFT JOIN acima
-- =========================================================

SELECT 
    d.nome AS disciplina,
    t.numero AS numero_turma,
    u.nome AS professor
FROM universidade.disciplina pre
RIGHT JOIN universidade.disciplina d
ON d.cod_disc = pre.pre_req
INNER JOIN universidade.turma t
ON d.cod_disc = t.cod_disc
INNER JOIN universidade.leciona l
ON t.id_turma = l.id_turma
INNER JOIN universidade.professor p
ON l.mat_professor = p.mat_professor
INNER JOIN universidade.usuario u
ON p.cpf = u.cpf
WHERE pre.cod_disc IS NULL
ORDER BY d.nome, t.numero, u.nome;


-- Liste os nome dos professores e os nomes de seus orientandos (alunos que são -- orientados), inclusive os professores sem orientandos. - OUTER JOIN 

SELECT up.nome AS professor, ua.nome AS orientando
FROM universidade.professor p
LEFT JOIN universidade.usuario up
ON p.cpf = up.cpf
LEFT JOIN universidade.plano pl
ON pl.mat_professor = p.mat_professor
LEFT JOIN universidade.estudante e
ON pl.mat_estudante = e.mat_estudante
LEFT JOIN universidade.usuario ua
ON e.cpf = ua.cpf;



-- Liste os nomes de todos os alunos e os nomes dos professores, independente da orientação. - OUTER JOIN

SELECT ua.nome AS aluno, up.nome AS professor
FROM universidade.plano pl
FULL OUTER JOIN universidade.estudante e
ON pl.mat_estudante = e.mat_estudante
FULL OUTER JOIN universidade.professor p
ON pl.mat_professor = p.mat_professor
LEFT JOIN universidade.usuario ua
ON ua.cpf = e.cpf
LEFT JOIN universidade.usuario up
ON p.cpf = up.cpf;


-- Liste os nomes dos professores que não lecionam turmas. - OUTER JOIN

SELECT up.nome AS professor
FROM universidade.professor p
LEFT JOIN universidade.leciona l
ON p.mat_professor = l.mat_professor
LEFT JOIN universidade.usuario up
ON p.cpf = up.cpf
WHERE id_turma IS NULL;

-- Liste o nome das disciplinas das turmas que não tem alunos cursando. - OUTER JOIN

SELECT d.nome AS disciplinas
FROM universidade.turma t
LEFT JOIN universidade.cursa c
ON t.id_turma = c.id_turma
LEFT JOIN universidade.disciplina d
ON t.cod_disc = d.cod_disc
WHERE c.mat_estudante IS NULL;
