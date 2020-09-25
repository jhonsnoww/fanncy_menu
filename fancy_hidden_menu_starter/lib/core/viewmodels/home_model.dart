import 'package:fancy_hidden_menu/core/models/models.dart';
import 'package:fancy_hidden_menu/core/viewmodels/base_model.dart';
import 'package:fancy_hidden_menu/ui/shared/globals.dart';
import 'package:fancy_hidden_menu/ui/widgets/menu_list_widget.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class HomeModel extends BaseModel {
  List<MenuData> listTitles = [];

  double translateY = 0.0;
  bool isToggled = false;

  void toggle({height}) {
    isToggled = !isToggled;
    _getListTitles();
    if (isToggled) {
      translateY = height - 180;
      _uploadItem();
    } else {
      translateY = 0.0;
      _deleteItem();
    }

    notifyListeners();
  }

  MenuData _active = MenuData.fromMap(Global.menuItems.first);

  MenuData get active => _active;
  set active(value) {
    _active = value;
    notifyListeners();
  }

  void _getListTitles() {
    listTitles = Global.menuItems.map((e) => MenuData.fromMap(e)).toList();
  }

  Animatable<Offset> get tween => _tween();
  Animatable<Offset> _tween() {
    var begin = Offset(0.0, 1.0);
    var end = Offset.zero;
    var tween = Tween(begin: begin, end: end)
        .chain(CurveTween(curve: Curves.easeInOutQuart));
    return tween;
  }

  void _uploadItem() async {
    for (var i = 0; i < Global.menuItems.length; i++) {
      await Future.delayed(Duration(milliseconds: 75), () {
        Global.globalKey.currentState
            .insertItem(i, duration: Duration(milliseconds: 500));
      });
    }
  }

  void _deleteItem() {
    for (var i = Global.menuItems.length - 1; i >= 0; --i) {
      MenuData deletedItem = listTitles.removeAt(i);
      Global.globalKey.currentState.removeItem(i, (context, animation) {
        return SlideTransition(
            position: animation.drive(tween),
            child: MenuList(item: deletedItem));
      }, duration: Duration(milliseconds: 500));
    }
  }
}
