import 'package:flutter/material.dart';
import 'package:relax_weather/weatherdata.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return WeatherState();
  }
}

class WeatherState extends State<WeatherWidget> {

  WeatherState(){
    _getWeather();
  }

  WeatherData weather = WeatherData.empty();

  void _getWeather() async{
    WeatherData data = await _fetchWeatherData();
    setState(() {
     weather = data; 
    });
  }

  Future<WeatherData> _fetchWeatherData() async{
      final response = await http.get('https://free-api.heweather.com/s6/weather/now?location=北京&key=20190211');
      if(response.statusCode==200){
        return WeatherData.fromJson(json.decode(response.body));
      }
      else{
        print(response.statusCode);
        return WeatherData.fromJson(json.decode(response.body));
        //return WeatherData.empty();
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset("sources/images/timg.jpg",
          fit: BoxFit.fitHeight,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 48.0),
                child: Text(
                  '北京',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 100.0),
                child: Column(
                  children: <Widget>[
                    Text(weather?.Temperature,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80.0,
                    ),),
                    Text(
                      weather?.Condition,
                      style: TextStyle(
                        color:Colors.white,
                        fontSize: 50.0
                      ),
                    ),
                    Text(
                      weather?.Humidity,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}