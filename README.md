# Neil's Pin Board
<p align="center">
    <img src="https://github.com/nycm1989/nPinBoard/blob/main/screens/demostrate.gif?raw=true" alt="" style="width:250px;">
</p>

## Widget properties
```dart
NPinBoard(
    /// Required class controller
    controller          -> NPinController
    /// Show or Hide inputs row
    showInputs          -> bool
    /// Decoration for buttons container
    buttonsDecoration   -> BoxDecoration
    /// Decoration for inputs container
    inputsDecoration    -> BoxDecoration
    /// Margin for buttons container
    buttonsMargin       -> EdgeInsetsGeometry
    /// Margin for inputs container
    inputsMargin        -> EdgeInsetsGeometry
    /// Padding for buttons container
    buttonsPadding      -> EdgeInsetsGeometry
    /// Padding for inputs container
    inputsPadding       -> EdgeInsetsGeometry
    /// Configurration for all inputs
    input               -> PinInput
    /// Configurration for all buttons
    button              -> PinButton
    /// Left action icon configuration and tap sync/async function, can be nulleable
    leftIcon            -> PinIcon
    /// Right action icon configuration and tap sync/async function, can be nulleable
    rightIcon           -> PinIcon
)
```

## Controller properties
```dart
    shuffle -> bool // For declaring, Disorder the buttons but keep the actions in their position.
    length  -> int // For declaring, Number of inputs
    isFull  -> bool // When inputs == length
    isEmpty -> bool // When inputs is empty
    value   -> String // Inputs joined
    inputs  -> List<String> // List of inputs
    last    -> String // Last input or empty
    key     -> String // Button pressed value, does not apply to icons

```

## How to use it

### 1. Create a controller

```dart
// Declare controller
NPinController nPinController = NPinController(
    shuffle   : true,
    hideInputs: false
);

// Add a listener for notify changes
@override
void initState() {
    super.initState();
    nPinController.addListener(() => setState(() {}));
}

// Remove listener and destroy class controller
@override
void dispose() {
    super.dispose();
    nPinController.removeListener(() { });
    nPinController.dispose();
}
```

#### 2. Use the widget ;D

```dart
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
        onTap             : () async => await Future.delayed(Duration(seconds: 2), ()=> print(nPinController.value)), -->
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

```




