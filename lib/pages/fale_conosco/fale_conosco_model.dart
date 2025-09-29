import '/flutter_flow/flutter_flow_model.dart';
import 'fale_conosco_widget.dart' show FaleConoscoWidget;
import 'package:flutter/material.dart';

class FaleConoscoModel extends FlutterFlowModel<FaleConoscoWidget> {
  final unfocusNode = FocusNode();
  
  FocusNode? emailFocusNode;
  TextEditingController? emailController;
  String? Function(BuildContext, String?)? emailControllerValidator;

  FocusNode? nomeFocusNode;
  TextEditingController? nomeController;
  String? Function(BuildContext, String?)? nomeControllerValidator;

  FocusNode? telefoneFocusNode;
  TextEditingController? telefoneController;
  String? Function(BuildContext, String?)? telefoneControllerValidator;

  FocusNode? mensagemFocusNode;
  TextEditingController? mensagemController;
  String? Function(BuildContext, String?)? mensagemControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    emailFocusNode?.dispose();
    emailController?.dispose();
    nomeFocusNode?.dispose();
    nomeController?.dispose();
    telefoneFocusNode?.dispose();
    telefoneController?.dispose();
    mensagemFocusNode?.dispose();
    mensagemController?.dispose();
  }
}
