-- Queries para debugar problema dos serviços

-- 1. Verificar se a empresa existe
SELECT id, cnpj, nome_empresa FROM empresa WHERE cnpj = '666666666666666';

-- 2. Verificar todos os serviços cadastrados
SELECT id, nome_servico, categoria_servico, status_servico, empresa_id FROM servico;

-- 3. Verificar serviços da empresa específica
SELECT s.id, s.nome_servico, s.categoria_servico, s.status_servico, e.nome_empresa, e.cnpj
FROM servico s 
JOIN empresa e ON s.empresa_id = e.id 
WHERE e.cnpj = '666666666666666';

-- 4. Verificar se há problema de relacionamento
SELECT 
    e.id as empresa_id,
    e.cnpj,
    e.nome_empresa,
    COUNT(s.id) as total_servicos
FROM empresa e 
LEFT JOIN servico s ON s.empresa_id = e.id 
WHERE e.cnpj = '666666666666666'
GROUP BY e.id, e.cnpj, e.nome_empresa;

-- 5. Verificar estrutura da tabela servico
DESCRIBE servico;

-- 6. Verificar se há serviços com status inativo
SELECT id, nome_servico, status_servico, empresa_id FROM servico WHERE status_servico = false;