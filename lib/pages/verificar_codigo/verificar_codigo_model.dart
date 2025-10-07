import '/flutter_flow/flutter_flow_model.dart';
import '/index.dart';
import 'verificar_codigo_widget.dart' show VerificarCodigoWidget;
import 'package:flutter/material.dart';

class VerificarCodigoModel extends FlutterFlowModel<VerificarCodigoWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for codigo widget.
  FocusNode? codigoFocusNode;
  TextEditingController? codigoTextController;
  String? Function(BuildContext, String?)? codigoTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    codigoFocusNode?.dispose();
    codigoTextController?.dispose();
  }
}
