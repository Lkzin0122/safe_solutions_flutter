class Usuario {
  String cpf;
  String nome;
  String email;
  String? telefone;

  Usuario({
    required this.cpf,
    required this.nome,
    required this.email,
    this.telefone,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      cpf: json['cpf'],
      nome: json['nome_usuario'],
      email: json['email'],
      telefone: json['telefone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cpf': cpf,
      'nome_usuario': nome,
      'email': email,
      'telefone': telefone,
    };
  }
}