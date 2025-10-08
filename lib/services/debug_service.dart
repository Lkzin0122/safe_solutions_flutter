import 'dart:convert';
import 'package:http/http.dart' as http;

class DebugService {
  static const String _baseUrl = 'http://localhost:8080';

  static Future<void> debugLogin(String cnpj, String senha) async {
    final cnpjLimpo = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    
    print('=== DEBUG DETALHADO ===');
    print('CNPJ original: "$cnpj"');
    print('CNPJ limpo: "$cnpjLimpo"');
    print('Senha: "$senha"');
    print('URL completa: "$_baseUrl/empresa/login/$cnpjLimpo?senha=$senha"');
    
    // Teste 1: Verificar se a empresa existe
    try {
      print('\n--- TESTE 1: Verificando se empresa existe ---');
      final empresaResponse = await http.get(
        Uri.parse('$_baseUrl/empresa/$cnpjLimpo'),
        headers: {'Content-Type': 'application/json'},
      );
      
      print('Status busca empresa: ${empresaResponse.statusCode}');
      if (empresaResponse.statusCode == 200) {
        final empresaData = json.decode(empresaResponse.body);
        print('Empresa encontrada: ${empresaData['nomeEmpresa']}');
        if (empresaData['usuario'] != null) {
          print('Usuário existe: ${empresaData['usuario']['nomeUsuario']}');
          print('Status usuário: ${empresaData['usuario']['statusUsuario']}');
        } else {
          print('PROBLEMA: Usuário não encontrado na empresa');
        }
      } else {
        print('PROBLEMA: Empresa não encontrada');
        print('Response: ${empresaResponse.body}');
      }
    } catch (e) {
      print('ERRO na busca da empresa: $e');
    }
    
    // Teste 2: Tentar login
    try {
      print('\n--- TESTE 2: Tentando login ---');
      final loginResponse = await http.get(
        Uri.parse('$_baseUrl/empresa/login/$cnpjLimpo?senha=$senha'),
        headers: {'Content-Type': 'application/json'},
      );
      
      print('Status login: ${loginResponse.statusCode}');
      print('Response login: ${loginResponse.body}');
      
      if (loginResponse.statusCode != 200) {
        // Tentar diferentes variações da senha
        print('\n--- TESTE 3: Testando variações da senha ---');
        final senhasParaTestar = [
          senha.trim(),
          senha.toLowerCase(),
          senha.toUpperCase(),
        ];
        
        for (String senhaVariacao in senhasParaTestar) {
          if (senhaVariacao != senha) {
            print('Testando senha: "$senhaVariacao"');
            final testResponse = await http.get(
              Uri.parse('$_baseUrl/empresa/login/$cnpjLimpo?senha=$senhaVariacao'),
              headers: {'Content-Type': 'application/json'},
            );
            print('Status: ${testResponse.statusCode}');
            if (testResponse.statusCode == 200) {
              print('SUCESSO com variação da senha!');
              break;
            }
          }
        }
      }
    } catch (e) {
      print('ERRO no login: $e');
    }
    
    print('=== FIM DEBUG ===\n');
  }
}