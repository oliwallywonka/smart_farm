// To parse this JSON data, do
//
//     final temperature = temperatureFromJson(jsonString);

import 'dart:convert';

Temperature temperatureFromJson(String str) => Temperature.fromJson(json.decode(str));

String temperatureToJson(Temperature data) => json.encode(data.toJson());

class Temperature {
    Temperature({
        this.sensor,
        this.temperature,
    });

    String sensor;
    double temperature;

    factory Temperature.fromJson(Map<String, dynamic> json) => Temperature(
        sensor: json["sensor"],
        temperature: json["temperature"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "sensor": sensor,
        "temperature": temperature,
    };
}
