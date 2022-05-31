import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_practice/constants/controllers.dart';
import 'package:flutter_practice/constants/style.dart';
import 'package:flutter_practice/controllers/menu_controller.dart';
import 'package:get/get.dart';

class verticalMenuItem extends StatelessWidget {

  final String itemName;
  final Function onTap;

  const verticalMenuItem({Key? key, required this.itemName, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double _width =MediaQuery.of(context).size.width;
    return InkWell(

      onTap: onTap(),
      // onHover: (value){
        // value ?
        // menuController.onHover(itemName):
        // menuController.onHover("not Hovering");
      // },

      child: Obx(()=>Container(
        color: menuController.isHovering(itemName)?
          lightGrey.withOpacity(0.1):Colors.transparent,
      )),
    


    );
  }
}