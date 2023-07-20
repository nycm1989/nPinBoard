import 'package:flutter/material.dart';

class NPinController extends ChangeNotifier{
  List<String>  _i = [];
  int           _l = 6;
  bool          shuffle = false;
  bool          isFull  = false;
  bool          hideInputs = false;

  List<String>  get inputs  => _i;
  int           get length  => _l;

  set inputs      ( List<String> i ) { _i = i; notifyListeners(); }
  set length      ( int l          ) { _l = l; notifyListeners(); }

  set addInput    ( String i ) {
    _i.add(i);
    isFull = _i.length == _l;
    notifyListeners();
  }

  set removeInput ( String i ) {
    _i.removeLast() ;
    isFull = false;
    notifyListeners();
  }


  NPinController({this.shuffle = false, this.hideInputs = false});
}