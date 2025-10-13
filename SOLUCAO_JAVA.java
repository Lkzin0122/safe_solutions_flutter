// SOLUÇÃO: Substitua o método getServicosByEmpresa no ServicoController

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