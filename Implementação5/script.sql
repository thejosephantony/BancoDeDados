-- SELECT ...
-- FROM ...
-- WHERE coluna IN (
--     SELECT ...
--     FROM ...
--     WHERE ...
-- );

-- Liste a matrícula do estudante (mat_estudante) de todos os estudantes que são 
-- orientados pelo professor P200 e que estão cursando alguma turma em que o professor 
-- P500 leciona.

-- SELECT p.mat_estudante
-- FROM universidade.plano p
-- WHERE p.mat_professor = 'P200' 
--   AND p.mat_estudante IN (
--       SELECT c.mat_estudante
--       FROM universidade.cursa c
--       INNER JOIN universidade.turma t
--           ON c.id_turma = t.id_turma
--       INNER JOIN universidade.leciona l
--           ON t.id_turma = l.id_turma
--       WHERE l.mat_professor = 'P500'
--   );
-- Liste a matrícula de todos os professores que não orientam alunos ou que são chefes de algum departamento.
-- SELECT p.mat_professor
-- FROM universidade.professor p
-- WHERE p.mat_professor NOT IN (
--   SELECT pl.mat_professor
--   FROM universidade.plano pl
-- )
-- OR p.mat_professor IN(
--   SELECT d.chefe
--   FROM universidade.departamento d
--   WHERE d.chefe IS NOT NULL
-- );

-- Liste a matrícula de todos os professores que orientam algum aluno e que são chefes de algum departamento.
-- SELECT p.mat_professor
-- FROM universidade.professor p 
-- WHERE p.mat_professor IN(
--   SELECT pl.mat_professor
--   FROM universidade.plano pl)
-- AND p.mat_professor IN(
--   SELECT d.chefe
--   FROM universidade.departamento d
--   WHERE d.chefe IS NOT NULL
-- )

--  Liste a matrícula de todos os professores que não orientam alunos e que não são 
-- chefes de algum departamento.
-- SELECT p.mat_professor
-- FROM universidade.professor p
-- WHERE p.mat_professor NOT IN(
--   SELECT pl.mat_professor
--   FROM universidade.plano pl
-- )
-- AND p.mat_professor NOT IN(
--   SELECT d.chefe
--   FROM universidade.departamento d
--   WHERE d.chefe IS NOT NULL
-- );

 -- Liste a menor média de salários dentre todos os departamentos
SELECT MIN(media_salario) AS menor_media_salarios
FROM (
    SELECT departamento, AVG(salario) AS media_salario
    FROM universidade.professor
    GROUP BY departamento
) medias;

--  Liste a matrícula do professor, a média de notas de cada professor entre todas as suas 
-- turmas, o departamento do professor e a média do departamento que ele faz parte. 

SELECT p.mat_professor, p.media_notas, p.departamento, d.media_dpt
FR
