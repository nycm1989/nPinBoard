import 'dart:async';

import 'package:flutter/material.dart';
import 'package:n_pin_board/n_pin_board.dart';
import 'package:n_pin_board/src/models.dart';

class PinButton extends Button{

  /// - [textStyle] Main textStyle for button
  /// - [onHoverTextStyle] TextStyle for over state
  /// - [settings] Main sttings for button
  /// - [onHoverSettings] Settings for over state
  /// - [duration] Animation duration
  PinButton({
    TextStyle? textStyle,
    TextStyle? onHoverTextStyle,
    ButtonSettings? settings,
    ButtonSettings? onHoverSettings,
    super.duration = const Duration(milliseconds: 250),
    super.key,
  }) :
  super(
    textStyle       : textStyle,
    onHoverTextStyle: onHoverTextStyle == null ? textStyle : onHoverTextStyle,
    settings:
    ButtonSettings(
      width         : settings?.width      == null ? 50 : settings!.width,
      height        : settings?.height     == null ? 50 : settings!.height,
      padding       : settings?.padding,
      margin        : settings?.margin,
      alignment     : settings?.alignment  == null ? Alignment.center : settings!.alignment,
      color         : settings?.color,
      gradient      : settings?.gradient,
      image         : settings?.image,
      border        : settings?.border,
      borderRadius  : settings?.borderRadius,
      shadow        : settings?.shadow,
    ),
    onHoverSettings: onHoverSettings == null
    ? null
    : ButtonSettings(
      width         : onHoverSettings.width         == null ? settings?.width      : onHoverSettings.width,
      height        : onHoverSettings.height        == null ? settings?.height     : onHoverSettings.height,
      padding       : onHoverSettings.padding       == null ? settings?.padding    : onHoverSettings.padding,
      margin        : onHoverSettings.margin        == null ? settings?.margin     : onHoverSettings.margin,
      alignment     : onHoverSettings.alignment     == null ? settings?.alignment??Alignment.center  : onHoverSettings.alignment,
      color         : onHoverSettings.color         == null ? settings?.color        : onHoverSettings.color,
      gradient      : onHoverSettings.gradient      == null ? settings?.gradient     : onHoverSettings.gradient,
      image         : onHoverSettings.image         == null ? settings?.image        : onHoverSettings.image,
      border        : onHoverSettings.border        == null ? settings?.border       : onHoverSettings.border,
      borderRadius  : onHoverSettings.borderRadius  == null ? settings?.borderRadius : onHoverSettings.borderRadius,
      shadow        : onHoverSettings.shadow        == null ? settings?.shadow       : onHoverSettings.shadow,
    ),

  );
}


/// -[onTap] tap function, cant be async
/// -[icon] Main icon
/// -[onHoverIcon] Icon for over state
/// -[iconStyle] Main Icon State
/// -[onHoverIconStyle] Icon for over state
/// -[duration] Animation duration
class PinIcon extends Button{
  PinIcon({
    required super.onTap,
    required IconData icon,
    IconData  ? onHoverIcon,
    IconStyle ? iconStyle,
    IconStyle ? onHoverIconStyle,
    super.duration = const Duration(milliseconds: 250),
    super.key,
  }) : super (
    icon             : icon,
    onHoverIcon      : onHoverIcon,
    iconStyle        : iconStyle,
    onHoverIconStyle : onHoverIconStyle == null ? iconStyle : onHoverIconStyle,
  );
}

class Button extends StatefulWidget {
  final ButtonValue    ? value;
  final String         ? text;
  final IconData       ? icon;
  final IconData       ? onHoverIcon;
  final Duration       ? duration;
  final TextStyle      ? textStyle;
  final TextStyle      ? onHoverTextStyle;
  final IconStyle      ? iconStyle;
  final IconStyle      ? onHoverIconStyle;
  final ButtonSettings ? settings;
  final ButtonSettings ? onHoverSettings;
  final Function()     ? onTap;
  const Button({
    this.value,
    this.text,
    this.icon,
    this.onHoverIcon,
    this.duration,
    this.textStyle,
    this.onHoverTextStyle,
    this.iconStyle,
    this.onHoverIconStyle,
    this.settings,
    this.onHoverSettings,
    this.onTap,
    super.key
  });

  @override
  State<Button> createState() => _BinButtonState();
}

class _BinButtonState extends State<Button> {
  StreamController<bool>? streamController;
  TextStyle? textStyle;
  bool onHover = false;
  ButtonSettings? settings;
  double defaultSize = 100;
  IconStyle? iconStyle;

  make()=> setState(() {
    settings = widget.settings;
    textStyle = widget.textStyle;
    onHover   = false;

    iconStyle = widget.iconStyle ?? IconStyle(
      size    : 25,
      color   : textStyle?.color,
      shadows : textStyle?.shadows
    );
  });

  @override
  void reassemble() {
    super.reassemble();
    make();
  }

  @override
  void didUpdateWidget(covariant Button oldWidget) {
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
  StreamBuilder<bool>(
    stream  : streamController?.stream,
    builder : (context, snapshot) =>
    GestureDetector(
      onTap: widget.onTap == null ? null : () {
        if( widget.onTap!.runtimeType.toString() == "() => Future<dynamic>" ){
          streamController = StreamController<bool>();
          setState(()=> streamController!.add(true));
          widget.onTap!.call().then((_) => setState(() {
            streamController!.close();
            streamController = null;
          }));
        } else {
          widget.onTap!.call();
        }
      },
      child:
      MouseRegion(
        cursor  : SystemMouseCursors.click,
        onEnter : widget.onHoverSettings == null
        ? null
        : (_)=> setState(() {
          settings = widget.onHoverSettings??widget.settings;
          textStyle  = widget.onHoverTextStyle;
          onHover    = true;
        }),
        onExit  : widget.onHoverSettings == null
        ? null
        : (_)=> setState(() {
          settings    = widget.settings;
          textStyle = widget.textStyle;
          onHover   = false;
        }),
        child   :
        AnimatedContainer(
          duration  : widget.duration ?? const Duration(),
          width     : !onHover
          ? ( settings?.width ?? defaultSize )
          : ( settings?.width ?? defaultSize ) > (settings?.height ?? defaultSize)
            ? ( settings?.width ?? defaultSize )
            : (settings?.height ?? defaultSize),
          height    : !onHover
          ? ( settings?.width ?? defaultSize )
          : ( settings?.width ?? defaultSize ) > (settings?.height ?? defaultSize)
            ? ( settings?.width ?? defaultSize )
            : (settings?.height ?? defaultSize ),
          padding   : settings?.padding,
          margin    : settings?.margin,
          alignment : Alignment.center,
          child     :
          AnimatedContainer(
            duration    : widget.duration    ?? const Duration(),
            width       : settings?.width  ?? defaultSize,
            height      : settings?.height ?? defaultSize,
            decoration  :
            BoxDecoration(
              shape         : settings?.shape??BoxShape.rectangle,
              color         : settings?.color,
              gradient      : settings?.gradient,
              image         : settings?.image,
              border        : settings?.border,
              borderRadius  : settings?.borderRadius,
              boxShadow     : settings == null
              ? null
              : settings!.shadow == null
                ? null
                : [settings!.shadow!],
            ),
            alignment   : settings?.alignment??Alignment.center,
            child       :
            widget.icon != null
            ? snapshot.connectionState == ConnectionState.none
              ? Icon(
                  onHover ? (widget.onHoverIcon?? widget.icon) : widget.icon,
                  size    : onHover ? widget.onHoverIconStyle?.size   ?? iconStyle!.size  : iconStyle!.size,
                  color   : onHover ? widget.onHoverIconStyle?.color  ?? iconStyle!.color : iconStyle!.color,
                  shadows : onHover
                  ? (widget.onHoverIconStyle?.shadows ?? iconStyle!.shadows) == null
                  ? null
                  : widget.onHoverIconStyle?.shadows ?? iconStyle!.shadows!
                  : iconStyle!.shadows == null ? null : iconStyle!.shadows!,
                )
              : Center(
                child:
                SizedBox.square(
                  dimension : iconStyle?.size??25,
                  child     :
                  CircularProgressIndicator(
                    strokeWidth : 1,
                    color       : iconStyle?.color,
                    strokeCap   : StrokeCap.round,
                  )
                ),
              )
            : widget.text != null
              ? Text(widget.text!, style: textStyle)
              : null
          ),
        )
      ),
    )
  );
}