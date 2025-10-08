-- Debug queries to check your database

-- 1. Check if empresa exists
SELECT cnpj, nome_empresa FROM empresa WHERE cnpj LIKE '%YOUR_CNPJ%';

-- 2. Check usuario data
SELECT u.cpf, u.nome_usuario, u.email, u.status_usuario 
FROM usuario u 
JOIN empresa e ON e.usuario_id = u.id 
WHERE e.cnpj = 'YOUR_CNPJ';