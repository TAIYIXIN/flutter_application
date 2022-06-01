import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_practice/page/overview/widgets/provider_.dart';
import 'package:flutter_practice/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/chartModel.dart';








class calendar extends StatefulWidget {
   calendar({Key? key}) : super(key: key);

  

  @override
  State<calendar> createState() => _calendarState();
}

class _calendarState extends State<calendar> {

  DateTime ?_selectedDay;
  DateTime _focusedDay = DateTime.now();

  
  List TempList=[];
  List stationPressureList=[];
  List precipitationList=[];
  String time='';
  
 
  Future loadCalendarData()async{
    final String jsonString = await rootBundle.loadString("/jsons/C-B0024-001.json") ;
    final dynamic jsonReponse =jsonDecode(jsonString);

    
    var temp=getCalendarData(jsonReponse,"temp");
    var stationPressure=getCalendarData(jsonReponse,"stationPressure");
    var precipitation=getCalendarData(jsonReponse,"precipitation");



    for(Map<String,dynamic> i in temp ){
      
      i['time']=DateTime.parse(i['time']);
      i['value']=double.parse(i['value']);
      i['time']='${i['time'].month}/${i['time'].day}\n${i['time'].hour}點';
      
      TempList.add(ChartData.fromJson(i));
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
    List<ChartData> selectTimeTemp=[];
    List<ChartData> selectTimeStatinPressure=[];
    List<ChartData> selectTimePrecipitation=[];
    provider myprovider =Provider.of<provider>(context);
      return Container(
        child: TableCalendar(
            firstDay: DateTime.utc(2022,5,1),
            lastDay: DateTime.utc(2022,5,31),
            focusedDay: DateTime.utc(2022,5,31),
            selectedDayPredicate: (day){
            return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay,focusedDay){

              time ="${selectedDay.month}/${selectedDay.day}\n";
              

              for(int i=0 ;i<TempList.length;i++){
                if(TempList[i].time.contains(time)){
                  selectTimeTemp.add(TempList[i]);
                }
              }
              for(int i=0 ;i<stationPressureList.length;i++){
                if(stationPressureList[i].time.contains(time)){
                  selectTimeStatinPressure.add(stationPressureList[i]);
                }
              }    
              for(int i=0 ;i<precipitationList.length;i++){
                if(precipitationList[i].time.contains(time)){
                  selectTimePrecipitation.add(precipitationList[i]);
                }
              }



              myprovider.AddTempData(selectTimeTemp);
              myprovider.AddPrecipitationData(selectTimePrecipitation);
              myprovider.AddStationPressureData(selectTimeStatinPressure);
              selectTimeTemp=[];
              selectTimePrecipitation=[];
              selectTimeStatinPressure=[];
          
              
              setState(() {
                _selectedDay = selectedDay;
                  _focusedDay = focusedDay;    
              });
        },
      )
          
        
      ); 
  }
}