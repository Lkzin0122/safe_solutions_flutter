import 'usuario.dart';

class Empresa {
  final String cnpj;
  final String nomeEmpresa;
  final String email;
  final String? telefone;
  final String? endereco;
  final String? descricao;
  final String? cep;
  final Usuario? usuario;

  Empresa({
    required this.cnpj,
    required this.nomeEmpresa,
    required this.email,
    this.telefone,
    this.endereco,
    this.descricao,
    this.cep,
    this.usuario,
  });

  factory Empresa.fromJson(Map<String, dynamic> json) {
    return Empresa(
      cnpj: json['cnpj'] ?? '',
      nomeEmpresa: json['nome_empresa'] ?? json['nomeEmpresa'] ?? '',
      email: json['email'] ?? '',
      telefone: json['telefone'] ?? json['phone'],
      endereco: json['endereco'] ?? json['address'],
      descricao: json['descricao'] ?? json['description'],
      cep: json['cep'],
      usuario: json['usuario'] != null ? Usuario.fromJson(json['usuario']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cnpj': cnpj,
      'nome_empresa': nomeEmpresa,
      'email': email,
      'telefone': telefone,
      'endereco': endereco,
      'descricao': descricao,
      'cep': cep,
      'usuario': usuario?.toJson(),
    };
  }
}