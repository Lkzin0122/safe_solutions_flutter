package br.com.itb.miniprojetospring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailServiceImpl implements EmailService {

    @Autowired
    private JavaMailSender mailSender;

    @Override
    public void enviarEmailRecuperacao(String email, String nomeUsuario, String token) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email); // Envia para o email do usuário
            message.setSubject("Safe Solutions - Recuperação de Senha");
            message.setText("Olá " + nomeUsuario + ",\n\n" +
                          "Seu código de recuperação é: " + token + "\n\n" +
                          "Este código é válido por 10 minutos.\n\n" +
                          "Safe Solutions");
            message.setFrom("noreply@safesolutions.com");
            
            mailSender.send(message);
            System.out.println("Email de recuperação enviado para: " + email);
            
        } catch (Exception e) {
            System.err.println("Erro ao enviar email de recuperação: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void enviarEmailAuthMail(String email, String nomeUsuario, String codigo, int duracao) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email); // Envia para o email do usuário
            message.setSubject("Safe Solutions - Código de Verificação");
            message.setText("Olá " + nomeUsuario + ",\n\n" +
                          "Seu código de verificação é: " + codigo + "\n\n" +
                          "Este código é válido por " + duracao + " minutos.\n\n" +
                          "Safe Solutions");
            message.setFrom("noreply@safesolutions.com");
            
            mailSender.send(message);
            System.out.println("Email de autenticação enviado para: " + email);
            
        } catch (Exception e) {
            System.err.println("Erro ao enviar email de autenticação: " + e.getMessage());
            e.printStackTrace();
        }
    }
}