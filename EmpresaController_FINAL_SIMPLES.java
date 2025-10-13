// Adicione apenas estes 2 métodos no seu EmpresaController existente:

private static final java.util.Map<String, String> codigosRecuperacao = new java.util.HashMap<>();

@PostMapping("/recuperar-senha")
public ResponseEntity<String> recuperarSenha(@RequestBody java.util.Map<String, String> request) {
    String email = request.get("email");
    String codigo = "123456789"; // Código fixo para teste
    codigosRecuperacao.put(email, codigo);
    
    System.out.println("CÓDIGO: " + codigo + " PARA EMAIL: " + email);
    
    return ResponseEntity.ok("ok");
}

@PostMapping("/validar-codigo")
public ResponseEntity<String> validarCodigoRecuperacao(@RequestBody java.util.Map<String, String> request) {
    String email = request.get("email");
    String codigo = request.get("codigo");
    
    if ("123456789".equals(codigo)) {
        return ResponseEntity.ok("ok");
    }
    
    return ResponseEntity.status(400).body("erro");
}