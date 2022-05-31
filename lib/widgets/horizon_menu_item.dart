import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_practice/constants/controllers.dart';
import 'package:flutter_practice/constants/style.dart';
import 'package:flutter_practice/helpers/responsiveness.dart';
import 'package:flutter_practice/routing/routes.dart';
import 'package:flutter_practice/widgets/custom_text.dart';
import 'package:get/get.dart';

class HorizontalMenuItem extends StatelessWidget {


  final String itemName;
  final Function onTap;

  const HorizontalMenuItem({Key? key, required this.itemName, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    double _width = MediaQuery.of(context).size.width;


  

    return InkWell(
          
  
      
      onTap:(){  
        onTap();  
      },
      onHover: (value){
        value ?
        menuController.onHover(itemName) :
        menuController.isHovering("not hovering");
        // print(itemName);
      },
      child: Obx(()=> Container(

        color: menuController.isHovering(itemName) 
        ? lightGrey.withOpacity(0.1)
        : Colors.transparent,
        
        child: Row(
          children: [ 
              //長長的柱子
              Visibility(
                visible: menuController.isHovering(itemName) || menuController.isActive(itemName),
                child:Container(
                  width: 6,
                  height: 40,
                  color: dark
                ),
              maintainSize: true, maintainState: true, maintainAnimation: true),
              
              SizedBox(width: _width/80 ),
              //icon圖案
              Padding(padding: EdgeInsets.all(16),
                child: menuController.returnIconFor(itemName)
              ),
              if(!menuController.isActive(itemName))
                Flexible(child: CustomText(
                  text: itemName, 
                  size: 16, 
                  color: menuController.isHovering(itemName)?dark:lightGrey, 
                  weight: FontWeight.normal)
                )
              else
              Flexible(child: CustomText(
                text: itemName,
                color: dark,
                size: 18,
                weight: FontWeight.bold
                )
              )
          ],
        ),
      )),
    );
  }
}