import '/flutter_flow/flutter_flow_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../services/profile_service.dart';
import '../../models/user_profile.dart';
import 'editar_conta_widget.dart';

class EditarContaModel extends FlutterFlowModel<EditarContaWidget> {
  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  // User data
  UserProfile? userProfile;
  bool isLoading = false;
  bool isEditing = false;

  // State fields for TextFields
  FocusNode? nomeCompletoFocusNode;
  TextEditingController? nomeCompletoController;
  FormFieldValidator<String>? nomeCompletoValidator;

  FocusNode? emailFocusNode;
  TextEditingController? emailController;
  FormFieldValidator<String>? emailValidator;

  FocusNode? telefoneFocusNode;
  TextEditingController? telefoneController;
  FormFieldValidator<String>? telefoneValidator;

  FocusNode? biografiaFocusNode;
  TextEditingController? biografiaController;
  FormFieldValidator<String>? biografiaValidator;

  FocusNode? nomeEmpresaFocusNode;
  TextEditingController? nomeEmpresaController;
  FormFieldValidator<String>? nomeEmpresaValidator;

  FocusNode? enderecoFocusNode;
  TextEditingController? enderecoController;
  FormFieldValidator<String>? enderecoValidator;

  FocusNode? cepFocusNode;
  TextEditingController? cepController;
  FormFieldValidator<String>? cepValidator;

  FocusNode? cpfFocusNode;
  TextEditingController? cpfController;
  FormFieldValidator<String>? cpfValidator;

  // Validation methods
  String? validateNomeCompleto(String? val) {
    if (val == null || val.isEmpty) {
      return 'Nome completo é obrigatório';
    }
    if (val.length < 2) {
      return 'Nome deve ter pelo menos 2 caracteres';
    }
    return null;
  }

  String? validateEmail(String? val) {
    if (val == null || val.isEmpty) {
      return 'Email é obrigatório';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
      return 'Digite um email válido';
    }
    return null;
  }

  String? validateTelefone(String? val) {
    if (val == null || val.isEmpty) {
      return 'Telefone é obrigatório';
    }
    if (val.length < 10) {
      return 'Digite um telefone válido';
    }
    return null;
  }

  String? validateBiografia(String? val) {
    if (val != null && val.length > 500) {
      return 'Biografia deve ter no máximo 500 caracteres';
    }
    return null;
  }

  // Load user profile data
  Future<void> loadUserProfile() async {
    isLoading = true;
    
    try {
      userProfile = await ProfileService.getUserProfile();
      initializeControllers();
    } catch (e) {
      print('Error loading user profile: $e');
      rethrow;
    } finally {
      isLoading = false;
    }
  }

  void initializeControllers() {
    if (userProfile != null) {
      nomeCompletoController?.text = userProfile!.personalName ?? '';
      emailController?.text = userProfile!.personalEmail ?? '';
      telefoneController?.text = userProfile!.personalPhone ?? '';
      cpfController?.text = userProfile!.personalCpf ?? '';
      
      nomeEmpresaController?.text = userProfile!.companyName;
      enderecoController?.text = userProfile!.companyAddress;
      biografiaController?.text = userProfile!.companyDescription;
      cepController?.text = userProfile!.companyCep ?? '';
    }
  }
  
  // Save user profile data
  Future<bool> saveUserProfile() async {
    if (userProfile == null) return false;
    
    try {
      final updatedProfile = UserProfile(
        companyName: nomeEmpresaController?.text ?? userProfile!.companyName,
        companyEmail: userProfile!.companyEmail,
        companyCnpj: userProfile!.companyCnpj,
        companyPhone: userProfile!.companyPhone,
        companyAddress: enderecoController?.text ?? userProfile!.companyAddress,
        companyDescription: biografiaController?.text ?? userProfile!.companyDescription,
        companyCep: cepController?.text ?? userProfile!.companyCep,
        personalName: nomeCompletoController?.text ?? userProfile!.personalName,
        personalCpf: userProfile!.personalCpf,
        personalPhone: telefoneController?.text ?? userProfile!.personalPhone,
        personalEmail: emailController?.text ?? userProfile!.personalEmail,
        personalAddress: userProfile!.personalAddress,
      );
      
      await ProfileService.saveUserProfile(updatedProfile);
      userProfile = updatedProfile;
      return true;
    } catch (e) {
      rethrow;
    }
  }

  void toggleEditMode() {
    isEditing = !isEditing;
  }

  String? validateCpf(String? val) {
    if (val == null || val.isEmpty) {
      return 'CPF é obrigatório';
    }
    if (val.length != 11 && val.length != 14) {
      return 'Digite um CPF válido';
    }
    return null;
  }

  String? validateNomeEmpresa(String? val) {
    if (val == null || val.isEmpty) {
      return 'Nome da empresa é obrigatório';
    }
    return null;
  }

  String? validateEndereco(String? val) {
    if (val == null || val.isEmpty) {
      return 'Endereço é obrigatório';
    }
    return null;
  }

  String? validateCep(String? val) {
    if (val != null && val.isNotEmpty) {
      final cepRegex = RegExp(r'^\d{5}-?\d{3}$');
      if (!cepRegex.hasMatch(val)) {
        return 'Digite um CEP válido';
      }
    }
    return null;
  }

  @override
  void initState(BuildContext context) {
    // Initialize controllers
    nomeCompletoController = TextEditingController();
    emailController = TextEditingController();
    telefoneController = TextEditingController();
    biografiaController = TextEditingController();
    nomeEmpresaController = TextEditingController();
    enderecoController = TextEditingController();
    cepController = TextEditingController();
    cpfController = TextEditingController();
    
    // Initialize focus nodes
    nomeCompletoFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    telefoneFocusNode = FocusNode();
    biografiaFocusNode = FocusNode();
    nomeEmpresaFocusNode = FocusNode();
    enderecoFocusNode = FocusNode();
    cepFocusNode = FocusNode();
    cpfFocusNode = FocusNode();
    
    // Set validators
    nomeCompletoValidator = validateNomeCompleto;
    emailValidator = validateEmail;
    telefoneValidator = validateTelefone;
    biografiaValidator = validateBiografia;
    cpfValidator = validateCpf;
    nomeEmpresaValidator = validateNomeEmpresa;
    enderecoValidator = validateEndereco;
    cepValidator = validateCep;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    nomeCompletoFocusNode?.dispose();
    nomeCompletoController?.dispose();
    emailFocusNode?.dispose();
    emailController?.dispose();
    telefoneFocusNode?.dispose();
    telefoneController?.dispose();
    biografiaFocusNode?.dispose();
    biografiaController?.dispose();
    cpfFocusNode?.dispose();
    cpfController?.dispose();
    nomeEmpresaFocusNode?.dispose();
    nomeEmpresaController?.dispose();
    enderecoFocusNode?.dispose();
    enderecoController?.dispose();
    cepFocusNode?.dispose();
    cepController?.dispose();
  }
}
