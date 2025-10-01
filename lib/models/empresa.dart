import 'usuario.dart';

class Empresa {
  final String cnpj;
  final String nomeEmpresa;
  final String email;
  final String? telefone;
  final String? endereco;
  final String? descricao;
  final Usuario? usuario;

  Empresa({
    required this.cnpj,
    required this.nomeEmpresa,
    required this.email,
    this.telefone,
    this.endereco,
    this.descricao,
    this.usuario,
  });

  factory Empresa.fromJson(Map<String, dynamic> json) {
    return Empresa(
      cnpj: json['cnpj'] ?? '',
      nomeEmpresa: json['nome_empresa'] ?? '',
      email: json['email'] ?? '',
      telefone: json['telefone'],
      endereco: json['endereco'],
      descricao: json['descricao'],
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
      'usuario': usuario?.toJson(),
    };
  }
}