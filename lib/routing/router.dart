

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/page/clients/client.dart';
import 'package:flutter_practice/page/drivers/driver.dart';
import 'package:flutter_practice/page/overview/overview.dart';
import 'package:flutter_practice/routing/routes.dart';

import '../page/auth/auth.dart';

Route<dynamic> generateRoute(RouteSettings settings){

  switch(settings.name){

    case OverViewPageRoute:
      return _getPageRoute(overviewpage());

    case DriverPageRoute:
      return _getPageRoute(driverpage());
      case ClientsPageRoute:
        return _getPageRoute(clientpage());
      case AuthenticationPageRoute:
        return _getPageRoute(authpage());
      default:
        return _getPageRoute(overviewpage());
  }
}

      //形成跳轉畫面
PageRoute _getPageRoute(Widget child){
  return MaterialPageRoute(builder: ((context) => child));
}