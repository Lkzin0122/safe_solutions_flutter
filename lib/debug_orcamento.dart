import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/orcamento_service.dart';
import 'models/orcamento.dart';

class DebugOrcamento extends StatefulWidget {
  @override
  _DebugOrcamentoState createState() => _DebugOrcamentoState();
}

class _DebugOrcamentoState extends State<DebugOrcamento> {
  String _resultado = '';
  bool _carregando = false;

  Future<void> _testarConexao() async {
    setState(() {
      _carregando = true;
      _resultado = 'Testando...';
    });

    try {
      // Verificar CPF salvo
      final prefs = await SharedPreferences.getInstance();
      final cpf = prefs.getString('user_cpf');
      
      String debug = 'CPF salvo: ${cpf ?? "Nenhum CPF encontrado"}\n\n';
      
      if (cpf != null && cpf.isNotEmpty) {
        debug += 'Testando busca de orçamentos...\n';
        final orcamentos = await OrcamentoService.getOrcamentosPorCpf(cpf);
        debug += 'Resultado: ${orcamentos.length} orçamentos encontrados\n';
        
        if (orcamentos.isNotEmpty) {
          debug += '\nPrimeiro orçamento:\n';
          debug += 'ID: ${orcamentos.first.id}\n';
          debug += 'Status: ${orcamentos.first.statusTexto}\n';
          debug += 'Serviço: ${orcamentos.first.servico?.nomeServico ?? "N/A"}\n';
        }
      } else {
        debug += 'Não é possível testar sem CPF';
      }
      
      setState(() {
        _resultado = debug;
        _carregando = false;
      });
    } catch (e) {
      setState(() {
        _resultado = 'Erro: $e';
        _carregando = false;
      });
    }
  }

  Future<void> _definirCpfTeste() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_cpf', '55555555555');
    
    setState(() {
      _resultado = 'CPF de teste definido: 55555555555 (CPF que tem orçamentos)';
    });
  }

  Future<void> _limparCpf() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_cpf');
    
    setState(() {
      _resultado = 'CPF removido do SharedPreferences';
    });
  }

  Future<void> _listarTodosOrcamentos() async {
    setState(() {
      _carregando = true;
      _resultado = 'Buscando todos os orçamentos...';
    });

    try {
      final orcamentos = await OrcamentoService.getAllOrcamentos();
      String debug = 'Total de orçamentos no sistema: ${orcamentos.length}\n\n';
      
      if (orcamentos.isNotEmpty) {
        debug += 'CPFs encontrados:\n';
        Set<String> cpfs = {};
        for (var orc in orcamentos) {
          if (orc.usuario?.cpf != null) {
            cpfs.add(orc.usuario!.cpf!);
          }
        }
        cpfs.forEach((cpf) {
          debug += '- $cpf\n';
        });
      }
      
      setState(() {
        _resultado = debug;
        _carregando = false;
      });
    } catch (e) {
      setState(() {
        _resultado = 'Erro ao buscar todos os orçamentos: $e';
        _carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Debug Orçamentos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _carregando ? null : _testarConexao,
              child: Text('Testar Conexão'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _carregando ? null : _definirCpfTeste,
              child: Text('Definir CPF de Teste'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _carregando ? null : _limparCpf,
              child: Text('Limpar CPF'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _carregando ? null : _listarTodosOrcamentos,
              child: Text('Listar Todos CPFs'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _resultado.isEmpty ? 'Clique em "Testar Conexão" para começar' : _resultado,
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