import 'package:flutter/material.dart';
import 'package:relax_weather/weatherdata.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'forecastdata.dart';

class WeatherWidget extends StatefulWidget {
  // String cityname;
  List<String> citylist;

  WeatherWidget(this.citylist);

  @override
  State<StatefulWidget> createState() {
    return WeatherState(this.citylist);
  }
}

class WeatherState extends State<WeatherWidget> {
  //String cityname;
  List<String> citylist;
  int currentcityindex = 0;

  WeatherData weather = WeatherData.empty();
  WeatherData weathernow_data = WeatherData.empty();
  List<ForecastData> forecastlist =
      new List(3); //创建指定长度的列表，因为build函数先于_getforecast()执行，所以build无法预先获取其长度
  List<ForecastData> forecastdata =
      new List<ForecastData>.filled(3, ForecastData('-', '-', '-', '-', '-'));

  WeatherState(List<String> citylist) {
    //构造器
    this.citylist = citylist;
    print('weatherstate执行|n');
    print('the length of the citylist : '+citylist.length.toString());
    //_getWeather();
  }

  Future<void> _getWeather(int index) async {
    forecastlist = await _fetchForecastData(index);
    weathernow_data = await _fetchWeatherData(index);
    print('getweather is loading the data of' + index.toString());

    setState(() {
      forecastdata = forecastlist;
      weather = weathernow_data;
    });
  }

  Future<WeatherData> _fetchWeatherData(int index) async {
    final response = await http.get(
        'https://api.heweather.com/s6/weather/now?location=${this.citylist[index]}&key=49737baf0eb147ae9b35ff744fc47a2b');
    //注意此处的key不是key名称，而是密钥
    if (response.statusCode == 200) {
      return WeatherData.fromJson(json.decode(response.body));
    } else {
      print(response.statusCode);
      return WeatherData.empty();
    }
  }

  Future<List<ForecastData>> _fetchForecastData(int index) async {
    List<ForecastData> datalist = new List<ForecastData>();
    final reponse2 = await http.get(
        'https://api.heweather.net/s6/weather/forecast?location=${this.citylist[index]}&key=49737baf0eb147ae9b35ff744fc47a2b');
    if (reponse2.statusCode == 200) {
      Map<String, dynamic> result = json.decode(reponse2.body);
      for (dynamic data in result['HeWeather6'][0]['daily_forecast']) {
        ForecastData forecastData = ForecastData(data['date'], data['tmp_max'],
            data['tmp_min'], data['cond_txt_d'], data['cond_txt_n']);
        datalist.add(forecastData);
      }
      return datalist;
    } else {
      print("can't get the forecast data. The error code is" +
          reponse2.statusCode.toString());
      return datalist;
    }
  }

  onPageChanged(index) {
    print('onpagechanged is running');
    currentcityindex = index;
    _getWeather(index);
  }

  final _pageController = PageController(
    viewportFraction: 1.0,
  );

  @override
  Widget build(BuildContext context) {
    print('build执行');
    return new Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: (index) {
          onPageChanged(index);
        },
        itemBuilder: (BuildContext context, int index) =>
            _buildweatherpage(context, index),
        itemCount: this.citylist.length,
      ),
    );
  }

  Widget _buildweatherpage(BuildContext context, int index) {
   //onPageChanged(index);
   print('the value of the currentpage: '+currentcityindex.toString());
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          "sources/images/timg.jpg",
          fit: BoxFit.fitHeight,
        ),
        ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 48.0),
                  child: Text(
                    '${this.citylist[index]}',
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
                      Text(
                        weather?.temperature,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 80.0,
                        ),
                      ),
                      Text(
                        weather?.condition,
                        style: TextStyle(color: Colors.white, fontSize: 50.0),
                      ),
                      Text(
                        weather?.humidity,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        weather?.updatetime,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          forecastdata[0]?.date,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '${forecastdata[0].con_day} / ${forecastdata[0].con_night}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '${forecastdata[0].tmp_max} / ${forecastdata[0].tmp_min}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          forecastdata[1]?.date,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '${forecastdata[1].con_day} / ${forecastdata[1].con_night}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '${forecastdata[1].tmp_max} / ${forecastdata[1].tmp_min}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          forecastdata[2]?.date,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '${forecastdata[2].con_day} / ${forecastdata[2].con_night}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '${forecastdata[2].tmp_max} / ${forecastdata[2].tmp_min}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
