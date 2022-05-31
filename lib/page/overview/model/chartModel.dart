import 'dart:convert';

import 'package:flutter/services.dart';

class ChartData {
        ChartData(this.time, this.value);
        final String time;
        final double value;





 factory ChartData.fromJson(Map<String, dynamic> parsedJson) {
    return ChartData(
      parsedJson['time'],
      parsedJson['value'],
    );
  }
    }

