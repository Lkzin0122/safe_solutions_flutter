import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlutterFlowIconButton extends StatefulWidget {
  const FlutterFlowIconButton({
    Key? key,
    required this.icon,
    this.onPressed,
    this.buttonSize,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
  }) : super(key: key);

  final Widget icon;
  final VoidCallback? onPressed;
  final double? buttonSize;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? borderWidth;

  @override
  State<FlutterFlowIconButton> createState() => _FlutterFlowIconButtonState();
}

class _FlutterFlowIconButtonState extends State<FlutterFlowIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: widget.icon,
      iconSize: widget.buttonSize ?? 24,
      style: IconButton.styleFrom(
        backgroundColor: widget.fillColor,
        side: widget.borderColor != null 
          ? BorderSide(color: widget.borderColor!, width: widget.borderWidth ?? 1)
          : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
        ),
      ),
    );
  }
}