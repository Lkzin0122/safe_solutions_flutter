// Adicione estes métodos no seu EmpresaController existente:

@CrossOrigin(origins = "*")
@PostMapping("/recuperar-senha")
public ResponseEntity<String> recuperarSenha(@RequestBody java.util.Map<String, String> request) {
    try {
        String email = request.get("email");
        
        // Gerar código de 9 dígitos
        String codigo = String.format("%09d", new java.util.Random().nextInt(1000000000));
        codigosRecuperacao.put(email, codigo);
        
        // Log do código no console
        System.out.println("=== CÓDIGO DE RECUPERAÇÃO ===");
        System.out.println("Email: " + email);
        System.out.println("Código: " + codigo);
        System.out.println("=============================");
        
        return ResponseEntity.ok("Código enviado");
        
    } catch (Exception e) {
        e.printStackTrace();
        return ResponseEntity.ok("Código enviado"); // Sempre retorna sucesso para teste
    }
}

@CrossOrigin(origins = "*")
@PostMapping("/validar-codigo")
public ResponseEntity<String> validarCodigoRecuperacao(@RequestBody java.util.Map<String, String> request) {
    try {
        String email = request.get("email");
        String codigo = request.get("codigo");
        
        String codigoArmazenado = codigosRecuperacao.get(email);
        
        if (codigoArmazenado != null && codigoArmazenado.equals(codigo)) {
            return ResponseEntity.ok("Código válido");
        } else {
            return ResponseEntity.status(400).body("Código inválido");
        }
        
    } catch (Exception e) {
        return ResponseEntity.status(400).body("Código inválido");
    }
}