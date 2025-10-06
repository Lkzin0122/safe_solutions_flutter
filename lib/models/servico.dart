import 'empresa.dart';

class Servico {
  final int? id;
  final String nomeServico;
  final String? descricaoServico;
  final String? categoriaServico;
  final String? criteriosServico;
  final bool statusServico;
  final DateTime? disponibilidadeServico;
  final String? localServico;
  final double? valorEstimadoServico;
  final Empresa? empresa;

  Servico({
    this.id,
    required this.nomeServico,
    this.descricaoServico,
    this.categoriaServico,
    this.criteriosServico,
    this.statusServico = true,
    this.disponibilidadeServico,
    this.localServico,
    this.valorEstimadoServico,
    this.empresa,
  });

  factory Servico.fromJson(Map<String, dynamic> json) {
    return Servico(
      id: json['id'],
      nomeServico: json['nome_servico'] ?? '',
      descricaoServico: json['descricao_servico'],
      categoriaServico: json['categoria_servico'],
      criteriosServico: json['criterios_servico'],
      statusServico: json['status_servico'] ?? true,
      disponibilidadeServico: json['disponibilidade_servico'] != null
          ? DateTime.tryParse(json['disponibilidade_servico'].toString())
          : null,
      localServico: json['local_servico'],
      valorEstimadoServico: json['valor_estimado_servico']?.toDouble(),
      empresa: json['empresa'] != null ? Empresa.fromJson(json['empresa']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome_servico': nomeServico,
      'descricao_servico': descricaoServico,
      'categoria_servico': categoriaServico,
      'criterios_servico': criteriosServico,
      'status_servico': statusServico,
      'disponibilidade_servico': disponibilidadeServico?.toIso8601String(),
      'local_servico': localServico,
      'valor_estimado_servico': valorEstimadoServico,
      'empresa': empresa?.toJson(),
    };
  }
}

class Filtros {
  final String categoria;
  final String? dataFiltro;
  final double precoMax;
  final String area;

  Filtros({
    this.categoria = '',
    this.dataFiltro,
    this.precoMax = 0.0,
    this.area = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'categoria': categoria,
      'dataFiltro': dataFiltro,
      'precoMax': precoMax,
      'area': area,
    };
  }
}