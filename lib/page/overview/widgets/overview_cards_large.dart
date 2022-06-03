import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_practice/constants/controllers.dart';
import 'package:flutter_practice/page/overview/widgets/info_card.dart';

import 'calendar.dart';

class overviewcardsLargeScreen extends StatelessWidget {
  const overviewcardsLargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double _width=MediaQuery.of(context).size.width;

    return Row(

      children: [

        InfoCard(
          title: "date", 
          value: "6/4", 
          topColor: Colors.orange, 
          isActive: true, 
          onTap: (){}),

          SizedBox(width: _width/64,),
          InfoCard(
          title: "stationPressure", 
          value: "121", 
          topColor: Colors.orange, 
          isActive: true, 
          onTap: (){}),

          SizedBox(width: _width/64,),
          InfoCard(
          title: "temperature", 
          value: "25", 
          topColor: Colors.orange, 
          isActive: true, 
          onTap: (){}),

          SizedBox(width: _width/64,),
           InfoCard(
          title: "precipitation", 
          value: "220", 
          topColor: Colors.orange, 
          isActive: true, 
          onTap: (){}),



      ],


    );
  }
}