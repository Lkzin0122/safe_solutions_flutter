// Adicione este método na classe EmpresaService

public Optional<Empresa> findByCnpj(String cnpj) {
    return empresaRepository.findById(cnpj);
}