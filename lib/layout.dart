import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_practice/helpers/responsiveness.dart';
import 'package:flutter_practice/widgets/large_screen.dart';
import 'package:flutter_practice/widgets/side_menu.dart';
import 'package:flutter_practice/widgets/small_screen.dart';
import 'package:flutter_practice/widgets/top_nav.dart';

class siteLayout extends StatefulWidget {
  @override
  State<siteLayout> createState() => _siteLayoutState();
}

class _siteLayoutState extends State<siteLayout> {
final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:scaffoldkey,
      drawer: Drawer(child: SideMenu()),
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(context, scaffoldkey),
      body: responsiveWidget(largeScreen: Largescreen() , smallScreen: SmallScreen(),)



    );
  }
}