library multi_image_picker_view;

import 'package:flutter/material.dart';
import 'package:n_pin_board/src/button.dart';
import 'package:n_pin_board/src/controller.dart';
import 'package:n_pin_board/src/input.dart';
import 'package:n_pin_board/src/models.dart';

export 'src/button.dart' show PinButton, PinIcon;
export 'src/input.dart'  show PinInput;
export '/src/controller.dart';
export '/src/models.dart';


/// -[controller] Required class controller
/// -[buttonsDecoration] Decoration for buttons container
/// -[inputsDecoration] Decoration for inputs container
/// -[buttonsMargin] Margin for buttons container
/// -[inputsMargin] Margin for inputs container
/// -[buttonsPadding] Padding for buttons container
/// -[inputsPadding] Padding for inputs container
/// -[input] Configurration for all inputs
/// -[button] Configurration for all buttons
/// -[leftIcon] Left action icon configuration and tap sync/async function
/// -[rightIcon] Right action icon configuration and tap sync/async function
class NPinBoard extends StatefulWidget {
  final NPinController       controller;
  final bool                 showInputs;
  final BoxDecoration      ? buttonsDecoration;
  final BoxDecoration      ? inputsDecoration;
  final EdgeInsetsGeometry ? buttonsMargin;
  final EdgeInsetsGeometry ? inputsMargin;
  final EdgeInsetsGeometry ? buttonsPadding;
  final EdgeInsetsGeometry ? inputsPadding;
  final PinInput           ? input;
  final PinButton          ? button;
  final PinIcon            ? leftIcon;
  final PinIcon            ? rightIcon;

  NPinBoard({
    required this.controller,
    this.showInputs = true,
    this.buttonsDecoration,
    this.inputsDecoration,
    this.buttonsMargin,
    this.inputsMargin,
    this.buttonsPadding,
    this.inputsPadding,
    this.input,
    this.button,
    this.leftIcon,
    this.rightIcon,
    super.key
  });

  @override
  State<NPinBoard> createState() => _NPinBoardState();
}

class _NPinBoardState extends State<NPinBoard> {
  final List<ButtonNumber> numbers = [
    ButtonNumber(number: 0, value: ButtonValue.b0),
    ButtonNumber(number: 1, value: ButtonValue.b1),
    ButtonNumber(number: 2, value: ButtonValue.b2),
    ButtonNumber(number: 3, value: ButtonValue.b3),
    ButtonNumber(number: 4, value: ButtonValue.b4),
    ButtonNumber(number: 5, value: ButtonValue.b5),
    ButtonNumber(number: 6, value: ButtonValue.b6),
    ButtonNumber(number: 7, value: ButtonValue.b7),
    ButtonNumber(number: 8, value: ButtonValue.b8),
    ButtonNumber(number: 9, value: ButtonValue.b9),
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize       : MainAxisSize.min,
      mainAxisAlignment  : MainAxisAlignment.center,
      crossAxisAlignment : CrossAxisAlignment.center,
      children: [
        if(widget.showInputs)
        Container(
          decoration : widget.inputsDecoration,
          margin     : widget.inputsMargin,
          padding    : widget.inputsPadding,
          child:
          Row(
            mainAxisSize : MainAxisSize.min,
            children     : widget.controller.inputs.map((e) =>
              Input(
                text              : e,
                duration          : widget.input?.duration,
                textStyle         : widget.input?.textStyle,
                onFilledTextStyle : widget.input?.onFilledTextStyle,
                settings          : widget.input?.settings,
                onFilledSettings  : widget.input?.onFilledSettings,
                obscure           : widget.input?.obscure??false,
                obscureText       : widget.input?.obscureText??"*",
              )
            ).toList(),
          ),
        ),
        Container(
          decoration : widget.buttonsDecoration,
          margin     : widget.buttonsMargin,
          padding    : widget.buttonsPadding,
          child      :
          Column(
            mainAxisSize       : MainAxisSize.min,
            mainAxisAlignment  : MainAxisAlignment.center,
            crossAxisAlignment :
            widget.leftIcon   == null && widget.rightIcon  != null ? CrossAxisAlignment.end :
            widget.rightIcon  == null && widget.leftIcon   != null ? CrossAxisAlignment.start :
            CrossAxisAlignment.center,
            children           : widget.controller.board.map((row) =>
              Row(
                mainAxisSize       : MainAxisSize.min,
                mainAxisAlignment  :
                MainAxisAlignment.center,
                crossAxisAlignment : CrossAxisAlignment.center,
                children           : row.map((value) => make (value)).toList()
              )
            ).toList()
          ),
        ),
      ],
    );
  }

  Widget make (ButtonValue value) {
    if(value == ButtonValue.bL){
      return widget.leftIcon != null
      ? Button(
        settings        : widget.button?.settings,
        onHoverSettings : widget.button?.onHoverSettings,
        onTap             : widget.leftIcon!.onTap,
        icon              : widget.leftIcon!.icon,
        iconStyle         : widget.leftIcon!.iconStyle,
        onHoverIconStyle  : widget.leftIcon!.onHoverIconStyle,
        duration          : widget.leftIcon!.duration,
      )
      : SizedBox.shrink();
    } else if (value == ButtonValue.bR) {
      return widget.rightIcon != null
      ? Button(
        settings        : widget.button?.settings,
        onHoverSettings : widget.button?.onHoverSettings,
        onTap             : widget.rightIcon!.onTap,
        icon              : widget.rightIcon!.icon,
        iconStyle         : widget.rightIcon!.iconStyle,
        onHoverIconStyle  : widget.rightIcon!.onHoverIconStyle,
        duration          : widget.rightIcon!.duration,
      )
      : SizedBox.shrink();
    } else {
      return Button(
        onTap             : ()=> widget.controller.addInput(numbers.singleWhere((e) => e.value == value).number),
        text              : numbers.singleWhere((e) => e.value == value).number.toString(),
        settings        : widget.button?.settings,
        onHoverSettings : widget.button?.onHoverSettings,
        textStyle         : widget.button?.textStyle,
        onHoverTextStyle  : widget.button?.onHoverTextStyle,
        duration          : widget.button?.duration,
      );
    }
  }
}