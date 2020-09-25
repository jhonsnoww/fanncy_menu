import 'package:fancy_hidden_menu/core/models/models.dart';
import 'package:fancy_hidden_menu/core/viewmodels/home_model.dart';
import 'package:fancy_hidden_menu/ui/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuList extends StatelessWidget {
  final MenuData item;
  const MenuList({this.item});
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<HomeModel>(context);
    bool active = model.active == item;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          model.active = item;
          model.toggle();
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 80,
          decoration: BoxDecoration(
              color: active
                  ? Global.white
                  : Global.lightBlue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Icon(item.icon),
              SizedBox(
                width: 10,
              ),
              Text(item.name)
            ],
          ),
        ),
      ),
    );
  }
}
