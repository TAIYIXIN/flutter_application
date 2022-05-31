
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_practice/widgets/small_screen.dart';


const int largeScreenSize=1366;
const int mediumScreenSize=768;
const int smallScreenSize=360;
const int customScreenSize=1100;



class responsiveWidget extends StatelessWidget {


  final Widget largeScreen;
  // final Widget mediumScreen;
  final Widget smallScreen;
  const responsiveWidget({
    Key? key, 
    required this.largeScreen, 
    // required this.mediumScreen, 
    required this.smallScreen, }) : super(key: key);



static bool isSmallScreen(BuildContext context) =>
  MediaQuery.of(context).size.width < mediumScreenSize;

// static bool ismediumScreen(BuildContext context) =>
//   MediaQuery.of(context).size.width >= mediumScreenSize &&
//   MediaQuery.of(context).size.width < largeScreenSize;  

static bool islargeScreen(BuildContext context) =>
  MediaQuery.of(context).size.width >= largeScreenSize;

static bool isCustomScreen(BuildContext context) =>
  MediaQuery.of(context).size.width >= mediumScreenSize&&
  MediaQuery.of(context).size.width < largeScreenSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double _width = constraints.maxWidth;

      if(_width < mediumScreenSize){
        return smallScreen;
      }
      // else if(_width<largeScreenSize && _width>mediumScreenSize){
      //   return mediumScreen;
      // }
      else{
        return largeScreen;
      }

    });
  }
}