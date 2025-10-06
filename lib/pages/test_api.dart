import 'package:flutter/material.dart';
import '../services/servico_service.dart';
import '../models/servico.dart';

class TestApiPage extends StatefulWidget {
  @override
  _TestApiPageState createState() => _TestApiPageState();
}

class _TestApiPageState extends State<TestApiPage> {
  String _status = 'Aguardando teste...';
  List<Servico> _servicos = [];

  Future<void> _testarAPI() async {
    setState(() {
      _status = 'Testando conexão com API...';
    });

    try {
      // Teste 1: Verificar conectividade
      final conectividade = await ServicoService.testarConectividade();
      
      if (!conectividade) {
        setState(() {
          _status = 'Erro: Não foi possível conectar com a API. Verifique se o servidor está rodando em http://localhost:8080';
        });
        return;
      }
      
      // Teste 2: Buscar todos os serviços
      final servicos = await ServicoService.getAllServicos();
      
      setState(() {
        _servicos = servicos;
        _status = 'Sucesso! Encontrados ${servicos.length} serviços.';
      });
    } catch (e) {
      setState(() {
        _status = 'Erro: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste API'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _testarAPI,
              child: Text('Testar API'),
            ),
            SizedBox(height: 20),
            Text(
              'Status: $_status',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            if (_servicos.isNotEmpty) ...[
              Text('Serviços encontrados:', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _servicos.length,
                  itemBuilder: (context, index) {
                    final servico = _servicos[index];
                    return Card(
                      child: ListTile(
                        title: Text(servico.nomeServico),
                        subtitle: Text(servico.descricaoServico ?? 'Sem descrição'),
                        trailing: Text(servico.statusServico ? 'Ativo' : 'Inativo'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}