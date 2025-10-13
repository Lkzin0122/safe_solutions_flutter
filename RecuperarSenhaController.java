package br.com.itb.miniprojetospring.controller;

import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.itb.miniprojetospring.model.Empresa;
import br.com.itb.miniprojetospring.service.EmpresaService;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600, allowCredentials = "false")
@RequestMapping("/empresa")
public class RecuperarSenhaController {

    @Autowired
    private EmpresaService empresaService;

    // Armazena códigos de recuperação temporariamente (em produção, usar Redis ou banco)
    private static final ConcurrentHashMap<String, String> codigosRecuperacao = new ConcurrentHashMap<>();

    @PostMapping("/recuperar-senha")
    public ResponseEntity<Object> recuperarSenha(@RequestBody RecuperarSenhaRequest request) {
        try {
            Optional<Empresa> empresaOptional = empresaService.findByCnpj(request.getCnpj());
            
            if (empresaOptional.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ErrorResponse("CNPJ não encontrado"));
            }

            Empresa empresa = empresaOptional.get();
            
            // Gerar código de recuperação
            String codigo = UUID.randomUUID().toString().substring(0, 6).toUpperCase();
            codigosRecuperacao.put(request.getCnpj(), codigo);
            
            // Simular envio de email (em produção, integrar com serviço de email)
            System.out.println("=== EMAIL DE RECUPERAÇÃO ===");
            System.out.println("Para: " + empresa.getEmail_empresa());
            System.out.println("Assunto: Recuperação de Senha - Safe Solutions");
            System.out.println("Código de recuperação: " + codigo);
            System.out.println("============================");
            
            return ResponseEntity.ok(new SuccessResponse("Código de recuperação enviado para o email cadastrado"));
            
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(new ErrorResponse("Erro interno do servidor"));
        }
    }

    @PostMapping("/validar-codigo")
    public ResponseEntity<Object> validarCodigo(@RequestBody ValidarCodigoRequest request) {
        try {
            String codigoArmazenado = codigosRecuperacao.get(request.getCnpj());
            
            if (codigoArmazenado == null || !codigoArmazenado.equals(request.getCodigo())) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(new ErrorResponse("Código inválido ou expirado"));
            }
            
            return ResponseEntity.ok(new SuccessResponse("Código validado com sucesso"));
            
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(new ErrorResponse("Erro interno do servidor"));
        }
    }

    @PostMapping("/redefinir-senha")
    public ResponseEntity<Object> redefinirSenha(@RequestBody RedefinirSenhaRequest request) {
        try {
            String codigoArmazenado = codigosRecuperacao.get(request.getCnpj());
            
            if (codigoArmazenado == null || !codigoArmazenado.equals(request.getCodigo())) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(new ErrorResponse("Código inválido ou expirado"));
            }

            Optional<Empresa> empresaOptional = empresaService.findByCnpj(request.getCnpj());
            
            if (empresaOptional.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ErrorResponse("Empresa não encontrada"));
            }

            Empresa empresa = empresaOptional.get();
            empresa.getUsuario().setSenha(request.getNovaSenha());
            empresaService.save(empresa);
            
            // Remove o código após uso
            codigosRecuperacao.remove(request.getCnpj());
            
            return ResponseEntity.ok(new SuccessResponse("Senha redefinida com sucesso"));
            
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(new ErrorResponse("Erro interno do servidor"));
        }
    }

    // Classes para requests e responses
    public static class RecuperarSenhaRequest {
        private String cnpj;
        
        public String getCnpj() { return cnpj; }
        public void setCnpj(String cnpj) { this.cnpj = cnpj; }
    }

    public static class ValidarCodigoRequest {
        private String cnpj;
        private String codigo;
        
        public String getCnpj() { return cnpj; }
        public void setCnpj(String cnpj) { this.cnpj = cnpj; }
        public String getCodigo() { return codigo; }
        public void setCodigo(String codigo) { this.codigo = codigo; }
    }

    public static class RedefinirSenhaRequest {
        private String cnpj;
        private String codigo;
        private String novaSenha;
        
        public String getCnpj() { return cnpj; }
        public void setCnpj(String cnpj) { this.cnpj = cnpj; }
        public String getCodigo() { return codigo; }
        public void setCodigo(String codigo) { this.codigo = codigo; }
        public String getNovaSenha() { return novaSenha; }
        public void setNovaSenha(String novaSenha) { this.novaSenha = novaSenha; }
    }

    public static class SuccessResponse {
        private String mensagem;
        
        public SuccessResponse(String mensagem) { this.mensagem = mensagem; }
        public String getMensagem() { return mensagem; }
    }

    public static class ErrorResponse {
        private String erro;
        
        public ErrorResponse(String erro) { this.erro = erro; }
        public String getErro() { return erro; }
    }
}