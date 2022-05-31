import 'package:flutter/cupertino.dart';
import 'package:flutter_practice/page/overview/model/chartModel.dart';

class provider with ChangeNotifier{
List<ChartData> _TempData=[];
List<ChartData> _StationPressureData=[];
List<ChartData> _PrecipitationData=[];

get TempData =>_TempData;
get StationPressureData =>_StationPressureData;
get PrecipitationData =>_PrecipitationData;
provider();


AddTempData(x){
  _TempData=x;
  notifyListeners();
}
AddStationPressureData(x){
  _StationPressureData=x;
  notifyListeners();
}

AddPrecipitationData(x){
  _PrecipitationData=x;
  notifyListeners();
}





}