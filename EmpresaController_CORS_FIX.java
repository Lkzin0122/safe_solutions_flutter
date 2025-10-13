// Substitua o método recuperar-senha no EmpresaController por este (com CORS):

@CrossOrigin(origins = "*")
@PostMapping("/recuperar-senha")
public ResponseEntity<Object> recuperarSenha(@RequestBody java.util.Map<String, String> request) {
    try {
        String email = request.get("email");
        
        // Buscar empresa pelo email do usuário
        List<Empresa> todasEmpresas = empresaService.findAll();
        Optional<Empresa> empresaOptional = todasEmpresas.stream()
            .filter(empresa -> empresa.getUsuario() != null && 
                     email.equals(empresa.getUsuario().getEmail()))
            .findFirst();
        
        if (empresaOptional.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body("{\"erro\": \"Email não encontrado\"}");
        }

        Empresa empresa = empresaOptional.get();
        
        // Gerar código de recuperação
        String codigo = UUID.randomUUID().toString().substring(0, 6).toUpperCase();
        codigosRecuperacao.put(email, codigo);
        
        // Simular envio de email
        System.out.println("=== EMAIL DE RECUPERAÇÃO ===");
        System.out.println("Para: " + email);
        System.out.println("Empresa: " + empresa.getNome_empresa());
        System.out.println("Código de recuperação: " + codigo);
        System.out.println("============================");
        
        return ResponseEntity.ok("{\"mensagem\": \"Código de recuperação enviado para o email cadastrado\"}");
        
    } catch (Exception e) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
            .body("{\"erro\": \"Erro interno do servidor\"}");
    }
}