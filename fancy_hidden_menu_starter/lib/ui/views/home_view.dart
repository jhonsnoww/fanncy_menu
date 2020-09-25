import 'package:fancy_hidden_menu/core/enums/enum.dart';
import 'package:fancy_hidden_menu/core/viewmodels/home_model.dart';
import 'package:fancy_hidden_menu/ui/shared/globals.dart';
import 'package:fancy_hidden_menu/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<HomeModel>(context);
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Global.darkBlue,
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Stack(
          children: <Widget>[
            AnimatedList(
              key: Global.globalKey,
              initialItemCount: model.listTitles.length,
              itemBuilder: (BuildContext context, int index,
                  Animation<double> animation) {
                return SlideTransition(
                    position: animation.drive(model.tween),
                    child: MenuList(
                      item: model.listTitles[index],
                    ));
              },
            ),
            GestureDetector(
              onVerticalDragStart: (start) {
                model.verticalDragStart = start.globalPosition.dy;
              },
              onVerticalDragUpdate: (update) {
                if (model.verticalDragStart > update.globalPosition.dy) {
                  model.setBoxScrollDirection(BoxScrollDirection.Up);
                } else {
                  model.setBoxScrollDirection(BoxScrollDirection.Down);
                }
              },
              onVerticalDragEnd: (_) {
                if (model.boxScrollDirection == BoxScrollDirection.Up &&
                    model.isToggled) {
                  model.toggle();
                  print("Swiped UP");
                } else if (model.boxScrollDirection ==
                        BoxScrollDirection.Down &&
                    !model.isToggled) {
                  print("Swiped Down");
                  model.toggle(height: h);
                }
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                transform: Matrix4.identity()..translate(0.0, model.translateY),
                child: Screen(
                  builder: (context) => HomeWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
