import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FFButtonWidget extends StatefulWidget {
  const FFButtonWidget({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.options,
    this.icon,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final FFButtonOptions options;
  final Widget? icon;

  @override
  State<FFButtonWidget> createState() => _FFButtonWidgetState();
}

class _FFButtonWidgetState extends State<FFButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.options.color,
        foregroundColor: widget.options.textStyle?.color,
        elevation: widget.options.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: widget.options.borderRadius ?? BorderRadius.circular(8),
          side: widget.options.borderSide ?? BorderSide.none,
        ),
        padding: widget.options.padding,
        minimumSize: Size(widget.options.width ?? 0, widget.options.height ?? 0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null) ...[
            widget.icon!,
            SizedBox(width: 8),
          ],
          AutoSizeText(
            widget.text,
            style: widget.options.textStyle,
          ),
        ],
      ),
    );
  }
}

class FFButtonOptions {
  const FFButtonOptions({
    this.textStyle,
    this.elevation,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.borderSide,
    this.borderRadius,
    this.iconPadding,
  });

  final TextStyle? textStyle;
  final double? elevation;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? iconPadding;
}