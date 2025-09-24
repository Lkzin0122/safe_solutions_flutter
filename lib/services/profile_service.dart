import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';

class ProfileService {
  static const String _profileKey = 'user_profile';

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
      companyCnpj: '12.345.678/0001-90',
      companyPhone: '(11) 99999-9999',
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
}