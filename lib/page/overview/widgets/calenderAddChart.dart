




import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_practice/page/overview/widgets/provider_.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/chartModel.dart';
import 'calendar.dart';

class calendarAddChart extends StatelessWidget {
  const calendarAddChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  double _width=MediaQuery.of(context).size.width;


    return Consumer(builder: ((context,provider Chartdata, child) {
      return Row(
        children: [
            Container(
              height: 400,
              width: _width/6,
              child: calendar()
            ),

            Expanded(child: Row(
              children: [
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(),
                    series: <ChartSeries>[
                    LineSeries<ChartData,String>(
                      dataSource: Chartdata.TempData, 
                      xValueMapper: (ChartData data ,_)=>data.time, 
                      yValueMapper: (ChartData data ,_)=>data.value,)
                    ],
                  ),
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(),
                    series: <ChartSeries>[
                    LineSeries<ChartData,String>(
                      dataSource: Chartdata.StationPressureData, 
                      xValueMapper: (ChartData data ,_)=>data.time, 
                      yValueMapper: (ChartData data ,_)=>data.value,)
                    ],
                  ),
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(),
                    series: <ChartSeries>[
                    LineSeries<ChartData,String>(
                      dataSource: Chartdata.PrecipitationData, 
                      xValueMapper: (ChartData data ,_)=>data.time, 
                      yValueMapper: (ChartData data ,_)=>data.value,)
                    ],
                  ),
                ],


                      
                    )),           














        ],
      );




    }));
  }
}