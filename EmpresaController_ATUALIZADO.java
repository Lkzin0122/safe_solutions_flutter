package br.com.itb.miniprojetospring.controller;

import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import br.com.itb.miniprojetospring.Errors.InvalidDataException;
import br.com.itb.miniprojetospring.model.Empresa;
import br.com.itb.miniprojetospring.model.Usuario;
import br.com.itb.miniprojetospring.model.enums.EmailStatusEnum;
import br.com.itb.miniprojetospring.service.CriptografiaSenha;
import br.com.itb.miniprojetospring.service.EmailServiceImpl;
import br.com.itb.miniprojetospring.service.EmpresaService;
import br.com.itb.miniprojetospring.service.UsuarioService;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600, allowCredentials = "false")
@RequestMapping("/empresa")
public class EmpresaController {

    @Autowired
    private EmpresaService empresaService;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private CriptografiaSenha criptografiaSenha;
    @Autowired
    private EmailServiceImpl emailServiceImpl;

    // Armazena códigos de recuperação temporariamente
    private static final ConcurrentHashMap<String, String> codigosRecuperacao = new ConcurrentHashMap<>();

    // ==========================
    // 🧑💼 Criação de Empresa
    // ==========================

    @PostMapping
    public ResponseEntity<Empresa> createEmpresa(@RequestBody Empresa empresa, @RequestParam String cpfUsuario) {
        Optional<Usuario> usuarioOptional = usuarioService.findByCpf(cpfUsuario);
        if (usuarioOptional.isPresent()) {
            Usuario usuario = usuarioOptional.get();
            empresa.setUsuario(usuario);
            empresaService.save(empresa);
            return ResponseEntity.ok(empresa);
        } else {
            return ResponseEntity.badRequest().build();
        }
    }

    @PostMapping("/validar-empresa")
    public ResponseEntity<String> validarEmpresa(@RequestBody Empresa empresa, @RequestParam String cpfUsuario) {
        Optional<Usuario> usuarioOpt = usuarioService.findByCpf(cpfUsuario);
        if(!usuarioOpt.isPresent()){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        empresa.setUsuario(usuarioOpt.get());
        empresaService.verificarDadosEmpresa(empresa);
        return ResponseEntity.ok("ok");
    }

    // ==========================
    // 🔐 Login
    // ==========================

    @GetMapping("/login/{cnpj}")
    public ResponseEntity<Object> realizarLogin(@PathVariable String cnpj, @RequestParam String senha) throws NoSuchAlgorithmException {
        String cnpjLimpo = empresaService.limparCnpj(cnpj);
        Optional<Empresa> empresaOptional = empresaService.findByCnpj(cnpjLimpo);
        if (empresaOptional.isPresent()) {

            if(!empresaOptional.get().getUsuario().isStatus_usuario()){
                System.out.println("RETORNANDO: Conta bloqueada");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body("{\"erro\": \"Conta bloqueada. Entre em contato com o suporte.\"}");
            }
            String senhaCriptografada = criptografiaSenha.criptografarSenha(senha);
            System.out.println("Senhas coincidem: " + empresaOptional.get().getUsuario().getSenha_usuario().equals(senhaCriptografada));

            if (empresaOptional.get().getUsuario().getSenha_usuario().equals(senhaCriptografada)) {

                if(empresaOptional.get().getUsuario().getEmail_mfa_enabled() == EmailStatusEnum.ATIVO){
                    System.out.println("=== MFA ATIVO - PREPARANDO ENVIO EMAIL ===");
                    String nome_usuario = empresaOptional.get().getUsuario().getnome_usuario();
                    String codigo = usuarioService.gerarToken();
                    String email = empresaOptional.get().getUsuario().getEmail();
                    int duracao = 10;

                    System.out.println("Dados para email:");
                    System.out.println("- Email: " + email);
                    System.out.println("- Nome: " + nome_usuario);
                    System.out.println("- Codigo: " + codigo);

                    Usuario usuario = empresaOptional.get().getUsuario();
                    usuario.setEmail_code(codigo);
                    usuario.setEmail_code_expires(LocalDateTime.now().plusMinutes(10));
                    usuarioService.saveWithoutEncryption(usuario);
                    System.out.println("Usuario salvo com codigo. Chamando envio de email...");

                    try {
                        emailServiceImpl.enviarEmailAuthMail(email, nome_usuario, codigo, duracao);
                        System.out.println("Metodo enviarEmailAuthMail chamado com sucesso");
                    } catch (Exception e) {
                        System.err.println("ERRO ao chamar enviarEmailAuthMail: " + e.getMessage());
                        e.printStackTrace();
                    }
                } else {
                    System.out.println("MFA NAO ATIVO - Email nao sera enviado");
                }
                System.out.println("LOGIN SUCESSO");
                return ResponseEntity.ok(empresaOptional.get());
            } else {
                System.out.println("RETORNANDO: Senha incorreta");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body("{\"erro\": \"CNPJ ou senha incorretos.\"}");
            }
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body("{\"erro\": \"Empresa não encontrada.\"}");
    }

    @PostMapping("/login/validar-codigo/{cnpj}")
    public ResponseEntity<Boolean> validarCodigo(@PathVariable String cnpj, @RequestBody java.util.Map<String, String> request) throws Exception {
        String codigo = request.get("codigo");
        if(codigo == null || codigo.isEmpty()){
            throw new InvalidDataException("Código inválido. Tente novamente.", "Erro");
        }
        String cnpjLimpo = empresaService.limparCnpj(cnpj);
        Optional<Empresa> empresaOpt = empresaService.findByCnpj(cnpjLimpo);
        if(!empresaOpt.isPresent()){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            // amazonq-ignore-next-line
        }
        Empresa empresa = empresaOpt.get();
        if(empresa.getUsuario() == null){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
        LocalDateTime expiracao = LocalDateTime.now();
        System.out.println("=== DEBUG VALIDAÇÃO CÓDIGO ===");
        System.out.println("Código recebido: '" + codigo + "'");
        System.out.println("Código salvo: '" + empresa.getUsuario().getEmail_code() + "'");
        System.out.println("Expiração: " + empresa.getUsuario().getEmail_code_expires());
        System.out.println("Agora: " + expiracao);

        if(empresa.getUsuario().getEmail_code_expires() != null && empresa.getUsuario().getEmail_code_expires().isBefore(expiracao)){
            System.err.println("Código expirado para CNPJ: " + cnpj + " em " + LocalDateTime.now());
            throw new Exception("Código expirado ou inválido. Tente novamente");
        }
        else if(empresa.getUsuario().getEmail_code() != null && Objects.equals(empresa.getUsuario().getEmail_code().trim().toUpperCase(), codigo.trim().toUpperCase())){
            System.out.println("Código válido!");
            return ResponseEntity.ok(true);
        }
        else{
            System.out.println("Código inválido!");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }

    @PostMapping("/login/reenviar-codigo/{cnpj}")
    public ResponseEntity<?> reenviarCodigoLogin(@PathVariable String cnpj) throws NoSuchAlgorithmException {
        if(cnpj == null || cnpj.isEmpty()){
            throw new InvalidDataException("O sistema não conseguiu concluir a operação. Tente novamente mais tarde.", "Erro");
        }
        String cnpjLimpo = empresaService.limparCnpj(cnpj);
        Optional<Empresa> empresaOpt = empresaService.findByCnpj(cnpjLimpo);
        if(!empresaOpt.isPresent()){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        Empresa empresa = empresaOpt.get();
        if(empresa.getUsuario() == null || empresa.getUsuario().getEmail() == null){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
        String email = empresa.getUsuario().getEmail();
        String nome_usuario = empresa.getUsuario().getnome_usuario();
        String codigo = usuarioService.gerarToken();

        empresa.getUsuario().setEmail_code(codigo);
        empresa.getUsuario().setEmail_code_expires(LocalDateTime.now().plusMinutes(10));
        int duracao = 10;

        empresaService.save(empresa);
        usuarioService.saveWithoutEncryption(empresa.getUsuario());

        emailServiceImpl.enviarEmailAuthMail(email, nome_usuario, codigo, duracao);
        return ResponseEntity.ok("ok");
    };

    // ==========================
    // 🔑 Recuperação de Senha
    // ==========================

    @CrossOrigin(origins = "*")
    @PostMapping("/recuperar-senha")
    public ResponseEntity<Object> recuperarSenha(@RequestBody java.util.Map<String, String> request) {
        try {
            String email = request.get("email");

            // Buscar empresa pelo email do usuário
            List<Empresa> todasEmpresas = empresaService.findAll();
            Optional<Empresa> empresaOptional = todasEmpresas.stream()
                    .filter(empresa -> empresa.getUsuario() != null &&
                            email.equals(empresa.getUsuario().getEmail()))
                    .findFirst();

            if (empresaOptional.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("{\"erro\": \"Email não encontrado\"}");
            }

            Empresa empresa = empresaOptional.get();

            // Gerar código de recuperação de 9 dígitos
            String codigo = String.format("%09d", new java.util.Random().nextInt(1000000000));
            codigosRecuperacao.put(email, codigo);

            // Log do código no console para teste
            System.out.println("=== CÓDIGO DE RECUPERAÇÃO ===");
            System.out.println("Email: " + email);
            System.out.println("Código: " + codigo);
            System.out.println("=============================");

            return ResponseEntity.ok("{\"mensagem\": \"Código de recuperação enviado para o email cadastrado\"}");

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("{\"erro\": \"Erro interno do servidor\"}");
        }
    }

    // ==========================
    // 🔍 Consultas
    // ==========================

    @GetMapping
    public ResponseEntity<List<Empresa>> getAllEmpresas() {
        return ResponseEntity.ok(empresaService.findAll());
    }

    @GetMapping("/{cnpj}")
    public ResponseEntity<Empresa> getEmpresa(@PathVariable String cnpj) {
        Optional<Empresa> empresaOptional = empresaService.findAllById(cnpj);
        return empresaOptional.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    @PostMapping("/usuario")
    public ResponseEntity<Empresa> getEmpresaUsuario(@RequestBody Usuario usuario) {
        try {
            Optional<Empresa> empresaOptional = empresaService.findByCpf(usuario);
            if (empresaOptional.isPresent()) {
                return ResponseEntity.ok(empresaOptional.get());
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // ==========================
    // ✏️ Atualização
    // ==========================

    @PutMapping("/{cnpj}")
    public ResponseEntity<Object> updateEmpresa(@PathVariable String cnpj, @RequestBody Empresa empresa) {
        Optional<Empresa> empresaOptional = empresaService.findAllById(cnpj);
        if (empresaOptional.isPresent()) {
            empresa.setCnpj(cnpj);
            Empresa updatedEmpresa = empresaService.update(empresa);
            return ResponseEntity.ok(updatedEmpresa);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Empresa não encontrada");
        }
    }

    @PutMapping("/{cnpj}/bloquear_cnpj")
    public ResponseEntity<Object> bloquearEmpresa(@PathVariable String cnpj){
        Optional<Empresa> empresaOptional = empresaService.findAllById(cnpj);
        if (empresaOptional.isPresent()) {
            Empresa empresa = empresaOptional.get();
            if(empresa.getUsuario() != null){
                empresa.getUsuario().setStatus_usuario(false);
                empresaService.save(empresa);
                return ResponseEntity.ok(empresa);
            }
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Empresa não encontrada");
    }
    @PutMapping("/{cnpj}/desbloquear_cnpj")
    public ResponseEntity<Object> desbloquearEmpresa(@PathVariable String cnpj){
        Optional<Empresa> empresaOptional = empresaService.findAllById(cnpj);
        if (empresaOptional.isPresent()) {
            Empresa empresa = empresaOptional.get();
            if(empresa.getUsuario() != null){
                empresa.getUsuario().setStatus_usuario(true);
                empresaService.save(empresa);
                return ResponseEntity.ok(empresa);
            }
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Empresa não encontrada");
    }

    // ==========================
    // ❌ Exclusão
    // ==========================

    @DeleteMapping("/{cnpj}")
    public ResponseEntity<String> deletarEmpresa(@PathVariable String cnpj) {
        try {
            empresaService.deletarPorCnpj(cnpj);
            return ResponseEntity.ok("Empresa deletada com sucesso");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Erro ao deletar empresa");
        }
    }

    // ==========================
    // 🔑 Validação de Código de Recuperação
    // ==========================

    @CrossOrigin(origins = "*")
    @PostMapping("/validar-codigo")
    public ResponseEntity<Object> validarCodigoRecuperacao(@RequestBody java.util.Map<String, String> request) {
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
}