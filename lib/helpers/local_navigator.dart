

import 'package:flutter/cupertino.dart';
import 'package:flutter_practice/constants/controllers.dart';
import 'package:flutter_practice/controllers/navigation_controller.dart';
import 'package:flutter_practice/routing/router.dart';
import 'package:flutter_practice/routing/routes.dart';

Navigator localNavigator() => Navigator(
  key: navigationcontroller.navigationkey,
  initialRoute: OverViewPageRoute,
  onGenerateRoute: generateRoute
);