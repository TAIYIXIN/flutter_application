




import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_practice/constants/style.dart';
import 'package:flutter_practice/page/overview/widgets/provider_.dart';
import 'package:flutter_practice/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/chartModel.dart';
import 'calendar.dart';

class calendarAddChart extends StatefulWidget {
  const calendarAddChart({Key? key}) : super(key: key);

  @override
  State<calendarAddChart> createState() => _calendarAddChartState();
}

class _calendarAddChartState extends State<calendarAddChart> {



  List<ChartData> stationPressureList=[];
  List<ChartData> TempList=[];
  List<ChartData> precipitationList=[];
  Future loadCalendarData()async{
    final String jsonString = await rootBundle.loadString("jsons/C-B0024-001.json") ;
    final dynamic jsonReponse =jsonDecode(jsonString);

    
    var temp=getCalendarData(jsonReponse,"temp");
    var stationPressure=getCalendarData(jsonReponse,"stationPressure");
    var precipitation=getCalendarData(jsonReponse,"precipitation");

    var a=-1;

    for(Map<String,dynamic> i in temp ){
      a++;
      i['time']=DateTime.parse(i['time']);
      i['value']=double.parse(i['value']);
      i['time']='${i['time'].month}/${i['time'].day}\n${i['time'].hour}點';
      
      TempList.add(ChartData.fromJson(i));
      // print(TempList[a].time);
    }
    
    
    for(Map<String,dynamic> i in stationPressure ){
      i['time']=DateTime.parse(i['time']);
      i['value']=double.parse(i['value']);
      i['time']='${i['time'].month}/${i['time'].day}\n${i['time'].hour}點';

      stationPressureList.add(ChartData.fromJson(i));
    }
    for(Map<String,dynamic> i in precipitation ){
      i['time']=DateTime.parse(i['time']);
      i['value']=double.parse(i['value']);
      i['time']='${i['time'].month}/${i['time'].day}\n${i['time'].hour}點';
      precipitationList.add(ChartData.fromJson(i));
    }    
 
  }

   getCalendarData(jsonData,key){
     
     List<Map<String,dynamic>> ListMapData=[];
    var content=jsonData['cwbdata']['resources']['resource']['data']['surfaceObs']['location'][3]['stationObsTimes']['stationObsTime'];
    var dataLenth=content.length;




    for(int i=0 ;i<dataLenth ; i++){
      var time=content[i]['dataTime'];

      if(key =="temp"){
        var temp =content[i]['weatherElements']['temperature'];
        ListMapData.add({"time":time,"value":temp});
      }
      if(key =="stationPressure"){
        var stationPressure=content[i]['weatherElements']['stationPressure'];
        ListMapData.add({"time":time,"value":stationPressure});

      }
      if(key == "precipitation"){
        var precipitation=content[i]['weatherElements']['precipitation'];
        if(precipitation=='T' || precipitation=='0.0'){
          precipitation='0';
        }
        ListMapData.add({"time":time,"value":precipitation});
      }
    }
    return ListMapData;




  }

    @override
    void initState(){
        loadCalendarData();
        super.initState();
    }
  


  


  @override
  Widget build(BuildContext context) {


  provider myprovider =Provider.of<provider>(context);
  double _width=MediaQuery.of(context).size.width;

  ChartSeriesController? chartSeriesController0;
  ChartSeriesController? chartSeriesController1;
  ChartSeriesController? chartSeriesController2;

  myprovider.AddPrecipitationData(precipitationList);
  myprovider.AddStationPressureData(stationPressureList);
  myprovider.AddTempData(TempList);





    return Consumer(builder: ((context,provider Chartdata, child) {
        
      return Expanded(
        child:
          SfCartesianChart(
    
            onLegendTapped: (LegendTapArgs args) {
                args.series.dataSource.add(ChartData('6/4', 25));
                
                args.series.isVisible(false) ;
                
            },
           
                      
            legend:Legend(
              isVisible: true,
              position: LegendPosition.bottom,
              toggleSeriesVisibility: true
            ) ,



              tooltipBehavior: TooltipBehavior(enable: true),
              zoomPanBehavior: ZoomPanBehavior(
              
                enableMouseWheelZooming: true,
                enableSelectionZooming: true,
                enablePanning: true,
                maximumZoomLevel: 0.7
              ),
              title: ChartTitle(
              text: "過去30天的天氣統整",
    
              borderWidth: 2,
              textStyle: TextStyle(
                    color: Colors.lightBlue,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    )    
              ),


              palette: [Colors.teal,Colors.red,Colors.blue],
              primaryYAxis: NumericAxis(
                decimalPlaces: 0,
              ),
              primaryXAxis: CategoryAxis(
                interval: 30
              ),
                // series:           
                series:<ChartSeries>[
                  LineSeries<ChartData,String>(
                 name: 'TempValue',
                 dataSource: Chartdata.TempData, 
                 xValueMapper: (ChartData data,_)=>data.time, 
                 yValueMapper: (ChartData data,_)=>data.value,
                 isVisible: true

                ),                 
                LineSeries<ChartData,String>(
                 name: 'RainValue',
                 dataSource:Chartdata.PrecipitationData,
                 xValueMapper: (ChartData data,_)=>data.time, 
                 yValueMapper: (ChartData data,_)=>data.value,
                 onRendererCreated:(ChartSeriesController controller){
                    chartSeriesController1 = controller;
                 }
                 ),
                LineSeries<ChartData,String>(
                 name: 'StationPressure',
                 dataSource: Chartdata.StationPressureData,
                 xValueMapper: (ChartData data,_)=>data.time, 
                 yValueMapper: (ChartData data,_)=>data.value, 
                 onRendererCreated:(ChartSeriesController controller){
                 chartSeriesController2 = controller;
                  }
                  )
                ]
          )
      );

        
     





    }));
  }
}