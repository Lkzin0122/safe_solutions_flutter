import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';
import '../models/empresa.dart';
import '../models/usuario.dart';

class ProfileService {
  static const String _profileKey = 'user_profile';
  static const String _empresaKey = 'empresa_data';
  static const String _baseUrl = 'https://spring-aplication.onrender.com/empresa';

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
    final endereco = [empresa.rua, empresa.numero, empresa.bairro, empresa.cidade]
        .where((e) => e != null && e.isNotEmpty)
        .join(', ');
    
    return UserProfile(
      companyName: empresa.nomeEmpresa,
      companyEmail: empresa.usuario?.email ?? '',
      companyCnpj: _formatCnpj(empresa.cnpj),
      companyPhone: empresa.telefoneEmpresa ?? '',
      companyAddress: endereco.isNotEmpty ? endereco : '',
      companyDescription: empresa.descricaoEmpresa ?? '',
      companyCep: empresa.cep ?? '',
      personalName: empresa.usuario?.nomeUsuario,
      personalCpf: empresa.usuario?.cpf,
      personalEmail: empresa.usuario?.email,
      personalPhone: empresa.telefoneEmpresa,
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
      final prefs = await SharedPreferences.getInstance();
      final userCnpj = prefs.getString('user_cnpj');
      
      if (userCnpj == null) {
        throw Exception('Usuário não está logado');
      }
      
      final currentEmpresa = await getEmpresa(userCnpj);
      
      final updatedEmpresa = Empresa(
        id: currentEmpresa.id,
        cnpj: currentEmpresa.cnpj,
        nomeEmpresa: profile.companyName,
        telefoneEmpresa: profile.companyPhone,
        rua: _extractRua(profile.companyAddress),
        numero: _extractNumero(profile.companyAddress),
        bairro: _extractBairro(profile.companyAddress),
        cidade: _extractCidade(profile.companyAddress),
        cep: profile.companyCep,
        descricaoEmpresa: profile.companyDescription,
        dataCriacao: currentEmpresa.dataCriacao,
        usuario: currentEmpresa.usuario != null ? Usuario(
          id: currentEmpresa.usuario!.id,
          cpf: currentEmpresa.usuario!.cpf,
          nomeUsuario: profile.personalName ?? currentEmpresa.usuario!.nomeUsuario,
          dataNascimento: currentEmpresa.usuario!.dataNascimento,
          senhaUsuario: currentEmpresa.usuario!.senhaUsuario,
          email: currentEmpresa.usuario!.email,
          dataCriacaoUsuario: currentEmpresa.usuario!.dataCriacaoUsuario,
          nivelAcesso: currentEmpresa.usuario!.nivelAcesso,
          statusUsuario: currentEmpresa.usuario!.statusUsuario,
        ) : null,
      );
      
      await updateEmpresa(userCnpj, updatedEmpresa);
      
      if (currentEmpresa.usuario != null && 
          (profile.personalName != currentEmpresa.usuario!.nomeUsuario)) {
        await updateUsuario(currentEmpresa.usuario!.cpf, updatedEmpresa.usuario!);
      }
      
      await _saveProfileLocally(profile);
      await saveEmpresaData(updatedEmpresa);
      
    } catch (e) {
      rethrow;
    }
  }
  
  static String? _extractRua(String address) {
    if (address.isEmpty) return null;
    final parts = address.split(', ');
    return parts.isNotEmpty ? parts[0] : null;
  }
  
  static String? _extractNumero(String address) {
    if (address.isEmpty) return null;
    final parts = address.split(', ');
    return parts.length > 1 ? parts[1] : null;
  }
  
  static String? _extractBairro(String address) {
    if (address.isEmpty) return null;
    final parts = address.split(', ');
    return parts.length > 2 ? parts[2] : null;
  }
  
  static String? _extractCidade(String address) {
    if (address.isEmpty) return null;
    final parts = address.split(', ');
    return parts.length > 3 ? parts[3] : null;
  }

  static Future<Empresa> getEmpresa(String cnpj) async {
    final cnpjLimpo = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    
    final response = await http.get(
      Uri.parse('$_baseUrl/$cnpjLimpo'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 200) {
      return Empresa.fromJson(json.decode(response.body));
    }
    throw Exception('Erro ao carregar dados');
  }

  static Future<Empresa> updateEmpresa(String cnpj, Empresa empresa) async {
    final cnpjLimpo = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    final response = await http.put(
      Uri.parse('$_baseUrl/$cnpjLimpo'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(empresa.toJson()),
    );
    
    if (response.statusCode == 200) {
      return Empresa.fromJson(json.decode(response.body));
    }
    throw Exception('Erro ao atualizar empresa');
  }
  
  static Future<Usuario> updateUsuario(String cpf, Usuario usuario) async {
    final cpfLimpo = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    final response = await http.put(
      Uri.parse('http://localhost:8080/usuario/$cpfLimpo'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(usuario.toJson()),
    );
    
    if (response.statusCode == 200) {
      return Usuario.fromJson(json.decode(response.body));
    }
    throw Exception('Erro ao atualizar usuário');
  }
}