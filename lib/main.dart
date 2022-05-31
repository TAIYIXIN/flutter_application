import 'package:flutter/material.dart';
import 'package:flutter_practice/constants/style.dart';
import 'package:flutter_practice/controllers/menu_controller.dart';
import 'package:flutter_practice/controllers/navigation_controller.dart';
import 'package:flutter_practice/layout.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  Get.put(navigationController());
  Get.put(MenuController());
  runApp(MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Dash",
        theme: ThemeData(
          scaffoldBackgroundColor: light,
          textTheme: GoogleFonts.mulishTextTheme(
            Theme.of(context).textTheme
          ).apply(
            bodyColor: Colors.black
          ),
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS:FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android:FadeUpwardsPageTransitionsBuilder()
          }),
          primaryColor: Colors.blue
        ),
        home: siteLayout(),

    );
  }
}




