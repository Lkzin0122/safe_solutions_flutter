package br.com.itb.miniprojetospring.controller;

import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

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

import br.com.itb.miniprojetospring.dto.Filtros;
import br.com.itb.miniprojetospring.model.Empresa;
import br.com.itb.miniprojetospring.model.Servico;
import br.com.itb.miniprojetospring.model.enums.FiltrosEnums;
import br.com.itb.miniprojetospring.service.EmpresaService;
import br.com.itb.miniprojetospring.service.ServicoService;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600, allowCredentials = "false")
@RequestMapping("/servico")
public class ServicoController {
    @Autowired
    private final ServicoService servicoService;

    @Autowired
    private final EmpresaService empresaService;

    public ServicoController(ServicoService servicoService, EmpresaService empresaService) {
        this.servicoService = servicoService;
        this.empresaService = empresaService;
    }

    @GetMapping
    public ResponseEntity<List<Servico>> findAll() {
        List<Servico> servicos = servicoService.findAll();
        return new ResponseEntity<>(servicos, HttpStatus.OK);
    }

    @PostMapping
    public ResponseEntity<Servico> createServico(@RequestBody Servico servico, @RequestParam String cnpjEmpresa) {
        // CORRIGIDO: Limpar CNPJ e usar findByCnpj
        String cnpjLimpo = cnpjEmpresa.replaceAll("[^0-9]", "");
        Optional<Empresa> empresaOptional = empresaService.findByCnpj(cnpjLimpo);
        System.out.println("Criando serviço para CNPJ: " + cnpjLimpo);
        System.out.println("Empresa encontrada: " + empresaOptional.isPresent());
        
        if (empresaOptional.isPresent()) {
            Empresa empresa = empresaOptional.get();
            servico.setEmpresa(empresa);
            servico.setStatus_servico(true); // Garantir que seja criado como ativo
            Servico servicoSalvo = servicoService.save(servico);
            System.out.println("Serviço salvo com sucesso! ID: " + servicoSalvo.getId());
            return ResponseEntity.ok(servicoSalvo);
        } else {
            System.out.println("ERRO: Empresa não encontrada para CNPJ: " + cnpjLimpo);
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Servico> getServicoById(@PathVariable Long id) {
        Optional<Servico> servicoOptional = servicoService.findById(id);
        if (servicoOptional.isPresent()) {
            return ResponseEntity.ok(servicoOptional.get());
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    @GetMapping("/listar")
    public ResponseEntity<List<Servico>> getAllServicos() {
    	List<Servico> servicos = servicoService.findAll();
    	servicos = servicos.stream()
    			.filter(service -> service.getStatus_servico() == true)
    			.collect(Collectors.toList());
    	return ResponseEntity.ok(servicos);
    }

    @PostMapping("/filtrar")
    public List<Servico> filtrarServicos(@RequestBody Filtros filtros) {
        System.out.println(filtros);
        List<Servico> servicos = servicoService.findAll();

        servicos = servicos.stream()
                .filter(servico -> servico.getStatus_servico() == true)
                .collect(Collectors.toList());

        if (filtros.getCategoria() != null && !filtros.getCategoria().isEmpty()) {
            servicos = servicos.stream()
                    .filter(servico -> servico.getCategoria_servico() != null && 
                            servico.getCategoria_servico().equalsIgnoreCase(filtros.getCategoria()))
                    .collect(Collectors.toList());
        }

        if (filtros.getArea() != null && !filtros.getArea().isEmpty()) {
            final String areaFiltro = filtros.getArea().toLowerCase();
            servicos = servicos.stream()
                .filter(servico -> servico.getLocal_servico() != null &&
                    servico.getLocal_servico().toLowerCase().contains(areaFiltro))
                .collect(Collectors.toList());
        }

        if (filtros.getRegioes() != null && !filtros.getRegioes().isEmpty()) {
            final List<String> regioesLower = filtros.getRegioes().stream()
                .filter(r -> r != null && !r.isBlank())
                .map(r -> r.toLowerCase())
                .collect(Collectors.toList());

            servicos = servicos.stream()
                .filter(servico -> {
                String local = Optional.ofNullable(servico.getLocal_servico()).orElse("").toLowerCase();
                return regioesLower.stream().anyMatch(local::contains);
                })
                .collect(Collectors.toList());
        }

        if (filtros.getPrecoMax() > 0) {
            servicos = servicos.stream()
                    .filter(servico -> servico.getValor_estimado_servico() <= filtros.getPrecoMax())
                    .collect(Collectors.toList());
        }

        if (filtros.getDataFiltro() != null && filtros.getDataFiltro() != FiltrosEnums.TODOS) {
            Comparator<Servico> comparator = Comparator.comparing(
                Servico::getDisponibilidade_servico,
                Comparator.nullsLast(Comparator.naturalOrder())
            );

            if (filtros.getDataFiltro() == FiltrosEnums.RECENTES) {
                comparator = comparator.reversed();
            }

            servicos = servicos.stream()
                    .sorted(comparator)
                    .collect(Collectors.toList());
        }

        return servicos;
    }

    // MÉTODO CORRIGIDO - PRINCIPAL PROBLEMA
    @GetMapping("/empresa/{cnpj}")
    public ResponseEntity<List<Servico>> getServicosByEmpresa(@PathVariable String cnpj) {
        try {
            System.out.println("=== BUSCAR SERVIÇOS POR EMPRESA ===");
            System.out.println("CNPJ recebido: " + cnpj);
            
            // Limpar CNPJ - remover caracteres especiais
            String cnpjLimpo = cnpj.replaceAll("[^0-9]", "");
            System.out.println("CNPJ limpo: " + cnpjLimpo);
            
            // MUDANÇA: usar findByCnpj em vez de findAllById
            Optional<Empresa> empresaOptional = empresaService.findByCnpj(cnpjLimpo);
            
            if (empresaOptional.isPresent()) {
                Empresa empresa = empresaOptional.get();
                System.out.println("Empresa encontrada: " + empresa.getNome_empresa());
                
                List<Servico> servicos = servicoService.findByEmpresa(empresa);
                System.out.println("Serviços encontrados: " + servicos.size());
                
                // Debug: mostrar cada serviço
                for (Servico servico : servicos) {
                    System.out.println("- " + servico.getNome_servico() + " (Status: " + servico.getStatus_servico() + ")");
                }
                
                return new ResponseEntity<>(servicos, HttpStatus.OK);
            } else {
                System.out.println("ERRO: Empresa não encontrada para CNPJ: " + cnpjLimpo);
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
        } catch (Exception e) {
            System.err.println("ERRO ao buscar serviços: " + e.getMessage());
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<Object> updateServico(@PathVariable Long id, @RequestBody Servico servico) {
        Optional<Servico> servicoOptional = servicoService.findById(id);
        if (servicoOptional.isPresent()) {
            Servico existingServico = servicoOptional.get();
            existingServico.setNome_servico(servico.getNome_servico());
            existingServico.setDescricao_servico(servico.getDescricao_servico());
            existingServico.setCategoria_servico(servico.getCategoria_servico());
            existingServico.setCriterios_servico(servico.getCriterios_servico());
            existingServico.setStatus_servico(servico.getStatus_servico());
            existingServico.setDisponibilidade_servico(servico.getDisponibilidade_servico());
            existingServico.setLocal_servico(servico.getLocal_servico());
            existingServico.setValor_estimado_servico(servico.getValor_estimado_servico());
            servicoService.update(existingServico);
            return ResponseEntity.ok(existingServico);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Object> deleteServico(@PathVariable Long id) {
        servicoService.delete(id);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

    @PutMapping("/desativar/{id}")
    public ResponseEntity<Object> desativarServico(@PathVariable Long id, @RequestBody Empresa empresa){
        if(empresa.getUsuario().getNivel_acesso() != 2){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        Optional<Servico> servicoOptional = servicoService.findById(id);
        if (servicoOptional.isPresent()) {
            Servico servico = servicoOptional.get();
            servico.setStatus_servico(false);
            servicoService.update(servico);
            System.out.println("Serviço desativado: " + servico.getNome_servico());
            return ResponseEntity.status(HttpStatus.OK).body(servico);
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }

    @PutMapping("/ativar/{id}")
    public ResponseEntity<Object> ativarServico(@PathVariable Long id, @RequestBody Empresa empresa){
        System.out.println(empresa);
        if(empresa.getUsuario().getNivel_acesso() != 2){
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        Optional<Servico> servicoOptional = servicoService.findById(id);
        if (servicoOptional.isPresent()) {
            Servico servico = servicoOptional.get();
            servico.setStatus_servico(true);
            servicoService.update(servico);
            System.out.println("Serviço Ativado: " + servico.getNome_servico());
            return ResponseEntity.status(HttpStatus.OK).body(servico);
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }

    @DeleteMapping
    public ResponseEntity<Void> deleteServicosByEmpresa(@RequestParam String cnpjEmpresa) {
        // CORRIGIDO: Limpar CNPJ e usar findByCnpj
        String cnpjLimpo = cnpjEmpresa.replaceAll("[^0-9]", "");
        Optional<Empresa> empresaOptional = empresaService.findByCnpj(cnpjLimpo);
        
        if (empresaOptional.isPresent()) {
            Empresa empresa = empresaOptional.get();
            List<Servico> servicos = servicoService.findAllByEmpresa(empresa);
            for (Servico servico : servicos) {
                servicoService.delete(servico.getId());
            }
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }
}