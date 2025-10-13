import 'package:flutter/material.dart';

class EsqueciSenhaModel {
  final unfocusNode = FocusNode();

  TextEditingController? cnpjController;
  FocusNode? cnpjFocusNode;

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    cnpjController?.dispose();
    cnpjFocusNode?.dispose();
  }
}