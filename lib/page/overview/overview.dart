

import 'dart:developer';
import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_practice/constants/controllers.dart';
import 'package:flutter_practice/constants/style.dart';
import 'package:flutter_practice/helpers/responsiveness.dart';
import 'package:flutter_practice/page/overview/widgets/calendar.dart';
import 'package:flutter_practice/page/overview/widgets/calenderAddChart.dart';
import 'package:flutter_practice/page/overview/widgets/overview_cards_large.dart';
import 'package:flutter_practice/page/overview/widgets/provider_.dart';
import 'package:flutter_practice/page/overview/widgets/revenue_section_large.dart';
import 'package:flutter_practice/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'model/chartModel.dart';

class overviewpage extends StatelessWidget {
  const overviewpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width=MediaQuery.of(context).size.width;
     
    return ChangeNotifierProvider(
      create: ((context) => provider()),
      child:Column(
      children: [
      
        Obx(() => Row(
          children: [
            Container(    //OverView 
            
              margin: EdgeInsets.only(top: responsiveWidget.isSmallScreen(context)?56 :6),
              
              child: CustomText(
                text: menuController.activeItem.value,
                size: 24,
                color: Colors.black,
                weight: FontWeight.bold,
              ),
            ),              
          ]
        )),


  
    
        
        Expanded(
          child: 
          
          ListView(
            children: [
              // overviewcardsLargeScreen(),
              calendarAddChart(),
              RevenueSectionLarge(),
            ],
          )    
        ),
      ],
    )  ,
      
      );
  }
}






