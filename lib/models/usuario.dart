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
      cpf: json['cpf'] ?? json['cpf_usuario'] ?? '',
      nome: json['nome_usuario'] ?? json['nome'] ?? '',
      email: json['email'] ?? '',
      telefone: json['telefone'] ?? json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'cpf': cpf.replaceAll(RegExp(r'[^0-9]'), ''),
      'nome_usuario': nome,
      'email': email,
    };
    
    if (telefone != null && telefone!.isNotEmpty) {
      map['telefone'] = telefone!;
    }
    
    return map;
  }
}