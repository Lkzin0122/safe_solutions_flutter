// Adicione estes imports no topo do EmpresaController:
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

// Adicione esta variável como campo da classe EmpresaController:
private static final ConcurrentHashMap<String, String> codigosRecuperacao = new ConcurrentHashMap<>();

// Adicione estes métodos no final da classe EmpresaController:

@PostMapping("/recuperar-senha")
public ResponseEntity<Object> recuperarSenha(@RequestBody java.util.Map<String, String> request) {
    try {
        String cnpj = request.get("cnpj");
        Optional<Empresa> empresaOptional = empresaService.findByCnpj(cnpj);
        
        if (empresaOptional.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body("{\"erro\": \"CNPJ não encontrado\"}");
        }

        Empresa empresa = empresaOptional.get();
        
        // Gerar código de recuperação
        String codigo = UUID.randomUUID().toString().substring(0, 6).toUpperCase();
        codigosRecuperacao.put(cnpj, codigo);
        
        // Simular envio de email
        System.out.println("=== EMAIL DE RECUPERAÇÃO ===");
        System.out.println("Para: " + empresa.getUsuario().getEmail());
        System.out.println("Código de recuperação: " + codigo);
        System.out.println("============================");
        
        return ResponseEntity.ok("{\"mensagem\": \"Código de recuperação enviado para o email cadastrado\"}");
        
    } catch (Exception e) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
            .body("{\"erro\": \"Erro interno do servidor\"}");
    }
}