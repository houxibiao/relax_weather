import 'package:flutter/material.dart';

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
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
                    Text('20',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80.0,
                    ),),
                    Text(
                      "晴",
                      style: TextStyle(
                        color:Colors.white,
                        fontSize: 50.0
                      ),
                    ),
                    Text(
                      "湿度 45%",
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