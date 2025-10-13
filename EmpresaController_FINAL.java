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

    private final Map<String, String> codigosRecuperacao = new ConcurrentHashMap<>();

    @PostMapping("/recuperar-senha")
    public ResponseEntity<?> recuperarSenha(@RequestBody Map<String, String> request) {
        try {
            String email = request.get("email");
            
            Empresa empresa = empresaRepository.findByUsuario_Email(email);
            if (empresa == null) {
                return ResponseEntity.status(404).body("Email não encontrado");
            }

            String codigo = String.format("%09d", new Random().nextInt(1000000000));
            codigosRecuperacao.put(email, codigo);
            
            // Enviar email
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("Safe Solutions - Código de Recuperação");
            message.setText("Seu código de recuperação é: " + codigo);
            message.setFrom("noreply@safesolutions.com");
            mailSender.send(message);
            
            return ResponseEntity.ok("Código enviado");
            
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("Erro interno");
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
                return ResponseEntity.status(400).body("Código inválido");
            }
            
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Erro interno");
        }
    }
}