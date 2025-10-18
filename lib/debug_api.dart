import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  // Teste da API de orçamento por ID
  await testOrcamentoById(1);
  await testOrcamentoById(2);
  await testOrcamentoById(3);
}

Future<void> testOrcamentoById(int id) async {
  try {
    print('=== Testando orçamento ID: $id ===');
    final response = await http.get(
      Uri.parse('http://localhost:8080/orcamento/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Cache-Control': 'no-cache',
      },
    );
    
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    print('Response Headers: ${response.headers}');
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Parsed Data: $data');
    }
    print('');
  } catch (e) {
    print('Erro: $e');
  }
}