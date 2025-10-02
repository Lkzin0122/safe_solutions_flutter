import '/flutter_flow/flutter_flow_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../services/usuario_service.dart';
import '../../services/empresa_service.dart';
import '../../models/usuario.dart';
import '../../models/empresa.dart';
import 'editar_conta_widget.dart';

class EditarContaModel extends FlutterFlowModel<EditarContaWidget> {
  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();


  // User data
  Usuario? usuario;
  bool isLoading = false;

  // State fields for TextFields
  FocusNode? nomeCompletoFocusNode;
  TextEditingController? nomeCompletoController;
  String? Function(BuildContext, String?)? nomeCompletoValidator;

  FocusNode? emailFocusNode;
  TextEditingController? emailController;
  String? Function(BuildContext, String?)? emailValidator;

  FocusNode? telefoneFocusNode;
  TextEditingController? telefoneController;
  String? Function(BuildContext, String?)? telefoneValidator;

  FocusNode? biografiaFocusNode;
  TextEditingController? biografiaController;
  String? Function(BuildContext, String?)? biografiaValidator;

  FocusNode? nomeEmpresaFocusNode;
  TextEditingController? nomeEmpresaController;
  String? Function(BuildContext, String?)? nomeEmpresaValidator;

  FocusNode? enderecoFocusNode;
  TextEditingController? enderecoController;
  String? Function(BuildContext, String?)? enderecoValidator;

  FocusNode? cepFocusNode;
  TextEditingController? cepController;
  String? Function(BuildContext, String?)? cepValidator;

  Empresa? empresa;

  FocusNode? cpfFocusNode;
  TextEditingController? cpfController;
  String? Function(BuildContext, String?)? cpfValidator;

  // Validation methods
  String? validateNomeCompleto(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Nome completo é obrigatório';
    }
    if (val.length < 2) {
      return 'Nome deve ter pelo menos 2 caracteres';
    }
    return null;
  }

  String? validateEmail(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Email é obrigatório';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
      return 'Digite um email válido';
    }
    return null;
  }

  String? validateTelefone(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Telefone é obrigatório';
    }
    if (val.length < 10) {
      return 'Digite um telefone válido';
    }
    return null;
  }

  String? validateBiografia(BuildContext context, String? val) {
    if (val != null && val.length > 500) {
      return 'Biografia deve ter no máximo 500 caracteres';
    }
    return null;
  }

  // Load user data and company data
  Future<void> loadUserData(String email) async {
    isLoading = true;
    
    try {
      usuario = await UsuarioService.getUsuarioByEmail(email);
      
      // Update controllers with loaded data
      nomeCompletoController?.text = usuario!.nome;
      emailController?.text = usuario!.email;
      telefoneController?.text = usuario!.telefone ?? '';
      cpfController?.text = usuario!.cpf;
      
      // Load company data
      await _loadCompanyData();
    } catch (e) {
      print('Error loading user data: $e');
    } finally {
      isLoading = false;
    }
  }

  Future<void> _loadCompanyData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final empresaJson = prefs.getString('empresa_data');
      
      if (empresaJson != null) {
        final empresaData = json.decode(empresaJson);
        final cnpj = empresaData['cnpj'];
        
        if (cnpj != null) {
          empresa = await EmpresaService.getEmpresa(cnpj);
          nomeEmpresaController?.text = empresa!.nomeEmpresa;
          enderecoController?.text = empresa!.endereco ?? '';
          biografiaController?.text = empresa!.descricao ?? '';
          cepController?.text = empresa!.cep ?? '';
        }
      }
    } catch (e) {
      print('Error loading company data: $e');
    }
  }
  
  // Save user and company data
  Future<bool> saveUserData() async {
    if (usuario == null || empresa == null) return false;
    
    try {
      final cpfLimpo = usuario!.cpf.replaceAll(RegExp(r'[^0-9]'), '');
      final telefoneLimpo = telefoneController?.text?.replaceAll(RegExp(r'[^0-9]'), '') ?? '';
      
      // Update user
      final updatedUsuario = Usuario(
        cpf: cpfLimpo,
        nome: nomeCompletoController?.text ?? '',
        email: emailController?.text ?? '',
        telefone: telefoneLimpo.isEmpty ? null : telefoneLimpo,
      );
      
      // Update company
      final updatedEmpresa = Empresa(
        cnpj: empresa!.cnpj,
        nomeEmpresa: nomeEmpresaController?.text ?? '',
        email: empresa!.email,
        telefone: empresa!.telefone,
        endereco: enderecoController?.text,
        descricao: biografiaController?.text,
        cep: cepController?.text,
        usuario: updatedUsuario,
      );
      
      await UsuarioService.updateUsuario(cpfLimpo, updatedUsuario);
      await EmpresaService.updateEmpresa(empresa!.cnpj, updatedEmpresa);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  String? validateCpf(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'CPF é obrigatório';
    }
    if (val.length != 11 && val.length != 14) {
      return 'Digite um CPF válido';
    }
    return null;
  }

  String? validateNomeEmpresa(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Nome da empresa é obrigatório';
    }
    return null;
  }

  String? validateEndereco(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Endereço é obrigatório';
    }
    return null;
  }

  String? validateCep(BuildContext context, String? val) {
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
