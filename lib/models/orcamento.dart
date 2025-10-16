import 'servico.dart';
import 'usuario.dart';
import 'empresa.dart';

enum StatusEnum {
  PENDENTE,
  ACEITO,
  RECUSADO,
  EM_ANDAMENTO,
  FINALIZADO
}

class Orcamento {
  final int? id;
  final Servico? servico;
  final Usuario? usuario;
  final Empresa? empresa;
  final String? detalhesOrcamento;
  final DateTime? prazoOrcamento;
  final double? valorServico;
  final String? enderecoOrcamento;
  final StatusEnum? statusOrcamento;
  final String? observacao;
  final DateTime? dataAssinatura;
  final DateTime? dataSolicitacao;
  final String? motivoRecusa;

  Orcamento({
    this.id,
    this.servico,
    this.usuario,
    this.empresa,
    this.detalhesOrcamento,
    this.prazoOrcamento,
    this.valorServico,
    this.enderecoOrcamento,
    this.statusOrcamento,
    this.observacao,
    this.dataAssinatura,
    this.dataSolicitacao,
    this.motivoRecusa,
  });

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      try {
        // Remove espaços e substitui vírgula por ponto se necessário
        String cleanValue = value.toString().trim().replaceAll(',', '.');
        return double.parse(cleanValue);
      } catch (e) {
        print('Erro ao fazer parse do valor: $value - $e');
        return null;
      }
    }
    return null;
  }

  factory Orcamento.fromJson(Map<String, dynamic> json) {
    return Orcamento(
      id: json['id'],
      servico: json['servico'] != null ? Servico.fromJson(json['servico']) : null,
      usuario: json['usuario'] != null ? Usuario.fromJson(json['usuario']) : null,
      empresa: json['empresa'] != null ? Empresa.fromJson(json['empresa']) : null,
      detalhesOrcamento: json['detalhes_orcamento'],
      prazoOrcamento: json['prazo_orcamento'] != null 
          ? DateTime.parse(json['prazo_orcamento']) 
          : null,
      valorServico: _parseDouble(json['valor_servico']),
      enderecoOrcamento: json['endereco_orcamento'],
      statusOrcamento: json['status_orcamento'] != null 
          ? StatusEnum.values.firstWhere(
              (e) => e.toString().split('.').last == json['status_orcamento'],
              orElse: () => StatusEnum.PENDENTE,
            )
          : null,
      observacao: json['observacao'],
      dataAssinatura: json['data_assinatura'] != null 
          ? DateTime.parse(json['data_assinatura']) 
          : null,
      dataSolicitacao: json['data_solicitacao'] != null 
          ? DateTime.parse(json['data_solicitacao']) 
          : null,
      motivoRecusa: json['motivo_recusa'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'servico': servico?.toJson(),
      'usuario': usuario?.toJson(),
      'empresa': empresa?.toJson(),
      'detalhes_orcamento': detalhesOrcamento,
      'prazo_orcamento': prazoOrcamento?.toIso8601String(),
      'valor_servico': valorServico,
      'endereco_orcamento': enderecoOrcamento,
      'status_orcamento': statusOrcamento?.toString().split('.').last,
      'observacao': observacao,
      'data_assinatura': dataAssinatura?.toIso8601String(),
      'data_solicitacao': dataSolicitacao?.toIso8601String(),
      'motivo_recusa': motivoRecusa,
    };
  }

  String get statusTexto {
    switch (statusOrcamento) {
      case StatusEnum.PENDENTE:
        return 'Pendente';
      case StatusEnum.ACEITO:
        return 'Aceito';
      case StatusEnum.RECUSADO:
        return 'Recusado';
      case StatusEnum.EM_ANDAMENTO:
        return 'Em Andamento';
      case StatusEnum.FINALIZADO:
        return 'Finalizado';
      default:
        return 'Desconhecido';
    }
  }
}

class AceitarOrcamentoRequest {
  final Empresa empresa;
  final double preco;

  AceitarOrcamentoRequest({
    required this.empresa,
    required this.preco,
  });

  Map<String, dynamic> toJson() {
    return {
      'empresa': empresa.toJson(),
      'preco': preco,
    };
  }
}

class RecusarOrcamentoRequest {
  final Empresa empresa;
  final String motivo;

  RecusarOrcamentoRequest({
    required this.empresa,
    required this.motivo,
  });

  Map<String, dynamic> toJson() {
    return {
      'empresa': empresa.toJson(),
      'motivo': motivo,
    };
  }
}