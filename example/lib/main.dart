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
    shuffle   : true,
    hideInputs: false
  );

  printControllerData(){
    debugPrint('========================');
    debugPrint('Inputs: ${nPinController.inputs.join(', ')}');
    debugPrint('Length: ${nPinController.length}');
    debugPrint('isFull: ${nPinController.isFull}');
  }

  @override
  void initState() {
    super.initState();
    nPinController.addListener(()=> printControllerData());
  }

  @override
  Widget build(BuildContext context) =>

    MaterialApp(
      debugShowCheckedModeBanner: true,
      title : 'Pin Board Example',
      home  : Scaffold(
        body:
        Column(
          children: [
            NPinBoard(
              leftButtonTap   : () => debugPrint("hi"),
              controller      : nPinController,
              boardStyle      : BoardStyle(),
              pinInputStyle   :
              PinInputStyle()
                ..height          = 40
                ..width           = 40
                ..borderWidth     = 1
                ..borderColor     = Colors.green
                ..emptyBackground = Colors.grey.withOpacity(0.5)
                ..textStyle       = const TextStyle(fontSize: 20, color: Colors.black)
                ..borderRadius    = const Radius.circular(20),
              pinButtonStyle :
              PinButtonStyle()
                ..height          = 70
                ..overHeight      = 75
                ..width           = 70
                ..overWidth       = 75
                ..borderWidth     = 1
                ..borderColor     = Colors.grey
                ..overBorderColor = Colors.red
                ..overBackground  = Colors.red
                ..overAlignment   = Alignment.topCenter
                ..borderRadius    = const Radius.circular(20)
                ..iconStyle       = PinIconStyle(color: Colors.blue,  size: 20)
                ..iconOverStyle   = PinIconStyle(color: Colors.white, size: 15)
                ..numberStyle     = const TextStyle( fontSize: 15, color: Colors.grey  )
                ..numberOverStyle = const TextStyle( fontSize: 20, color: Colors.white )
                ..leftIcon        = Icons.abc
                ..rightIcon       = Icons.backspace_outlined,
            ),
            InkWell(
              onTap: () => printControllerData(),
              child: const Text('Print controller data'),
            )
          ],
        ),
      ),
    );
}
