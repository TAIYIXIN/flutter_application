







import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_practice/widgets/custom_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

import '../model/chartModel.dart';

class chart_wedget extends StatefulWidget {
    chart_wedget({Key? key}) : super(key: key);

  @override
  State<chart_wedget> createState() => _chart_wedgetState();
}

class _chart_wedgetState extends State<chart_wedget> {

    List<ChartData> maxTList=[];
    List<ChartData> minTList=[];
    List<ChartData> poP12h=[];
    num AvrMaxT=0;
    num AvrMinT=0;
    var count=0;

    final Uri host= Uri.parse('https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-063?Authorization=CWB-BD65111A-5962-4DB8-836A-BA4F2F43BD9B');


    Future loadChartData()async{
      final String jsonString = await getJsonFromAssets();
      final dynamic jsonReponse =jsonDecode(jsonString);

      var MaxT=finddata(jsonReponse,"MaxT");
      var MinT=finddata(jsonReponse,"MinT");
      var RainPop=finddata(jsonReponse,"PoP12h");

      for(Map<String,dynamic> i in MaxT ){
            i["time"]  =  DateTime.parse(i["time"]) ;   
            if(i['time'].hour == 6)
              i["time"]= '${i["time"].month}/${i["time"].day}\nmorning';
            else
              i["time"]= '${i["time"].month}/${i["time"].day}\nevening';
            
          AvrMaxT=AvrMaxT+ i['value'];
        count++;
        maxTList.add(ChartData.fromJson(i));
      }


      for(Map<String,dynamic> i in MinT ){
        i["time"]  =  DateTime.parse(i["time"]) ;   
        if(i['time'].hour == 6)
          i["time"]= '${i["time"].month}/${i["time"].day}\nmorning';
        else
          i["time"]= '${i["time"].month}/${i["time"].day}\nevening';
        
        AvrMinT=AvrMinT+i['value'];
        minTList.add(ChartData.fromJson(i));
      }

      for(Map<String,dynamic> i in RainPop ){
        i["time"]  =  DateTime.parse(i["time"]) ;
        if(i['time'].hour == 6)
          i["time"]= '${i["time"].month}/${i["time"].day}\nmorning';
        else
          i["time"]= '${i["time"].month}/${i["time"].day}\nevening';
        poP12h.add(ChartData.fromJson(i));
      }
      AvrMaxT=AvrMaxT/count;
      AvrMinT=AvrMinT/count;


    }
    Future<String> getJsonFromAssets()async{
      var response = await http.get(host);
      // print(response.body);
      return response.body;
      // return await rootBundle.loadString('jsons/F-D0047-063.json');
    }
    @override
    void initState(){
        loadChartData();
        super.initState();
    }



    finddata(json,key){
            List<Map<String,dynamic>>  TimeMapValue = [];
            String time;
            double value;    
            var city_count=json['records']['locations'][0]['location'].length;   //共12個區
            var city=json['records']['locations'][0]['location'];
            // 用時間去比對  這個時間的數值
            for(int i= 0 ; i<city_count ; i++){
              if(city[i]['locationName']=="中正區"){  //抓取中正區的資料
                for(int j= 0 ; j<city[i]['weatherElement'].length; j++){ 

                  if(city[i]['weatherElement'][j]['elementName']== "MaxT"  && key=="MaxT"){ //取出中正區最高溫的資料
                    for(int k=1 ; k<city[i]['weatherElement'][j]['time'].length;k++){ //根據每個時間抓出value
                      time=city[i]['weatherElement'][j]['time'][k]["startTime"];
                      value=double.parse(city[i]['weatherElement'][j]['time'][k]["elementValue"][0]["value"]) ;
                      TimeMapValue.add({"time":time, "value":value});
                    }
                    return TimeMapValue;
                  }
                  if(city[i]['weatherElement'][j]['elementName']== "MinT"  && key=="MinT"){ //取出中正區最低溫的資料
                    for(int k=1 ; k<city[i]['weatherElement'][j]['time'].length;k++){ //根據每個時間抓出value
                      time=city[i]['weatherElement'][j]['time'][k]["startTime"];
                      value=double.parse(city[i]['weatherElement'][j]['time'][k]["elementValue"][0]["value"]) ;
                      TimeMapValue.add({"time":time, "value":value});
                    }
                    return TimeMapValue;
                  }
                  if(city[i]['weatherElement'][j]['elementName']== "PoP12h"  && key=="PoP12h"){ //取出中正區降雨機率的資料
                    for(int k=1 ; k<city[i]['weatherElement'][j]['time'].length;k++){ //根據每個時間抓出value
                      time=city[i]['weatherElement'][j]['time'][k]["startTime"];
                      if(city[i]['weatherElement'][j]['time'][k]["elementValue"][0]["value"]==" "){
                          city[i]['weatherElement'][j]['time'][k]["elementValue"][0]["value"]='0';
                      }
                      value=double.parse(city[i]['weatherElement'][j]['time'][k]["elementValue"][0]["value"]) ;
                      TimeMapValue.add({"time":time, "value":value});
                    }
                    return TimeMapValue;
                  }
                }
              }
            }
        }




  @override
  Widget build(BuildContext context) {
    

        return FutureBuilder(
          future: getJsonFromAssets(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return Container(
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    labelPlacement: LabelPlacement.betweenTicks,
                    // interval:2,
                  ),
                  primaryYAxis: NumericAxis(
                    minimum: 0,
                    interval: 10,
                    maximum: 100,
                    labelFormat: "{value}%",
                  ),
                  axes:<ChartAxis>[
                    NumericAxis(
                      name: 'yAxis',
                      minimum: 17,
                      maximum: 35,
                      interval: 2,
                      opposedPosition: true
                    )
                  ],

                  series: <ChartSeries>[
                    LineSeries<ChartData,String>(
                      dataSource: maxTList,
                      color: Colors.brown,
                      width: 3,
                      xValueMapper: (ChartData data,_) =>data.time,
                      yValueMapper:(ChartData data,_) =>data.value,
                      yAxisName: 'yAxis'
                      ),
                      LineSeries<ChartData,String>(
                      dataSource: maxTList,
                      color: Colors.brown,
                      xValueMapper: (ChartData data,_) =>data.time,
                      yValueMapper:(ChartData data,_) =>AvrMaxT,
                      dashArray: <double>[5,5],
                      yAxisName: 'yAxis'
                      ),
                      LineSeries<ChartData,String>(
                      dataSource: minTList,
                      color: Colors.orange,
                      dashArray: <double>[5,5],
                      xValueMapper: (ChartData data,_) =>data.time,
                      yValueMapper:(ChartData data,_) =>AvrMinT,
                      yAxisName: 'yAxis'
                      ),
                      LineSeries<ChartData,String>(
                      dataSource: minTList,
                      width: 3,
                      xValueMapper: (ChartData data,_) =>data.time,
                      yValueMapper:(ChartData data,_) =>data.value,
                      yAxisName: 'yAxis'
                      ),
                      ColumnSeries<ChartData,String>(
                        dataSource: poP12h, 
                        width: 0.5,
                        xValueMapper: (ChartData data,_) =>data.time, 
                        yValueMapper: (ChartData data,_) =>data.value,
                      )

               
                  ],
              ),
            );;
            }
            return CircularProgressIndicator();
          });
          
  }
}
















