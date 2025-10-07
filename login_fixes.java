// Fixed login method - replace in your EmpresaController

@GetMapping("/login/{cnpj}")
public ResponseEntity<Object> realizarLogin(@PathVariable String cnpj, @RequestParam String senha) throws NoSuchAlgorithmException {
    try {
        // Debug: Log incoming data
        System.out.println("=== LOGIN DEBUG ===");
        System.out.println("CNPJ recebido: '" + cnpj + "'");
        System.out.println("Senha recebida: '" + senha + "'");
        
        // Clean CNPJ - ensure consistent format
        String cnpjLimpo = empresaService.limparCnpj(cnpj);
        System.out.println("CNPJ limpo: '" + cnpjLimpo + "'");
        
        // Try to find empresa
        Optional<Empresa> empresaOptional = empresaService.findByCnpj(cnpjLimpo);
        
        if (!empresaOptional.isPresent()) {
            System.out.println("ERRO: Empresa não encontrada para CNPJ: " + cnpjLimpo);
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body("{\"erro\": \"Empresa não encontrada.\"}");
        }
        
        Empresa empresa = empresaOptional.get();
        Usuario usuario = empresa.getUsuario();
        
        if (usuario == null) {
            System.out.println("ERRO: Usuario não encontrado para empresa");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body("{\"erro\": \"Dados de usuário não encontrados.\"}");
        }
        
        // Check if account is blocked
        if (!usuario.isStatus_usuario()) {
            System.out.println("ERRO: Conta bloqueada para CNPJ: " + cnpjLimpo);
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body("{\"erro\": \"Conta bloqueada. Entre em contato com o suporte.\"}");
        }
        
        // Encrypt password and compare
        String senhaCriptografada = criptografiaSenha.criptografarSenha(senha);
        String senhaArmazenada = usuario.getSenha_usuario();
        
        System.out.println("Senha criptografada: '" + senhaCriptografada + "'");
        System.out.println("Senha armazenada: '" + senhaArmazenada + "'");
        System.out.println("Senhas coincidem: " + senhaArmazenada.equals(senhaCriptografada));
        
        if (!senhaArmazenada.equals(senhaCriptografada)) {
            System.out.println("ERRO: Senha incorreta para CNPJ: " + cnpjLimpo);
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body("{\"erro\": \"CNPJ ou senha incorretos.\"}");
        }
        
        // Handle MFA if enabled
        if (usuario.getEmail_mfa_enabled() == EmailStatusEnum.ATIVO) {
            System.out.println("=== MFA ATIVO - PREPARANDO ENVIO EMAIL ===");
            String nome_usuario = usuario.getnome_usuario();
            String codigo = usuarioService.gerarToken();
            String email = usuario.getEmail();
            int duracao = 10;
            
            usuario.setEmail_code(codigo);
            usuario.setEmail_code_expires(LocalDateTime.now().plusMinutes(10));
            usuarioService.saveWithoutEncryption(usuario);
            
            try {
                emailServiceImpl.enviarEmailAuthMail(email, nome_usuario, codigo, duracao);
                System.out.println("Email MFA enviado com sucesso");
            } catch (Exception e) {
                System.err.println("ERRO ao enviar email MFA: " + e.getMessage());
                e.printStackTrace();
            }
        }
        
        System.out.println("LOGIN SUCESSO para CNPJ: " + cnpjLimpo);
        return ResponseEntity.ok(empresa);
        
    } catch (Exception e) {
        System.err.println("ERRO GERAL no login: " + e.getMessage());
        e.printStackTrace();
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
            .body("{\"erro\": \"Erro interno do servidor.\"}");
    }
}