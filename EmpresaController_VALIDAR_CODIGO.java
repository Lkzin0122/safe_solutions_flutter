// Adicione este método no EmpresaController:

@CrossOrigin(origins = "*")
@PostMapping("/validar-codigo")
public ResponseEntity<Object> validarCodigo(@RequestBody java.util.Map<String, String> request) {
    try {
        String email = request.get("email");
        String codigo = request.get("codigo");
        
        String codigoArmazenado = codigosRecuperacao.get(email);
        
        if (codigoArmazenado == null || !codigoArmazenado.equals(codigo)) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body("{\"erro\": \"Código inválido ou expirado\"}");
        }
        
        return ResponseEntity.ok("{\"mensagem\": \"Código validado com sucesso\"}");
        
    } catch (Exception e) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
            .body("{\"erro\": \"Erro interno do servidor\"}");
    }
}