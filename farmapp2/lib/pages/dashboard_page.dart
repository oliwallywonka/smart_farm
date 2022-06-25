

import 'package:farmapp2/models/food.dart';
import 'package:farmapp2/models/humidity.dart';
import 'package:farmapp2/models/temperature.dart';
import 'package:farmapp2/models/whater.dart';
import 'package:farmapp2/services/socket_service.dart';
import 'package:farmapp2/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class DashboardPage extends StatefulWidget{

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with AutomaticKeepAliveClientMixin{

  SocketService socketService;
  double humidity;
  double temperature;
  double whater;
  double food;
  String humiditySensor;
  String temperatureSensor;
  String whaterSensor;
  String foodSensor;

  int maxHumiditySize = 0;
  int maxTemperatureSize = 0;
  int maxfoodSize = 0;
  int maxWaterSize = 0;
  

  List<SensorSeries> humidityData = [];
  List<SensorSeries> foodData = [];
  List<SensorSeries> temperatureData = [];
  List<SensorSeries> waterData = [];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    this.socketService = Provider.of<SocketService>(context,listen: false);
    this.socketService.socket.on("humidity", _listenHumidity);
    this.socketService.socket.on("temperature", _listenTemperature);
    this.socketService.socket.on("food", _listenFood);
    this.socketService.socket.on("whater", _listenWhater);

  }

  _listenHumidity(dynamic payload){
    Humidity newHumidity = humidityFromJson(payload);
    setState(() {
      this.humidity = newHumidity.humidity;
      this.humiditySensor = newHumidity.sensor;
      if(this.humidityData.length <= 4){
        this.humidityData.add(SensorSeries(
          time: "${TimeOfDay.now().minute}:${DateTime.now().second}",
          data: this.humidity.toInt()
        ));
      }else{
        this.humidityData.removeAt(0);
        this.humidityData.add(SensorSeries(
          time: "${TimeOfDay.now().minute}:${DateTime.now().second}",
          data: this.humidity.toInt()
        ));
      }
      
    });
    
  }

  _listenTemperature (dynamic payload){
    Temperature newTemperature = temperatureFromJson(payload);
    setState(() {
      this.temperature = newTemperature.temperature;
      this.temperatureSensor = newTemperature.sensor;
      if(this.temperatureData.length <= 4){
        this.temperatureData.add(SensorSeries(
          time: "${TimeOfDay.now().minute}:${DateTime.now().second}",
          data: this.temperature.toInt()
        ));
      }else{
        this.temperatureData.removeAt(0);
        this.temperatureData.add(SensorSeries(
          time: "${TimeOfDay.now().minute}:${DateTime.now().second}",
          data: this.temperature.toInt()
        ));
      }
    });
  }

  _listenFood (dynamic payload){
    Food newFood = foodFromJson(payload);
    setState(() {
      this.food = newFood.food;
      this.foodSensor = newFood.sensor;
      if(this.foodData.length <= 4){
        this.foodData.add(SensorSeries(
          time: "${TimeOfDay.now().minute}:${DateTime.now().second}",
          data: this.food.toInt()
        ));
      }else{
        this.foodData.removeAt(0);
        this.foodData.add(SensorSeries(
          time: "${TimeOfDay.now().minute}:${DateTime.now().second}",
          data: this.food.toInt()
        ));
      }
    });
  }

  _listenWhater (dynamic payload){
    Whater newWhater = whaterFromJson(payload);
    setState(() {
      this.whater = newWhater.whater;
      this.whaterSensor = newWhater.sensor;
      if(this.waterData.length <= 4){
        this.waterData.add(SensorSeries(
          time: "${TimeOfDay.now().minute}:${DateTime.now().second}",
          data: this.whater.toInt()
        ));
      }else{
        this.waterData.removeAt(0);
        this.waterData.add(SensorSeries(
          time: "${TimeOfDay.now().minute}:${DateTime.now().second}",
          data: this.whater.toInt()
        ));
      }
    });
  }

  @override
  Widget build (BuildContext context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:ListView(
          children: <Widget>[
            CustomCard(
              tittle: "Humedad1",
              subTittle: "Interior",
              text:(this.humiditySensor==null) 
                ?"Esperando..."
                :"id: ${this.humiditySensor} ",
              value: (this.humidity==null)
                ?"......"
                :"${this.humidity} %",
              sensorData: humidityData,
            ),
            CustomCard(
              tittle: "Temperatura",
              subTittle: "Interior",
              text:(this.temperatureSensor == null)
                ?"Esperando..."
                :"id: ${this.temperatureSensor}",
              value:(this.temperature == null) 
                ?"......"
                :"${this.temperature}º",
              firstColor: Colors.orange,
              secondColor: Colors.amber,
              sensorData: temperatureData,
            ),
            CustomCard(
              tittle: "Reservas",
              subTittle: "Comida",
              text:(this.foodSensor==null)
                ?"Esperando...."
                :"id: ${this.foodSensor}",
              value:(this.food == null)
                ?"......"
                :"${this.food}%",
              firstColor: Colors.blue,
              secondColor: Colors.cyan,
              sensorData: foodData,
            ),
            CustomCard(
              tittle: "Reservas",
              subTittle: "Agua",
              text:(this.whaterSensor==null)
                ?"Esperando..." 
                :"id: ${this.whaterSensor}",
              value:(this.whaterSensor==null)
                ?"......"
                :"${this.whater}%",
              firstColor: Colors.teal,
              secondColor: Colors.cyan,
              sensorData: waterData,
            ),
            
          ],
        )
      )
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

