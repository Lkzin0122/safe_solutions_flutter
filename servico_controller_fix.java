// ServicoController - Métodos que podem estar faltando ou com problema

@RestController
@RequestMapping("/servico")
@CrossOrigin(origins = "*")
public class ServicoController {

    @Autowired
    private ServicoService servicoService;

    @Autowired
    private EmpresaService empresaService;

    // GET /servico/empresa/{cnpj} - Buscar serviços por empresa
    @GetMapping("/empresa/{cnpj}")
    public ResponseEntity<List<Servico>> getServicosByEmpresa(@PathVariable String cnpj) {
        try {
            System.out.println("=== BUSCAR SERVIÇOS POR EMPRESA ===");
            System.out.println("CNPJ recebido: " + cnpj);
            
            // Limpar CNPJ
            String cnpjLimpo = cnpj.replaceAll("[^0-9]", "");
            System.out.println("CNPJ limpo: " + cnpjLimpo);
            
            // Buscar empresa
            Optional<Empresa> empresaOpt = empresaService.findByCnpj(cnpjLimpo);
            if (!empresaOpt.isPresent()) {
                System.out.println("ERRO: Empresa não encontrada para CNPJ: " + cnpjLimpo);
                return ResponseEntity.notFound().build();
            }
            
            Empresa empresa = empresaOpt.get();
            System.out.println("Empresa encontrada: " + empresa.getNome_empresa());
            
            // Buscar serviços da empresa
            List<Servico> servicos = servicoService.findByEmpresaId(empresa.getId());
            System.out.println("Serviços encontrados: " + servicos.size());
            
            for (Servico servico : servicos) {
                System.out.println("- " + servico.getNome_servico() + " (Status: " + servico.isStatus_servico() + ")");
            }
            
            return ResponseEntity.ok(servicos);
            
        } catch (Exception e) {
            System.err.println("ERRO ao buscar serviços por empresa: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // GET /servico/listar - Buscar apenas serviços ativos
    @GetMapping("/listar")
    public ResponseEntity<List<Servico>> getServicosAtivos() {
        try {
            System.out.println("=== BUSCAR SERVIÇOS ATIVOS ===");
            List<Servico> servicos = servicoService.findByStatusServicoTrue();
            System.out.println("Serviços ativos encontrados: " + servicos.size());
            return ResponseEntity.ok(servicos);
        } catch (Exception e) {
            System.err.println("ERRO ao buscar serviços ativos: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // GET /servico - Buscar todos os serviços
    @GetMapping
    public ResponseEntity<List<Servico>> getAllServicos() {
        try {
            System.out.println("=== BUSCAR TODOS OS SERVIÇOS ===");
            List<Servico> servicos = servicoService.findAll();
            System.out.println("Total de serviços encontrados: " + servicos.size());
            return ResponseEntity.ok(servicos);
        } catch (Exception e) {
            System.err.println("ERRO ao buscar todos os serviços: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // POST /servico - Criar serviço
    @PostMapping
    public ResponseEntity<Servico> createServico(@RequestBody Servico servico, @RequestParam String cnpjEmpresa) {
        try {
            System.out.println("=== CRIAR SERVIÇO ===");
            System.out.println("CNPJ da empresa: " + cnpjEmpresa);
            System.out.println("Nome do serviço: " + servico.getNome_servico());
            
            String cnpjLimpo = cnpjEmpresa.replaceAll("[^0-9]", "");
            Optional<Empresa> empresaOpt = empresaService.findByCnpj(cnpjLimpo);
            
            if (!empresaOpt.isPresent()) {
                System.out.println("ERRO: Empresa não encontrada para CNPJ: " + cnpjLimpo);
                return ResponseEntity.badRequest().build();
            }
            
            Empresa empresa = empresaOpt.get();
            servico.setEmpresa(empresa);
            servico.setStatus_servico(true); // Garantir que o serviço seja criado como ativo
            
            Servico servicoSalvo = servicoService.save(servico);
            System.out.println("Serviço criado com sucesso. ID: " + servicoSalvo.getId());
            
            return ResponseEntity.ok(servicoSalvo);
            
        } catch (Exception e) {
            System.err.println("ERRO ao criar serviço: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}

// Métodos que devem existir no ServicoService
/*
public interface ServicoService {
    List<Servico> findByEmpresaId(Long empresaId);
    List<Servico> findByStatusServicoTrue();
    List<Servico> findAll();
    Servico save(Servico servico);
}
*/

// Implementação no ServicoServiceImpl
/*
@Service
public class ServicoServiceImpl implements ServicoService {
    
    @Autowired
    private ServicoRepository servicoRepository;
    
    @Override
    public List<Servico> findByEmpresaId(Long empresaId) {
        return servicoRepository.findByEmpresaId(empresaId);
    }
    
    @Override
    public List<Servico> findByStatusServicoTrue() {
        return servicoRepository.findByStatusServicoTrue();
    }
    
    @Override
    public List<Servico> findAll() {
        return servicoRepository.findAll();
    }
    
    @Override
    public Servico save(Servico servico) {
        return servicoRepository.save(servico);
    }
}
*/

// Métodos que devem existir no ServicoRepository
/*
public interface ServicoRepository extends JpaRepository<Servico, Long> {
    List<Servico> findByEmpresaId(Long empresaId);
    List<Servico> findByStatusServicoTrue();
}
*/