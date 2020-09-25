import 'package:fancy_hidden_menu/core/enums/enum.dart';
import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
 
  double _verticalDragStart = 0.0;
  get verticalDragStart => _verticalDragStart;
  set verticalDragStart(value) {
    _verticalDragStart = value;
    notifyListeners();
  }

  BoxScrollDirection boxScrollDirection;
  void setBoxScrollDirection(BoxScrollDirection value) {
    boxScrollDirection = value;
    notifyListeners();
  }
}
