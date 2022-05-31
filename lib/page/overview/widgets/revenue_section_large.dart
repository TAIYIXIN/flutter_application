import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_practice/constants/style.dart';
import 'package:flutter_practice/page/overview/widgets/bar_chart.dart';
import 'package:flutter_practice/page/overview/widgets/revenue_info.dart';
import 'package:flutter_practice/widgets/custom_text.dart';

class RevenueSectionLarge extends StatefulWidget {
  const RevenueSectionLarge({Key? key}) : super(key: key);

  @override
  State<RevenueSectionLarge> createState() => _RevenueSectionLargeState();
}

class _RevenueSectionLargeState extends State<RevenueSectionLarge> {
  @override
  Widget build(BuildContext context) {

    double _width=MediaQuery.of(context).size.width;
    
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: Offset(0,6),
            color: lightGrey.withOpacity(0.1),
            blurRadius: 12
          )
        ],
        border: Border.all(color: lightGrey,width: 4)),

      child: Row(
        children: [

          Container(                         //chart
            
            width: _width/4*2,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
                text: "Revenue Chart", 
                size: 20, 
                color: lightGrey, 
                weight: FontWeight.bold),
              Container(
               child: chart_wedget()
              ),

            ],
          )),

          Container(
            width: 1, 
            height: 120,
            color: lightGrey,
          ),




          Container(
            margin: EdgeInsets.only(left: 10),
            width: _width/4*1,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  RevenueInfo(
                    amount: "23", 
                    title: "Today\'s revenue",
                  ),
                  RevenueInfo(
                    amount: "150", 
                    title: "Last 7 days",

                  ),
                  SizedBox(
                    height: 30,
                    ),

                ],
              ),
                  Row(
                    children: [
                       RevenueInfo(
                    amount: "1203", 
                    title: "Last 30 days",

                  ),

                   RevenueInfo(
                    amount: "3,234", 
                    title: "Last 12 months",

                  ),
                    ],
                  )



            



            ],



          ))




        ],
      ),



    );
  }
}