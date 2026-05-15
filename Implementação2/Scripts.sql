-- 1.1 Liste o cpf dos professores do departamento ‘DMA”.

-- SELECT cpf FROM universidade.professor
-- WHERE departamento = 'DMA'

-- 1.2 Liste o id de todas as turmas que o aluno de matrícula ‘E101’ está cursando.
SELECT id_turma FROM universidade.aluno
WHERE mat_estudante = 'E101';

-- 1.3 Liste o nome e cpf de todos os usuários que têm telefone. 
SELECT nome, cpf FROM universidade.usuario
WHERE telefone IS NOT NULL;

-- 1.4 Liste o nome e código de todas as disciplinas que tenham pré-requisito e tenham mais de 2 créditos.
SELECT nome, cod_disc FROM universidade.disciplina
WHERE pre_req is NOT NULL AND creditos > 2

-- 1.5 Calcule a média de notas de todos os alunos.
SELECT avg(nota) AS media_total_notas FROM universidade.cursa

-- 1.6 Listar o número de professores que orientam algum aluno - 
-- Um professor orienta um aluno se ambos estão associados na tabela plano
SELECT COUNT(DISTINCT mat_professor) FROM universidade.plano

-- 1.7
-- Listar a matrícula de todos os professores que orientam algum aluno ou  que são 
-- chefes de algum departamento.
SELECT mat_professor FROM universidade.plano

UNION

SELECT mat_professor FROM universidade.departamento
WHERE chefe IS NOT NULL;

-- 1.8 
-- Listar a matrícula de todos os professores que orientam algum aluno e  que são 
-- chefes de algum departamento.
SELECT mat_professor FROM universidade.plano

INTERSECT

SELECT mat_professor FROM universidade.departamento
WHERE chefe IS NOT NULL;
-- 1.9 
-- Listar a matrícula de todos os professores que orientam algum aluno e  que não são 
-- chefes de algum departamento.
SELECT mat_professor FROM universidade.plano

EXCEPT

SELECT mat_professor FROM universidade.departamento
WHERE chefe IS NOT NULL;