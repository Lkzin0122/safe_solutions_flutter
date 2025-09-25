import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import '../../services/user_service.dart';
import '../../models/usuario.dart';
import 'editar_conta_widget.dart';

class EditarContaModel extends FlutterFlowModel<EditarContaWidget> {
  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final UsuarioService _usuarioService = UsuarioService();

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

  // Load user data
  Future<void> loadUserData(String emailOrCpf) async {
    isLoading = true;
    
    try {
      Usuario? fetchedUsuario;
      
      if (emailOrCpf.contains('@')) {
        fetchedUsuario = await _usuarioService.buscarPorEmail(emailOrCpf);
      } else {
        fetchedUsuario = await _usuarioService.buscarPorCpf(emailOrCpf);
      }
      
      if (fetchedUsuario != null) {
        usuario = fetchedUsuario;
        
        // Update controllers with loaded data
        nomeCompletoController?.text = usuario!.nome;
        emailController?.text = usuario!.email;
        telefoneController?.text = usuario!.telefone ?? '';
        cpfController?.text = usuario!.cpf;
      }
    } catch (e) {
      print('Error loading user data: $e');
    } finally {
      isLoading = false;
    }
  }
  
  // Save user data
  Future<bool> saveUserData() async {
    if (usuario == null) return false;
    
    final updatedUsuario = Usuario(
      cpf: usuario!.cpf,
      nome: nomeCompletoController?.text ?? '',
      email: emailController?.text ?? '',
      telefone: telefoneController?.text,
    );
    
    return await _usuarioService.atualizarUsuario(usuario!.cpf, updatedUsuario);
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

  @override
  void initState(BuildContext context) {
    nomeCompletoValidator = validateNomeCompleto;
    emailValidator = validateEmail;
    telefoneValidator = validateTelefone;
    biografiaValidator = validateBiografia;
    cpfValidator = validateCpf;
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
  }
}