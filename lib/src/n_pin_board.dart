import 'package:flutter/material.dart';

import 'controller.dart';
import 'models.dart';

class NPinBoard extends StatefulWidget {
  final NPinController  controller;
  final BoardStyle?     boardStyle;
  final PinInputStyle?  pinInputStyle;
  final PinButtonStyle? pinButtonStyle;
  final Function()?     leftButtonTap;
  const NPinBoard({
    super.key,
    required this.controller,
    this.boardStyle,
    this.pinInputStyle,
    this.pinButtonStyle,
    this.leftButtonTap
  });

  @override
  State<NPinBoard> createState() => _NPinBoardState();
}

class ButtonItem{
  Buttons         button;
  String          value;
  PinButtonStyle? style;
  ButtonItem({
    required this.button,
    required this.value,
    this.style,
  });
}

class _NPinBoardState extends State<NPinBoard> {
  late BoardStyle     boardStyle;
  late PinInputStyle  pinInputStyle;
  late PinButtonStyle pinButtonStyle;
  late ButtonItem     selectedButton;

  // List<String>  values  = [];

  List<List<ButtonItem>> board = [
    [ButtonItem(button: Buttons.n1, value: '1'), ButtonItem(button: Buttons.n2, value: '2'), ButtonItem(button: Buttons.n3, value: '3')],
    [ButtonItem(button: Buttons.n4, value: '4'), ButtonItem(button: Buttons.n5, value: '5'), ButtonItem(button: Buttons.n6, value: '6')],
    [ButtonItem(button: Buttons.n7, value: '7'), ButtonItem(button: Buttons.n8, value: '8'), ButtonItem(button: Buttons.n9, value: '9')],
    [ButtonItem(button: Buttons.bf, value: ' '), ButtonItem(button: Buttons.n0, value: '0'), ButtonItem(button: Buttons.bb, value: ' ')],
  ];

  @override
  void initState() {
    super.initState();
    setState(() {

      boardStyle      = widget.boardStyle     ??  BoardStyle();
      pinInputStyle   = widget.pinInputStyle  ??  PinInputStyle();
      pinButtonStyle  = widget.pinButtonStyle ??  PinButtonStyle();
      selectedButton  = ButtonItem(button: Buttons.none, value: '');

      // List<int> indexes = List.generate(widget.controller.length, (index) => index);
      // for (int i = 0; i < indexes.length; i++) { values.add(''); }

      if(widget.controller.shuffle) {
        List<ButtonItem> list = [];
        for (var i in board) { list.addAll(i); }
        list.shuffle();

        board[ 0 ] = list.sublist( 0, 3  );
        board[ 1 ] = list.sublist( 3, 6  );
        board[ 2 ] = list.sublist( 6, 9  );
        board[ 3 ] = list.sublist( 9, 12 );
      }

      List<ButtonItem> intermediates = [];

      for (int y = 0; y < board.length; y++){
        for (int x = 0; x < board[y].length; x++){

          if (Buttons.bf == board[ y ][ x ].button) {
            intermediates.clear();
            intermediates.add( board[ 3 ][ 0 ] );
            intermediates.add( board[ y ][ x ] );
            board[ 3 ][ 0 ] = intermediates[ 1 ];
            board[ y ][ x ] = intermediates[ 0 ];
          }

          if (Buttons.bb == board[ y ][ x ].button) {
            intermediates.clear();
            intermediates.add( board[ 3 ][ 2 ] );
            intermediates.add( board[ y ][ x ] );
            board[ 3 ][ 2 ] = intermediates[ 1 ];
            board[ y ][ x ] = intermediates[ 0 ];
          }

        }
      }

    });
    // widget.controller.addListener(()=> setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin      : boardStyle.generalMargin,
      padding     : boardStyle.generalPadding,
      decoration  :
      BoxDecoration(
        color : boardStyle.generalColor,
        border: boardStyle.generalBorderColor == null
        ? null
        : Border.all(
          width: boardStyle.generalBorderWidth??0,
          color: boardStyle.generalBorderColor!
        ),
        borderRadius: boardStyle.generalRadius == null
        ? null
        : BorderRadius.all(boardStyle.generalRadius!)
      ),
      child:
      Column(
        mainAxisSize  : MainAxisSize.min,
        children      : [
          if(!widget.controller.hideInputs)
          Container(
            margin  : boardStyle.inputsMargin,
            padding : boardStyle.inputsPadding,
            color   : boardStyle.inputsColor,
            child   :
            Row(
              mainAxisAlignment : MainAxisAlignment.center,
              children          : List.generate(widget.controller.length, (index) =>index <  widget.controller.inputs.length ? widget.controller.inputs[index].toString() : "").map((value) => //widget.controller.inputs.map((value) => // values.map((value) =>
                AnimatedContainer(
                  duration    : pinInputStyle.duration,
                  padding     : pinInputStyle.padding,
                  margin      : pinInputStyle.margin,
                  width       : pinInputStyle.width,
                  height      : pinInputStyle.height,
                  alignment   : pinInputStyle.alignment,
                  decoration  : BoxDecoration(
                    color   : value.isEmpty
                    ? pinInputStyle.emptyBackground
                    : pinInputStyle.fullBackground,
                    border  : pinInputStyle.borderColor == null ? null : Border.all(
                      color: pinInputStyle.borderColor!,
                      width: pinInputStyle.borderWidth
                    ),
                    borderRadius  : pinButtonStyle.borderRadius == null ? null : BorderRadius.all(pinInputStyle.borderRadius!),
                  ),
                  child       :
                  Text(
                    value,
                    style: pinInputStyle.textStyle
                  )
                )
              ).toList()
            )
          ),
          Container(
            margin  : boardStyle.buttonsMargin,
            padding : boardStyle.buttonsPadding,
            color   : boardStyle.buttonsColor,
            child   :
            Column(
              children: board.map((row) =>
                Row(
                  mainAxisAlignment : MainAxisAlignment.center,
                  children          : row.map((button) =>
                    InkWell(
                      onHover       : (value)=> setState(()=> selectedButton = button),
                      borderRadius  : pinButtonStyle.borderRadius == null ? null : BorderRadius.all(pinButtonStyle.borderRadius!),
                      onTap         : () => setState(() {
                        if([Buttons.bf, Buttons.bb].contains(button.button)){
                          if(button.button == Buttons.bf) {
                            if(widget.leftButtonTap != null){
                              widget.leftButtonTap!.call();
                            }
                          }
                          if(button.button == Buttons.bb) {
                            if(widget.controller.inputs.isNotEmpty){
                              widget.controller.removeInput = button.value;
                              // values[widget.controller.inputs.length] = '';
                            }
                          }
                        } else {
                          if(widget.controller.inputs.length < widget.controller.length){
                            widget.controller.addInput = button.value;
                            // values[widget.controller.inputs.length - 1] = button.value;
                          }
                        }
                      }),
                      child: widget.leftButtonTap == null && button.button == Buttons.bf
                      ? Container(
                        width: button.button == selectedButton.button
                          ? pinButtonStyle.overWidth ?? pinButtonStyle.width
                          : pinButtonStyle.width,
                        height: button.button == selectedButton.button
                          ? pinButtonStyle.overHeight ?? pinButtonStyle.height
                          : pinButtonStyle.height,
                        padding: button.button == selectedButton.button
                          ? pinButtonStyle.overPadding ?? pinButtonStyle.padding
                          : pinButtonStyle.padding,
                        margin: button.button == selectedButton.button
                          ? pinButtonStyle.overMargin ?? pinButtonStyle.margin
                          : pinButtonStyle.margin,
                        alignment: button.button == selectedButton.button
                          ? pinButtonStyle.overAlignment ?? pinButtonStyle.alignment
                          : pinButtonStyle.alignment,
                      )
                      : AnimatedContainer(
                        duration: pinButtonStyle.duration,
                        width: button.button == selectedButton.button
                          ? pinButtonStyle.overWidth ?? pinButtonStyle.width
                          : pinButtonStyle.width,
                        height: button.button == selectedButton.button
                          ? pinButtonStyle.overHeight ?? pinButtonStyle.height
                          : pinButtonStyle.height,
                        padding: button.button == selectedButton.button
                          ? pinButtonStyle.overPadding ?? pinButtonStyle.padding
                          : pinButtonStyle.padding,
                        margin: button.button == selectedButton.button
                          ? pinButtonStyle.overMargin ?? pinButtonStyle.margin
                          : pinButtonStyle.margin,
                        alignment: button.button == selectedButton.button
                          ? pinButtonStyle.overAlignment ?? pinButtonStyle.alignment
                          : pinButtonStyle.alignment,
                        decoration:
                        BoxDecoration(
                          color   : button.button == selectedButton.button
                          ? pinButtonStyle.overBackground ?? pinButtonStyle.background
                          : pinButtonStyle.background,
                          border  : pinButtonStyle.borderColor == null ? null : Border.all(
                            color: button.button == selectedButton.button
                            ? pinButtonStyle.overBorderColor ?? pinButtonStyle.borderColor!
                            : pinButtonStyle.borderColor!,
                            width: button.button == selectedButton.button
                            ? pinButtonStyle.overBorderWidth ?? pinButtonStyle.borderWidth
                            : pinButtonStyle.borderWidth
                          ),
                          borderRadius: pinButtonStyle.borderRadius == null ? null : BorderRadius.all(pinButtonStyle.borderRadius!)
                        ),
                        child       : [Buttons.bf, Buttons.bb].contains(button.button)
                        ? Icon(
                            button.button != Buttons.bb ? pinButtonStyle.leftIcon : pinButtonStyle.rightIcon,
                            size    : button.button == selectedButton.button
                            ? pinButtonStyle.iconOverStyle != null
                              ? pinButtonStyle.iconOverStyle!.size
                              : pinButtonStyle.iconStyle == null
                                ? null
                                : pinButtonStyle.iconStyle!.size
                            : pinButtonStyle.iconStyle == null
                              ? null
                              : pinButtonStyle.iconStyle!.size,
                            color   : button.button == selectedButton.button
                            ? pinButtonStyle.iconOverStyle != null
                              ? pinButtonStyle.iconOverStyle!.color
                              : pinButtonStyle.iconStyle == null
                                ? null
                                : pinButtonStyle.iconStyle!.color
                            : pinButtonStyle.iconStyle == null
                              ? null
                              : pinButtonStyle.iconStyle!.color,
                          )
                        : Text(
                            button.value,
                            style: button.button == selectedButton.button
                            ? pinButtonStyle.numberOverStyle ?? pinButtonStyle.numberStyle
                            : pinButtonStyle.numberStyle
                          )
                      ),
                    )
                  ).toList()
                )
              ).toList()
            )
          ),
        ]
      )
    );
  }
}