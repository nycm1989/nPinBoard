import 'package:flutter/material.dart';
import 'package:n_pin_board/src/models.dart';

class NPinController extends ChangeNotifier{
  List<List<ButtonValue>> board  = [];
  List<String> inputs   = [];
  int          _length  = 6;
  bool         _shuffle = false;
  bool         isFull   = false;
  bool         isEmpty  = true;
  String       value    = "";
  String       last     = "";
  String       key      = "";

  int get length  => _length;

  addInput(int number){
    key = number.toString();
    if (number >= 0 && number <= 10) {
      inputs.removeWhere((e) => e.isEmpty);
      if(inputs.length != _length) inputs.add(number.toString());
      value = inputs.join().trim();
      last = inputs.last.toString();

      isFull  = inputs.length == _length;
      isEmpty = false;
      _fillList();
    } else {
      Exception("number must be >= 0 and <= 10");
    }
    notifyListeners();
  }

  removeLast(){
    inputs.removeWhere((e) => e.isEmpty);
    if(inputs.isNotEmpty) inputs.removeLast();
    last = inputs.isEmpty ? "" : inputs.last.toString();

    value   = inputs.join().trim();
    isFull  = false;
    isEmpty = inputs.isEmpty;
    _fillList();
    notifyListeners();
  }

  clear(){
    board    = [];
    inputs   = [];
    isFull   = false;
    isEmpty  = true;
    value    = "";
    _buildBoard();
    _fillList();
    notifyListeners();
  }

  _fillList() {
    for (int i = inputs.length; i < _length; i++){
      inputs.add("");
    }
  }

  _buildBoard() {
    board.clear();
    List<ButtonValue> items = ButtonValue.values.map((e) => e).toList();
    if( _shuffle == true ) {
      do{
        items.shuffle();
        if (items.indexOf(ButtonValue.bL) != 9) {
          items[items.indexWhere((e) => e == ButtonValue.bL)] = items[9];
          items[9] = ButtonValue.bL;
        }
        if (items.indexOf(ButtonValue.bR) != 11) {
          items[items.indexWhere((e) => e == ButtonValue.bR)] = items[11];
          items[11] = ButtonValue.bR;
        }

      } while( ( items.where((e) => e == ButtonValue.bL).length > 1 ) && ( items.where((e) => e == ButtonValue.bR).length > 1 ));
    }

    for ( int b = 0; b < 4; b++ ) {
      List<ButtonValue> row = [];
      for ( int i = 0; i < 3; i++ ) {
        int pos = ( b * 3 ) + i;
        row.add( items[ pos ] );
      }
      board.add(row);
    }

    notifyListeners();
  }

  /// - [shuffle] Disorder the buttons but keep the actions in their position.
  /// - [length] number of inputs
  NPinController({shuffle = false, length = 6}) :
  assert( length > 3,  Exception('Length must be > 3' ) ),
  assert( length < 10, Exception('Length must be < 12') )
  {
    _shuffle  = shuffle;
    _length   = length;
    _fillList();
    _buildBoard();
  }
}

