# Troubleshooting - Erro de Login

## Problema
Erro "CNPJ ou senha incorretos" mesmo com dados corretos.

## Possíveis Causas e Soluções

### 1. **Verificar Backend**
- Certifique-se que o backend Spring Boot está rodando na porta 8080
- Teste: `http://localhost:8080/empresa` deve retornar lista de empresas

### 2. **Verificar Dados no Banco**
Execute estas queries no seu banco de dados:

```sql
-- Verificar se a empresa existe
SELECT cnpj, nome_empresa FROM empresa WHERE cnpj = 'SEU_CNPJ_AQUI';

-- Verificar usuário da empresa
SELECT u.nome_usuario, u.email, u.status_usuario, u.senha_usuario 
FROM usuario u 
JOIN empresa e ON e.usuario_id = u.id 
WHERE e.cnpj = 'SEU_CNPJ_AQUI';
```

### 3. **Problemas Comuns**

#### A. **Formato do CNPJ**
- O app remove formatação automaticamente
- Certifique-se que no banco está sem pontos/barras
- Exemplo: `12345678000195` (não `12.345.678/0001-95`)

#### B. **Senha Criptografada**
- Verifique se a senha no banco está criptografada corretamente
- O backend deve usar o mesmo algoritmo de criptografia

#### C. **Status do Usuário**
- Verifique se `status_usuario` está `true` no banco
- Usuários bloqueados não conseguem fazer login

#### D. **Espaços em Branco**
- O app agora remove espaços da senha automaticamente
- Verifique se não há espaços extras na senha

### 4. **Debug Detalhado**
O app agora inclui debug detalhado. Verifique o console para:
- CNPJ formatado corretamente
- Empresa encontrada no banco
- Status do usuário
- Comparação de senhas

### 5. **Teste Manual da API**
Use um cliente REST (Postman, Insomnia) para testar:

```
GET http://localhost:8080/empresa/login/12345678000195?senha=suasenha
```

### 6. **Verificar Logs do Backend**
O arquivo `login_fixes.java` inclui logs detalhados. Verifique:
- Se a empresa foi encontrada
- Se as senhas coincidem após criptografia
- Se há erros de MFA

## Como Usar o Debug

1. Faça login normalmente no app
2. Verifique o console do Flutter para logs detalhados
3. Compare com os logs do backend Spring Boot
4. Identifique onde está falhando

## Soluções Rápidas

### Se a empresa não existe:
```sql
INSERT INTO empresa (cnpj, nome_empresa, ...) VALUES ('12345678000195', 'Sua Empresa', ...);
```

### Se o usuário está bloqueado:
```sql
UPDATE usuario SET status_usuario = true WHERE id = SEU_ID_USUARIO;
```

### Se a senha está incorreta no banco:
- Use a mesma criptografia do backend
- Ou redefina a senha através do sistema