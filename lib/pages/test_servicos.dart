import 'package:flutter/material.dart';
import '../services/servico_service.dart';
import '../models/servico.dart';

class TestServicosPage extends StatefulWidget {
  @override
  _TestServicosPageState createState() => _TestServicosPageState();
}

class _TestServicosPageState extends State<TestServicosPage> {
  String _resultado = '';
  bool _carregando = false;

  Future<void> _testarConectividade() async {
    setState(() {
      _carregando = true;
      _resultado = 'Testando conectividade...';
    });

    try {
      final conectado = await ServicoService.testarConectividade();
      setState(() {
        _resultado = conectado ? 'Conectividade OK!' : 'Falha na conectividade';
        _carregando = false;
      });
    } catch (e) {
      setState(() {
        _resultado = 'Erro: $e';
        _carregando = false;
      });
    }
  }

  Future<void> _testarServicosPorEmpresa() async {
    setState(() {
      _carregando = true;
      _resultado = 'Buscando serviços para CNPJ 666666666666666...';
    });

    try {
      final servicos = await ServicoService.getServicosByEmpresa('666666666666666');
      setState(() {
        _resultado = 'Encontrados ${servicos.length} serviços:\n';
        for (var servico in servicos) {
          _resultado += '- ${servico.nomeServico}\n';
        }
        _carregando = false;
      });
    } catch (e) {
      setState(() {
        _resultado = 'Erro ao buscar serviços: $e';
        _carregando = false;
      });
    }
  }

  Future<void> _testarTodosServicos() async {
    setState(() {
      _carregando = true;
      _resultado = 'Buscando todos os serviços...';
    });

    try {
      final servicos = await ServicoService.getAllServicos();
      setState(() {
        _resultado = 'Encontrados ${servicos.length} serviços no total:\n';
        for (var servico in servicos) {
          _resultado += '- ${servico.nomeServico} (Empresa: ${servico.empresa?.nomeEmpresa ?? 'N/A'})\n';
        }
        _carregando = false;
      });
    } catch (e) {
      setState(() {
        _resultado = 'Erro ao buscar todos os serviços: $e';
        _carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste de Serviços'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _carregando ? null : _testarConectividade,
              child: Text('Testar Conectividade'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _carregando ? null : _testarServicosPorEmpresa,
              child: Text('Buscar Serviços da Empresa (666666666666666)'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _carregando ? null : _testarTodosServicos,
              child: Text('Buscar Todos os Serviços'),
            ),
            SizedBox(height: 16),
            if (_carregando)
              Center(child: CircularProgressIndicator())
            else
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _resultado.isEmpty ? 'Clique em um botão para testar' : _resultado,
                      style: TextStyle(fontFamily: 'monospace'),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}