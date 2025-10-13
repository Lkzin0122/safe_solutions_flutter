package com.safesolutions.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
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

    private final Map<String, String> codigosRecuperacao = new ConcurrentHashMap<>();

    @PostMapping("/recuperar-senha")
    public ResponseEntity<?> recuperarSenha(@RequestBody Map<String, String> request) {
        try {
            String email = request.get("email");
            
            // Simular busca de empresa (sempre encontra para teste)
            String codigo = String.format("%09d", new Random().nextInt(1000000000));
            codigosRecuperacao.put(email, codigo);
            
            // Log do código no console para teste
            System.out.println("CÓDIGO PARA " + email + ": " + codigo);
            
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