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
      companyCep: empresa.cep ?? '01234-567',
      personalName: empresa.usuario?.nome,
      personalCpf: empresa.usuario?.cpf,
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
    try {
      // Get current empresa data
      final prefs = await SharedPreferences.getInstance();
      final userCnpj = prefs.getString('user_cnpj');
      
      if (userCnpj == null) {
        throw Exception('Usuário não está logado');
      }
      
      // Get current empresa from backend
      final currentEmpresa = await getEmpresa(userCnpj);
      
      // Update empresa with new data
      final updatedEmpresa = Empresa(
        cnpj: currentEmpresa.cnpj,
        nomeEmpresa: profile.companyName,
        email: currentEmpresa.email,
        telefone: currentEmpresa.telefone,
        endereco: profile.companyAddress,
        descricao: profile.companyDescription,
        cep: profile.companyCep,
        usuario: currentEmpresa.usuario != null ? Usuario(
          cpf: currentEmpresa.usuario!.cpf,
          nome: profile.personalName ?? currentEmpresa.usuario!.nome,
          email: profile.personalEmail ?? currentEmpresa.usuario!.email,
          telefone: profile.personalPhone ?? currentEmpresa.usuario!.telefone,
        ) : null,
      );
      
      // Update empresa via API
      await updateEmpresa(userCnpj, updatedEmpresa);
      
      // Save locally
      await _saveProfileLocally(profile);
      await saveEmpresaData(updatedEmpresa);
      
    } catch (e) {
      print('Error saving profile: $e');
      // Fallback to local save only
      await _saveProfileLocally(profile);
    }
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
    final cnpjLimpo = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    print('ProfileService: Buscando empresa com CNPJ: $cnpjLimpo');
    
    final response = await http.get(
      Uri.parse('$_baseUrl/$cnpjLimpo'),
      headers: {'Content-Type': 'application/json'},
    );
    
    print('ProfileService: Status da resposta: ${response.statusCode}');
    print('ProfileService: Corpo da resposta: ${response.body}');
    
    if (response.statusCode == 200) {
      return Empresa.fromJson(json.decode(response.body));
    }
    throw Exception('Erro ao carregar dados');
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
    throw Exception('Dados não encontrados para o usuário');
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