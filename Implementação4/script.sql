--  Listar o CPF e sobrenome de todos os usuários que possuem a sílaba “sa" em seu 
-- sobrenome. 

-- SELECT 
--     cpf,
--     sobrenome
-- FROM hospital.usuario
-- WHERE sobrenome LIKE '%sa%';

 -- Listar a quantidade de pessoas que possuem sobrenome com a inicial “S”.
 
--  SELECT count(sobrenome) FROM hospital.usuario
--  WHERE sobrenome LIKE 'S%';
 
 
--  2.3 Listar o nome e CPF de todos os pacientes. - INNER JOIN 
-- SELECT up.primeiroNome, up.sobrenome, up.cpf
-- FROM hospital.paciente p
-- INNER JOIN hospital.usuario up
-- ON p.cpf = up.cpf


-- 2.4 Listar a soma de todos os salários dos médicos, porém apenas os que possuem 
-- cadastro ativo. - INNER JOIN 

-- SELECT SUM(m.salario)
-- FROM hospital.medico m
-- INNER JOIN hospital.usuario u
-- ON m.cpf = u.cpf
-- INNER JOIN hospital.perfil p
-- ON u.idPerfil = p.idPerfil
-- WHERE p.ativo = 'S';

-- 2.5 Listar o nome e CPF dos pacientes, seguido do nome e CPF dos seus acompanhantes. - INNER JOIN 

-- SELECT up.primeiroNome, up.cpf, ua.primeiroNome, ua.cpf
-- FROM hospital.paciente p
-- INNER JOIN hospital.usuario up
-- ON p.cpf = up.cpf
-- INNER JOIN hospital.acompanhante a
-- ON p.cpfAcomp = a.cpf
-- INNER JOIN hospital.usuario ua
-- ON a.cpf = ua.cpf

-- 2.6 Listar o nome e CPF de todos os pacientes que realizaram consulta. - INNER JOIN 

SELECT DISTINCT up.primeiroNome, up.sobrenome, up.cpf
FROM hospital.consulta c
INNER JOIN hospital.paciente p
ON c.numProntuario = p.numProntuario
INNER JOIN hospital.usuario up
ON p.cpf = up.cpf