import 'package:flutter/material.dart';
import 'package:n_pin_board/n_pin_board.dart';
import 'package:n_pin_board/src/models.dart';

/// - [obscure] Hide input text
/// - [obscureText] Replace decaul * hide String
/// - [duration] Animation duration
/// - [textStyle] Main text style
/// - [onFilledTextStyle] Text style for filled status
/// - [settings] Main input settings
/// - [onFilledSettings] Settings for filled status
class PinInput{
  final bool            obscure;
  final String          obscureText;
  final Duration      ? duration;
  final TextStyle     ? textStyle;
  final TextStyle     ? onFilledTextStyle;
  final InputSettings ? settings;
  final InputSettings ? onFilledSettings;
  const PinInput({
    this.obscure = false,
    this.obscureText = '*',
    this.duration,
    this.textStyle,
    this.onFilledTextStyle,
    this.settings,
    this.onFilledSettings,
  });
}

class Input extends StatefulWidget {
  final bool            obscure;
  final String          obscureText;
  final String        ? text;
  final Duration      ? duration;
  final TextStyle     ? textStyle;
  final TextStyle     ? onFilledTextStyle;
  final InputSettings ? settings;
  final InputSettings ? onFilledSettings;
  const Input({
    required this.obscure,
    required this.obscureText,
    this.text,
    this.duration,
    this.textStyle,
    this.onFilledTextStyle,
    this.settings,
    this.onFilledSettings,
    super.key
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  TextStyle? textStyle;
  bool onFilled = false;
  InputSettings? settings;

  make()=> setState(() {
    settings  = widget.settings;
    textStyle = widget.textStyle;
    onFilled  = (widget.text??"").isNotEmpty;
  });

  @override
  void reassemble() {
    super.reassemble();
    make();
  }

  @override
  void didUpdateWidget(covariant Input oldWidget) {
    super.didUpdateWidget(oldWidget);
    make();
  }

  @override
  void initState() {
    super.initState();
    make();
  }

  @override
  Widget build(BuildContext context) =>
  AnimatedContainer(
    duration  : widget.duration ?? const Duration(),
    width     : onFilled ? widget.onFilledSettings?.width   ?? settings?.width??35   : settings?.width??35,
    height    : onFilled ? widget.onFilledSettings?.height  ?? settings?.height  : settings?.height,
    padding   : onFilled ? widget.onFilledSettings?.padding ?? settings?.padding : settings?.padding,
    margin    : onFilled ? widget.onFilledSettings?.margin  ?? settings?.margin  : settings?.margin,
    alignment : onFilled
    ? widget.onFilledSettings?.alignment ?? Alignment.center
    : settings?.alignment ?? Alignment.center,
    decoration  :
    BoxDecoration(
      color         : onFilled ? widget.onFilledSettings?.color        ?? settings?.color        : settings?.color,
      gradient      : onFilled ? widget.onFilledSettings?.gradient     ?? settings?.gradient     : settings?.gradient,
      image         : onFilled ? widget.onFilledSettings?.image        ?? settings?.image        : settings?.image,
      border        : onFilled ? widget.onFilledSettings?.border       ?? settings?.border       : settings?.border,
      borderRadius  : onFilled ? widget.onFilledSettings?.borderRadius ?? settings?.borderRadius : settings?.borderRadius,
      boxShadow     : onFilled
      ? widget.onFilledSettings?.shadow == null
        ? settings == null
        ? null
        : settings!.shadow == null
          ? null
          : [settings!.shadow!]
        : [widget.onFilledSettings!.shadow!]
      : settings == null
        ? null
        : settings!.shadow == null
          ? null
          : [settings!.shadow!],
    ),
    child: widget.text == null
    ? null
    : Text(
      onFilled
      ? widget.obscure
        ? widget.obscureText
        : widget.text!
      : widget.text!,
      style: textStyle
    )
  );
}