import '/flutter_flow/flutter_flow_model.dart';
import 'package:flutter/material.dart';

class NovaSenhaModel extends FlutterFlowModel {
  TextEditingController? senhaController;
  TextEditingController? confirmarSenhaController;
  bool senhaVisibility = false;
  bool confirmarSenhaVisibility = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    senhaController?.dispose();
    confirmarSenhaController?.dispose();
  }
}