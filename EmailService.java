package br.com.itb.miniprojetospring.service;

public interface EmailService {
    void enviarEmailRecuperacao(String email, String nomeUsuario, String token);
}