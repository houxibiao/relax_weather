

class WeatherData{

  String condition; //天气
  String temperature;//温度
  String humidity;   //湿度
  String updatetime;//更新时间

  WeatherData({this.condition,this.temperature,this.humidity,this.updatetime});

  factory WeatherData.fromJson(Map<String,dynamic> json){
    return WeatherData(
      condition: json['HeWeather6'][0]['now']['cond_txt'],
      temperature: json['HeWeather6'][0]['now']['tmp'],
      humidity: "湿度"+json['HeWeather6'][0]['now']['hum']+"%",
      updatetime: "更新时间"+json['HeWeather6'][0]['update']['loc'],
    );
  }

  factory WeatherData.empty(){
    return WeatherData(
      condition: "无",
      temperature: "--",
      humidity: "--",
      updatetime: "--"
    );
  }

}