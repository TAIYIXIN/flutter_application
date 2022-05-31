import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_practice/helpers/responsiveness.dart';
import 'package:flutter_practice/widgets/horizon_menu_item.dart';
import 'package:flutter_practice/widgets/vertical_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  
  final String itemName;
  final Function onTap;

  const SideMenuItem({Key? key, required this.itemName, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // if(responsiveWidget.isCustomScreen(context))
    //   return verticalMenuItem(itemName: itemName, onTap: onTap);

    return HorizontalMenuItem(itemName: itemName, onTap: onTap);


  }
}