// To parse this JSON data, do
//
//     final humidity = humidityFromJson(jsonString);

import 'dart:convert';

Humidity humidityFromJson(String str) => Humidity.fromJson(json.decode(str));

String humidityToJson(Humidity data) => json.encode(data.toJson());

class Humidity {
    Humidity({
        this.sensor,
        this.humidity,
    });

    String sensor;
    double humidity;

    factory Humidity.fromJson(Map<String, dynamic> json) => Humidity(
        sensor: json["sensor"],
        humidity: json["humidity"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "sensor": sensor,
        "humidity": humidity,
    };
}