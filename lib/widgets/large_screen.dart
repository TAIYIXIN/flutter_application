import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_practice/helpers/local_navigator.dart';
import 'package:flutter_practice/widgets/side_menu.dart';
import 'package:get/get.dart';

class Largescreen extends StatefulWidget {
  const Largescreen({Key? key}) : super(key: key);

  @override
  State<Largescreen> createState() => _LargescreenState();
}

class _LargescreenState extends State<Largescreen> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
          Expanded(
            child:SideMenu(),),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: localNavigator(),
            ),
            
            )




        ],);
  }
}