import 'validar_codigo_widget.dart' show ValidarCodigoWidget;
import 'package:flutter/material.dart';

class ValidarCodigoModel {
  TextEditingController? codigoController;
  FocusNode? codigoFocusNode;

  void dispose() {
    codigoController?.dispose();
    codigoFocusNode?.dispose();
  }
}