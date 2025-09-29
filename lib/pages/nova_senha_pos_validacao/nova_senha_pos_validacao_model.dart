import '/flutter_flow/flutter_flow_model.dart';
import 'nova_senha_pos_validacao_widget.dart' show NovaSenhaPosValidacaoWidget;
import 'package:flutter/material.dart';

class NovaSenhaPosValidacaoModel extends FlutterFlowModel<NovaSenhaPosValidacaoWidget> {
  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  FocusNode? passwordFocusNode;

  TextEditingController? passwordConfirmTextController;
  late bool passwordConfirmVisibility;
  FocusNode? passwordConfirmFocusNode;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
    passwordConfirmVisibility = false;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    passwordTextController?.dispose();
    passwordFocusNode?.dispose();
    passwordConfirmTextController?.dispose();
    passwordConfirmFocusNode?.dispose();
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite sua nova senha.';
    }
    if (value.length < 8) {
      return 'A senha deve ter pelo menos 8 caracteres.';
    }
    return null;
  }

  String? passwordConfirmValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, confirme sua senha.';
    }
    if (value != passwordTextController?.text) {
      return 'As senhas não coincidem.';
    }
    return null;
  }
}
