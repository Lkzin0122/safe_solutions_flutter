import '/flutter_flow/flutter_flow_model.dart';
import 'confirmar_senha_widget.dart' show ConfirmarSenhaWidget;
import 'package:flutter/material.dart';

class ConfirmarSenhaModel extends FlutterFlowModel<ConfirmarSenhaWidget> {
  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  FocusNode? passwordFocusNode;

  String? serviceId;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    passwordTextController?.dispose();
    passwordFocusNode?.dispose();
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite sua senha.';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres.';
    }
    return null;
  }
}
