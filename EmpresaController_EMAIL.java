package com.safesolutions.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import com.safesolutions.model.Empresa;
import com.safesolutions.repository.EmpresaRepository;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.Random;

@RestController
@RequestMapping("/empresa")
@CrossOrigin(origins = "*")
public class EmpresaController {

    @Autowired
    private EmpresaRepository empresaRepository;

    @Autowired
    private JavaMailSender mailSender;

    // Armazenar códigos temporariamente (em produção, use Redis ou banco)
    private final Map<String, String> codigosRecuperacao = new ConcurrentHashMap<>();

    @PostMapping("/recuperar-senha")
    public ResponseEntity<?> recuperarSenha(@RequestBody Map<String, String> request) {
        try {
            String email = request.get("email");
            
            // Buscar empresa pelo email
            Empresa empresa = empresaRepository.findByUsuario_Email(email);
            if (empresa == null) {
                return ResponseEntity.status(404).body("Email não encontrado");
            }

            // Gerar código de 6 dígitos
            String codigo = String.format("%06d", new Random().nextInt(1000000));
            
            // Armazenar código (válido por 10 minutos)
            codigosRecuperacao.put(email, codigo);
            
            // Enviar email
            enviarEmailRecuperacao(email, codigo);
            
            return ResponseEntity.ok("Código enviado para o email");
            
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("Erro interno do servidor");
        }
    }

    @PostMapping("/validar-codigo")
    public ResponseEntity<?> validarCodigo(@RequestBody Map<String, String> request) {
        try {
            String email = request.get("email");
            String codigo = request.get("codigo");
            
            String codigoArmazenado = codigosRecuperacao.get(email);
            
            if (codigoArmazenado != null && codigoArmazenado.equals(codigo)) {
                return ResponseEntity.ok("Código válido");
            } else {
                return ResponseEntity.status(400).body("Código inválido ou expirado");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("Erro interno do servidor");
        }
    }

    @PostMapping("/nova-senha")
    public ResponseEntity<?> novaSenha(@RequestBody Map<String, String> request) {
        try {
            String email = request.get("email");
            String codigo = request.get("codigo");
            String novaSenha = request.get("novaSenha");
            
            // Validar código novamente
            String codigoArmazenado = codigosRecuperacao.get(email);
            if (codigoArmazenado == null || !codigoArmazenado.equals(codigo)) {
                return ResponseEntity.status(400).body("Código inválido");
            }
            
            // Buscar empresa
            Empresa empresa = empresaRepository.findByUsuario_Email(email);
            if (empresa == null) {
                return ResponseEntity.status(404).body("Empresa não encontrada");
            }
            
            // Atualizar senha
            empresa.getUsuario().setSenha(novaSenha);
            empresaRepository.save(empresa);
            
            // Remover código usado
            codigosRecuperacao.remove(email);
            
            return ResponseEntity.ok("Senha alterada com sucesso");
            
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("Erro interno do servidor");
        }
    }

    private void enviarEmailRecuperacao(String email, String codigo) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("Safe Solutions - Recuperação de Senha");
            message.setText("Seu código de recuperação é: " + codigo + "\n\nEste código é válido por 10 minutos.");
            message.setFrom("noreply@safesolutions.com");
            
            mailSender.send(message);
            System.out.println("Email enviado para: " + email + " com código: " + codigo);
            
        } catch (Exception e) {
            System.err.println("Erro ao enviar email: " + e.getMessage());
            e.printStackTrace();
        }
    }
}