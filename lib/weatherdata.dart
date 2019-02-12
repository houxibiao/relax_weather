

class WeatherData{

  String Condition; //天气
  String Temperature;//温度
  String Humidity;   //湿度
  String updatetime;//更新时间

  WeatherData({this.Condition,this.Temperature,this.Humidity,this.updatetime});

  factory WeatherData.fromJson(Map<String,dynamic> json){
    return WeatherData(
      Condition: json['HeWeather6'][0]['now']['cond_txt'],
      Temperature: json['HeWeather6'][0]['now']['tmp'],
      Humidity: "湿度"+json['HeWeather6'][0]['now']['hum']+"%",
      updatetime: "更新时间"+json['HeWeather6'][0]['update']['loc'],
    );
  }

  factory WeatherData.empty(){
    return WeatherData(
      Condition: "无",
      Temperature: "--",
      Humidity: "--",
      updatetime: "--"
    );
  }

}