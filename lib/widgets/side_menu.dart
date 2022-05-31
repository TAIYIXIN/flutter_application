
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_practice/constants/controllers.dart';
import 'package:flutter_practice/constants/style.dart';
import 'package:flutter_practice/controllers/navigation_controller.dart';
import 'package:flutter_practice/helpers/responsiveness.dart';
import 'package:flutter_practice/page/clients/client.dart';
import 'package:flutter_practice/routing/routes.dart';
import 'package:flutter_practice/widgets/custom_text.dart';
import 'package:flutter_practice/widgets/side_menu_item.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  

  const SideMenu({Key? key,}) : super(key: key);








  @override
  Widget build(BuildContext context) {

    double _width =MediaQuery.of(context).size.width;




    return Container(
      color: light,

      
        
      child: ListView(
        children:[
          (responsiveWidget.isSmallScreen(context))?
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 40),
                Row(               
                  children: [
                    SizedBox(width: _width/48),
                    Padding(padding: EdgeInsets.only(right: 12),
                    child: Image.asset("assets/icons/logo1.jpg",width: 30)
                    ),
                    Flexible(child: CustomText(
                      text: "Dash",
                      size: 20,
                      weight: FontWeight.bold,
                      color: active,
                      )
                    ),
                    SizedBox(width: _width/48)  
                  ],
                ),
                SizedBox(height: 40),
                Divider(color: lightGrey.withOpacity(0.1)),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children:sideMenuItems.map((itemName) => SideMenuItem(
                    itemName: itemName,
                      onTap: (){
                        print(itemName);
                        if(!menuController.isActive(itemName)){
                              menuController.changeActiveTo(itemName);
                          if(responsiveWidget.isSmallScreen(context)){
                            // print("a");
                            Get.back(); //退回menu
                              navigationcontroller.navigateTo(itemName);
                              
                              //go to item name Route
                          }
                        }
                      }
                    )
                  ).toList()
                )
              ],
            )  
          
          
          
          :Column(
                  mainAxisSize: MainAxisSize.min,
                  children:sideMenuItems.map((itemName) => SideMenuItem(
                    itemName: itemName,
                      onTap: (){
                        if(!menuController.isActive(itemName)){
                              menuController.changeActiveTo(itemName);
                              navigationcontroller.navigateTo(itemName);
                        }
                      }
                    )
                  ).toList()
                )

          
          ]
        )
    );
  }
}