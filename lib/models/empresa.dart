import 'usuario.dart';

class Empresa {
  final String? id;
  final String cnpj;
  final String nomeEmpresa;
  final String? telefoneEmpresa;
  final String? rua;
  final String? numero;
  final String? bairro;
  final String? cidade;
  final String? cep;
  final String? descricaoEmpresa;
  final String? dataCriacao;
  final Usuario? usuario;

  Empresa({
    this.id,
    required this.cnpj,
    required this.nomeEmpresa,
    this.telefoneEmpresa,
    this.rua,
    this.numero,
    this.bairro,
    this.cidade,
    this.cep,
    this.descricaoEmpresa,
    this.dataCriacao,
    this.usuario,
  });

  factory Empresa.fromJson(Map<String, dynamic> json) {
    return Empresa(
      id: json['id'],
      cnpj: json['cnpj'] ?? '',
      nomeEmpresa: json['nome_empresa'] ?? '',
      telefoneEmpresa: json['telefone_empresa'],
      rua: json['rua'],
      numero: json['numero'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      cep: json['cep'],
      descricaoEmpresa: json['descricao_empresa'],
      dataCriacao: json['data_criacao'],
      usuario: json['usuario'] != null ? Usuario.fromJson(json['usuario']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cnpj': cnpj,
      'nome_empresa': nomeEmpresa,
      'telefone_empresa': telefoneEmpresa,
      'rua': rua,
      'numero': numero,
      'bairro': bairro,
      'cidade': cidade,
      'cep': cep,
      'descricao_empresa': descricaoEmpresa,
      'data_criacao': dataCriacao,
      'usuario': usuario?.toJson(),
    };
  }
}