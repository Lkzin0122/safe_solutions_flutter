import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'editar_conta_widget.dart';

class EditarContaModel extends FlutterFlowModel<EditarContaWidget> {
  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

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

  @override
  void initState(BuildContext context) {
    nomeCompletoValidator = validateNomeCompleto;
    emailValidator = validateEmail;
    telefoneValidator = validateTelefone;
    biografiaValidator = validateBiografia;
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
  }
}