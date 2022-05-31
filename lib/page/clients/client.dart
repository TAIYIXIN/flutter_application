import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_practice/helpers/responsiveness.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../constants/controllers.dart';
import '../../widgets/custom_text.dart';

class clientpage extends StatelessWidget {
  const clientpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx((() => Row(

          children: [
            Container(
              margin: EdgeInsets.only(top: responsiveWidget.isSmallScreen(context)?56 :8),
              child: CustomText(
                text: menuController.activeItem.value,
                size: 24,
                color: Colors.black,
                weight: FontWeight.bold,
              ),
            ),
          ]
        )))



      ],


    );
  }
}