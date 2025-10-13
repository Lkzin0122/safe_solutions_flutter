# Problema: Serviços não aparecem para empresa logada

## Possíveis causas no backend Java:

### 1. **Endpoint `/servico/empresa/{cnpj}` não implementado ou com problema**
- Verificar se existe o método `getServicosByEmpresa` no `ServicoController`
- Código de exemplo está em `servico_controller_fix.java`

### 2. **Problema no ServicoService**
- Método `findByEmpresaId(Long empresaId)` pode não existir
- Implementação está em `servico_controller_fix.java`

### 3. **Problema no ServicoRepository**
- Query `findByEmpresaId(Long empresaId)` pode não existir
- Adicionar: `List<Servico> findByEmpresaId(Long empresaId);`

### 4. **Problema no relacionamento Empresa-Servico**
- Verificar se o campo `empresa_id` está correto na tabela `servico`
- Executar queries em `debug_servicos.sql`

### 5. **Serviços salvos com status inativo**
- Verificar se `status_servico` está sendo salvo como `true`
- Query: `SELECT * FROM servico WHERE status_servico = false;`

### 6. **Problema de CORS**
- Adicionar `@CrossOrigin(origins = "*")` no controller

## Como debugar:

1. **Execute as queries SQL** em `debug_servicos.sql` no seu banco
2. **Verifique os logs** do backend quando chamar `/servico/empresa/666666666666666`
3. **Teste diretamente** a API via Postman/Insomnia:
   ```
   GET http://localhost:8080/servico/empresa/666666666666666
   ```

## Soluções rápidas:

1. **Copie o código** de `servico_controller_fix.java` para seu `ServicoController`
2. **Adicione os métodos** faltantes no `ServicoService` e `ServicoRepository`
3. **Execute as queries** para verificar se os dados estão no banco
4. **Reinicie** o servidor backend

## Teste no Flutter:

Use o botão de teste (ícone de bug) na página de serviços para verificar se a API está respondendo corretamente.