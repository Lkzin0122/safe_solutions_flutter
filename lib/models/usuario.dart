class Usuario {
  final String? id;
  final String cpf;
  final String nomeUsuario;
  final String? dataNascimento;
  final String senhaUsuario;
  final String email;
  final String? dataCriacaoUsuario;
  final int nivelAcesso;
  final bool statusUsuario;

  Usuario({
    this.id,
    required this.cpf,
    required this.nomeUsuario,
    this.dataNascimento,
    required this.senhaUsuario,
    required this.email,
    this.dataCriacaoUsuario,
    this.nivelAcesso = 1,
    this.statusUsuario = true,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      cpf: json['cpf'] ?? '',
      nomeUsuario: json['nome_usuario'] ?? '',
      dataNascimento: json['data_nascimento'],
      senhaUsuario: json['senha_usuario'] ?? '',
      email: json['email'] ?? '',
      dataCriacaoUsuario: json['data_criacao_usuario'],
      nivelAcesso: json['nivel_acesso'] ?? 1,
      statusUsuario: json['status_usuario'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cpf': cpf,
      'nome_usuario': nomeUsuario,
      'data_nascimento': dataNascimento,
      'senha_usuario': senhaUsuario,
      'email': email,
      'data_criacao_usuario': dataCriacaoUsuario,
      'nivel_acesso': nivelAcesso,
      'status_usuario': statusUsuario,
    };
  }
}