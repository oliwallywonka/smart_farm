// To parse this JSON data, do
//
//     final whater = whaterFromJson(jsonString);

import 'dart:convert';

Whater whaterFromJson(String str) => Whater.fromJson(json.decode(str));

String whaterToJson(Whater data) => json.encode(data.toJson());

class Whater {
    Whater({
        this.sensor,
        this.whater,
    });

    String sensor;
    double whater;

    factory Whater.fromJson(Map<String, dynamic> json) => Whater(
        sensor: json["sensor"],
        whater: json["whater"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "sensor": sensor,
        "whater": whater,
    };
}
