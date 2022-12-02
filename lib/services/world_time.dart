import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime{
  late String location;//location name for the UI
  late String time; // time in that location
  late String flag; // url to an asset flag icon
  late String url; // location url for api endpoint
  late bool isDaytime;

  WorldTime({required this.location, required this.flag, required this.url});


  Future<void> getTime() async{
     try{
       //make the request
       var response = await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
       Map data = jsonDecode(response.body);

       // get properties from data
       String datetime = data['datetime'];
       String offset = data['utc_offset'].substring(1,3);
       //print(datetime);
       //print(offset);

       //create a datetime object
       DateTime now = DateTime.parse(datetime);
       now = now.add(Duration(hours: int.parse(offset)));

       //set the time property
       isDaytime = now.hour > 6 && now.hour < 20 ? true: false;
       time = DateFormat.jm().format(now);
     }catch(e){
       print('caught error $e');
       time = 'Could not get time...';
     }
  }

}