import 'package:flutter/material.dart';

enum ButtonValue{
  b1,
  b2,
  b3,
  b4,
  b5,
  b6,
  b7,
  b8,
  b9,
  bL,
  b0,
  bR,
}

class ButtonNumber{
  int number;
  ButtonValue value;
  ButtonNumber({
    required this.number,
    required this.value,
  });
}
class ButtonSettings{
  final double              ? width;
  final double              ? height;
  final EdgeInsetsGeometry  ? padding;
  final EdgeInsetsGeometry  ? margin;
  final Alignment           ? alignment;
  final Color               ? color;
  final Gradient            ? gradient;
  final DecorationImage     ? image;
  final Border              ? border;
  final BorderRadius        ? borderRadius;
  final BoxShape            ? shape;
  final BoxShadow           ? shadow;
  const ButtonSettings({
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.alignment,
    this.color,
    this.gradient,
    this.image,
    this.border,
    this.borderRadius,
    this.shape,
    this.shadow,
  });
}

class InputSettings extends ButtonSettings{
  InputSettings({
    super.width,
    super.height,
    super.padding,
    super.margin,
    super.alignment,
    super.color,
    super.gradient,
    super.image,
    super.border,
    super.borderRadius,
    super.shape,
    super.shadow,
  });
}

class IconStyle{
  final double  ? size;
  final Color   ? color;
  final List<Shadow>? shadows;
  IconStyle({
    this.size,
    this.color,
    this.shadows,
  });
}