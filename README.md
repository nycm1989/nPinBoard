# Neil's Pin Board
<p align="center">
    <img src="https://github.com/nycm1989/nPinBoard/blob/main/demostrate.gif?raw=true" alt="" style="width:300px;">
</p>


## Controller properties
```dart
nPinController.length -> int
nPinController.isFull -> bool
nPinController.inputs -> List<int>
nPinController.reset()
```

1. Create a controller and add a listener

```dart
NPinController nPinController = NPinController(
    shuffle   : true,
    hideInputs: false
);

@override
void initState() {
    super.initState();
    nPinController.addListener(()=> printControllerData());
}
```

2. Use the widget ;D

```dart
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

```




