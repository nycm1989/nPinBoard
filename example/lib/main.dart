import 'package:flutter/material.dart';
import 'package:n_pin_board/n_pin_board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NPinController nPinController = NPinController(
    shuffle : false,
    length  : 6
  );

  @override
  void initState() {
    super.initState();
    nPinController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    nPinController.removeListener(() { });
    nPinController.dispose();
  }

  @override
  Widget build(BuildContext context) =>

    MaterialApp(
      debugShowCheckedModeBanner: true,
      title : 'Pin Board Example',
      home  : Scaffold(
        body:
        Center(
          child:
          Column(
            mainAxisAlignment : MainAxisAlignment.center,
            children          : [
              NPinBoard(
                buttonsMargin : const EdgeInsets.symmetric(vertical: 20),
                controller    : nPinController,
                input         :
                PinInput(
                  textStyle: TextStyle(fontSize: 25),
                  settings:
                  InputSettings(
                    margin  : const EdgeInsets.symmetric(horizontal: 1),
                    padding : const EdgeInsets.symmetric(vertical: 5),
                    border  : Border(bottom: BorderSide(color: Colors.grey.shade300))
                  ),
                  onFilledSettings:
                  InputSettings(
                    border  : Border(bottom: BorderSide(color: Colors.black))
                  ),
                ),
                button        :
                PinButton(
                  textStyle :
                  TextStyle(
                    color     : Colors.black,
                    fontSize  : 18,
                    shadows   : [BoxShadow(color: Colors.grey, blurRadius: 1)]
                  ),
                  onHoverTextStyle :
                  TextStyle(
                    color       : Colors.white,
                    fontSize    : 24,
                    fontWeight  : FontWeight.w500,
                    shadows     : [BoxShadow(color: Colors.black, blurRadius: 2)]
                  ),
                  settings:
                  ButtonSettings(
                    width       : 60,
                    height      : 60,
                    margin      : EdgeInsets.all(10),
                    color       : Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                    shadow      :
                    BoxShadow(
                      color      : Colors.black45,
                      blurRadius : 5,
                      blurStyle  : BlurStyle.outer
                    )
                  ),
                  onHoverSettings:
                  ButtonSettings(
                    color       : Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
                leftIcon  :
                PinIcon(
                  // onTap             : () async => await Future.delayed(Duration(seconds: 2), ()=> print(nPinController.value)),
                  onTap             : () => nPinController.clear(),
                  icon              : Icons.fingerprint,
                  onHoverIconStyle  : IconStyle(color: Colors.white, shadows: [BoxShadow(color: Colors.black, blurRadius: 10)]),
                ),
                rightIcon :
                PinIcon(
                  onTap            : () => nPinController.removeLast(),
                  icon             : Icons.remove,
                  onHoverIcon      : Icons.ac_unit_sharp,
                  iconStyle        : IconStyle(color: Colors.black, shadows: [BoxShadow(color: Colors.blue, blurRadius: 10)]),
                  onHoverIconStyle : IconStyle(color: Colors.white, shadows: [BoxShadow(color: Colors.black, blurRadius: 10)]),
                )
              ),
              if ( nPinController.isEmpty ) Text("Is empty"),
              if ( nPinController.isFull  ) Text("Is full" ),
              if ( !nPinController.isEmpty && !nPinController.isFull  ) Text("value: " + nPinController.value)
            ],
          ),
        ),
      ),
    );
}
