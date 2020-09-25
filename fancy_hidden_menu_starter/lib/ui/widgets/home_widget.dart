import 'package:fancy_hidden_menu/core/viewmodels/home_model.dart';
import 'package:fancy_hidden_menu/ui/widgets/screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeWidget extends Screen {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<HomeModel>(context);
    return Center(
      child: Text(model.active.name),
    );
  }
}
