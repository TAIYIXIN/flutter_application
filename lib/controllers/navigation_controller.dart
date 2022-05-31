import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class navigationController extends GetxController {


  static navigationController instance =Get.find();
  final GlobalKey<NavigatorState> navigationkey =GlobalKey();

  Future<dynamic> navigateTo(String routeName){
    return navigationkey.currentState!.pushNamed(routeName);
  }
  
  goBack() => navigationkey.currentState!.pop();

}