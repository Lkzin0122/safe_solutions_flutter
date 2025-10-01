import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';
import '../models/empresa.dart';
import '../models/usuario.dart';
import '../storage/session_storage.dart';

class ProfileService {
  static const String _profileKey = 'user_profile';
  static const String _baseUrl = 'http://localhost:8080/empresa';

  static Future<UserProfile> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = prefs.getString(_profileKey);
    
    if (profileJson != null) {
      return UserProfile.fromJson(json.decode(profileJson));
    }
    
    // Dados padrão da empresa com dados pessoais de exemplo
    return UserProfile(
      companyName: 'Tech Solutions',
      companyEmail: 'techsolutions@gmail.com',
      companyCnpj: '22.222.222/2222-22',
      companyPhone: '(11) 97880-3756',
      companyAddress: 'São Paulo, SP',
      companyDescription: 'Empresa especializada em soluções tecnológicas inovadoras para segurança residencial e empresarial.',
      personalName: 'João Silva Santos',
      personalCpf: '123.456.789-00',
      personalPhone: '(11) 98765-4321',
      personalEmail: 'joao.silva@email.com',
      personalAddress: 'Rua das Flores, 123 - São Paulo, SP',
    );
  }

  static Future<void> saveUserProfile(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileKey, json.encode(profile.toJson()));
  }

  // GET /empresa - Get all companies
  static Future<List<Empresa>> getAllEmpresas() async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {'Authorization': 'Bearer ${SessionStorage.token}'},
    );
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Empresa.fromJson(json)).toList();
    }
    throw Exception('Failed to load empresas');
  }

  // GET /empresa/{cnpj} - Get company by CNPJ
  static Future<Empresa> getEmpresa(String cnpj) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$cnpj'),
      headers: {'Authorization': 'Bearer ${SessionStorage.token}'},
    );
    
    if (response.statusCode == 200) {
      return Empresa.fromJson(json.decode(response.body));
    }
    throw Exception('Empresa não encontrada');
  }

  // POST /empresa/usuario - Get company by user
  static Future<Empresa> getEmpresaUsuario(Usuario usuario) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/usuario'),
      headers: {
        'Authorization': 'Bearer ${SessionStorage.token}',
        'Content-Type': 'application/json',
      },
      body: json.encode(usuario.toJson()),
    );
    
    if (response.statusCode == 200) {
      return Empresa.fromJson(json.decode(response.body));
    }
    throw Exception('Empresa não encontrada para o usuário');
  }
}