import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';
import '../models/empresa.dart';
import '../models/usuario.dart';
import '../storage/session_storage.dart';

class ProfileService {
  static const String _profileKey = 'user_profile';
  static const String _empresaKey = 'empresa_data';
  static const String _baseUrl = 'http://localhost:8080/empresa';

  static Future<UserProfile> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userCnpj = prefs.getString('user_cnpj');
    
    if (userCnpj == null) {
      throw Exception('Usuário não está logado');
    }
    
    try {
      final empresa = await getEmpresa(userCnpj);
      final profile = _convertEmpresaToUserProfile(empresa);
      await _saveProfileLocally(profile);
      return profile;
    } catch (e) {
      print('Error loading from backend: $e');
      
      final empresaJson = prefs.getString(_empresaKey);
      if (empresaJson != null) {
        final empresaData = json.decode(empresaJson);
        final empresa = Empresa.fromJson(empresaData);
        return _convertEmpresaToUserProfile(empresa);
      }
      
      throw Exception('Não foi possível carregar os dados do perfil');
    }
  }



  static UserProfile _convertEmpresaToUserProfile(Empresa empresa) {
    return UserProfile(
      companyName: empresa.nomeEmpresa,
      companyEmail: empresa.email,
      companyCnpj: _formatCnpj(empresa.cnpj),
      companyPhone: empresa.telefone ?? '(11) 99999-9999',
      companyAddress: empresa.endereco ?? 'São Paulo, SP',
      companyDescription: empresa.descricao ?? 'Empresa especializada em soluções tecnológicas.',
      companyCep: '01234-567',
      personalName: empresa.usuario?.nome,
      personalEmail: empresa.usuario?.email,
      personalPhone: empresa.usuario?.telefone,
    );
  }

  static String _formatCnpj(String cnpj) {
    final numbers = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    if (numbers.length == 14) {
      return '${numbers.substring(0, 2)}.${numbers.substring(2, 5)}.${numbers.substring(5, 8)}/${numbers.substring(8, 12)}-${numbers.substring(12, 14)}';
    }
    return cnpj;
  }

  static Future<void> _saveProfileLocally(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileKey, json.encode(profile.toJson()));
  }

  static Future<void> saveEmpresaData(Empresa empresa) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_empresaKey, json.encode(empresa.toJson()));
  }

  static Future<void> saveUserProfile(UserProfile profile) async {
    await _saveProfileLocally(profile);
  }

  // GET /empresa - Get all companies
  static Future<List<Empresa>> getAllEmpresas() async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
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
      headers: {'Content-Type': 'application/json'},
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
      headers: {'Content-Type': 'application/json'},
      body: json.encode(usuario.toJson()),
    );
    
    if (response.statusCode == 200) {
      return Empresa.fromJson(json.decode(response.body));
    }
    throw Exception('Empresa não encontrada para o usuário');
  }

  // PUT /empresa/{cnpj} - Update company
  static Future<Empresa> updateEmpresa(String cnpj, Empresa empresa) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$cnpj'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(empresa.toJson()),
    );
    
    if (response.statusCode == 200) {
      return Empresa.fromJson(json.decode(response.body));
    }
    throw Exception('Erro ao atualizar empresa');
  }
}