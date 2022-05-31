class calendarData{
  final String time;
  final dynamic value;
  calendarData(this.time, this.value);

   factory calendarData.fromJson(Map<String, dynamic> parsedJson) {
    return calendarData(
      parsedJson['time'],
      parsedJson['value'],
    );
  }

}