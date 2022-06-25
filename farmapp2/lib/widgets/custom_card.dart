import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class CustomCard extends StatelessWidget {
  final Color firstColor;
  final Color secondColor;
  final String value;
  final String tittle;
  final String subTittle;
  final String text;

  final List<SensorSeries> sensorData;

  const CustomCard(
      {Key key,
      this.firstColor,
      this.secondColor,
      @required this.value,
      @required this.tittle,
      @required this.subTittle,
      @required this.text,
      this.sensorData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(children: <Widget>[
          Container(
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(colors: [
                  (firstColor == null) ? Colors.pink : firstColor,
                  (secondColor == null) ? Colors.red : secondColor
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                      color: (secondColor == null) ? Colors.red : secondColor,
                      blurRadius: 12,
                      offset: Offset(0, 6)),
                ]),
          ),
          Positioned.fill(
              child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    (value == "null") ? "....." : value,
                    style: TextStyle(fontSize: 51, color: Colors.white),
                  ),
                )),
                Expanded(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Text(
                        tittle,
                        style: TextStyle(color: Colors.white, fontSize: 26),
                      ),
                      Text(
                        subTittle,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      Text(
                        (text == "null") ? "Esperando..." : text,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ]))
              ],
            ),
            Container(
              height: 200,
              padding: EdgeInsets.all(10),
              child: TimeSensorChart(
                sensorSeries: this.sensorData,
              ),
            )
          ]))
        ]),
      ),
    );
  }
}

class TimeSensorChart extends StatelessWidget {
  final List<SensorSeries> sensorSeries;
  final List<Color> availableColors = const [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  const TimeSensorChart({Key key, this.sensorSeries}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
            LineSeries<SensorSeries, String>(
              dataSource: this.sensorSeries, 
              xValueMapper: (SensorSeries series, _) => series.time, 
              yValueMapper: (SensorSeries series, _) => series.data
          )
        ],
      ),
    );
  }
}

class SensorSeries {
  final String time;
  final int data;

  SensorSeries({@required this.time, @required this.data});
}
