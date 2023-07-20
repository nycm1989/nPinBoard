import 'package:flutter/material.dart';

enum Buttons{
  none,
  n1, // number 1
  n2, // number 2
  n3, // number 3
  n4, // number 4
  n5, // number 5
  n6, // number 6
  n7, // number 7
  n8, // number 8
  n9, // number 9
  bf, // button fingerprint
  n0, // number 0
  bb, // button back
}


class PinInputStyle{
  Duration            duration;
  EdgeInsetsGeometry  margin;
  EdgeInsetsGeometry  padding;
  TextStyle?          textStyle;
  Color?              borderColor;
  Color?              emptyBackground;
  Color?              fullBackground;
  double              width;
  double              height;
  double              borderWidth;
  Radius?             borderRadius;
  Alignment           alignment;

  PinInputStyle({
    this.duration         = const Duration(milliseconds: 250),
    this.margin           = const EdgeInsets.all(5),
    this.padding          = const EdgeInsets.all(5),
    this.textStyle,
    this.borderColor,
    this.emptyBackground,
    this.fullBackground,
    this.width            = 40,
    this.height           = 40,
    this.borderWidth      = 2,
    this.borderRadius     = const Radius.circular(5),
    this.alignment        = Alignment.center,
  });
}


class PinIconStyle{
  Color?  color;
  double? size;

  PinIconStyle({
    this.color,
    this.size,
  });
}


class PinButtonStyle{
  Duration            duration;
  double              width;
  double?             overWidth;
  double              height;
  double?             overHeight;
  EdgeInsetsGeometry  margin;
  EdgeInsetsGeometry? overMargin;
  EdgeInsetsGeometry  padding;
  EdgeInsetsGeometry? overPadding;
  Color?              borderColor;
  TextStyle?          numberStyle;
  TextStyle?          numberOverStyle;
  PinIconStyle?       iconStyle;
  PinIconStyle?       iconOverStyle;
  Color?              overBorderColor;
  Color?              background;
  Color?              overBackground;
  double              borderWidth;
  double?             overBorderWidth;
  Radius?             borderRadius;
  Radius?             overBorderRadius;
  Alignment           alignment;
  Alignment?          overAlignment;
  IconData            leftIcon;
  IconData            rightIcon;

  PinButtonStyle({
    this.duration     = const Duration(milliseconds: 250),
    this.width        = 40,
    this.overWidth,
    this.height       = 40,
    this.overHeight,
    this.margin       = const EdgeInsets.all(5),
    this.overMargin,
    this.padding      = const EdgeInsets.all(5),
    this.overPadding,
    this.borderColor,
    this.overBorderColor,
    this.background,
    this.overBackground,
    this.borderWidth  = 2,
    this.overBorderWidth,
    this.numberStyle,
    this.numberOverStyle,
    this.iconStyle,
    this.iconOverStyle,
    this.borderRadius  = const Radius.circular(5),
    this.overBorderRadius,
    this.alignment     = Alignment.center,
    this.overAlignment,
    this.leftIcon   = Icons.fingerprint_outlined,
    this.rightIcon  = Icons.backspace_outlined
  });
}


class BoardStyle{
  EdgeInsetsGeometry  inputsMargin;
  EdgeInsetsGeometry  inputsPadding;
  Color?              inputsColor;
  EdgeInsetsGeometry  buttonsMargin;
  EdgeInsetsGeometry  buttonsPadding;
  Color?              buttonsColor;
  EdgeInsetsGeometry  generalMargin;
  EdgeInsetsGeometry  generalPadding;
  Color?              generalColor;
  Radius?             generalRadius;
  double?             generalBorderWidth;
  Color?              generalBorderColor;

  BoardStyle({
    this.inputsMargin     = const EdgeInsets.all(5),
    this.inputsPadding    = const EdgeInsets.all(5),
    this.inputsColor,
    this.buttonsMargin    = const EdgeInsets.all(5),
    this.buttonsPadding   = const EdgeInsets.all(5),
    this.buttonsColor,
    this.generalMargin    = const EdgeInsets.all(5),
    this.generalPadding   = const EdgeInsets.all(5),
    this.generalColor,
    this.generalRadius,
    this.generalBorderWidth,
    this.generalBorderColor,
  });
}
