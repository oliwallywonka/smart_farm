// To parse this JSON data, do
//
//     final food = foodFromJson(jsonString);

import 'dart:convert';

Food foodFromJson(String str) => Food.fromJson(json.decode(str));

String foodToJson(Food data) => json.encode(data.toJson());

class Food {
    Food({
        this.sensor,
        this.food,
    });

    String sensor;
    double food;

    factory Food.fromJson(Map<String, dynamic> json) => Food(
        sensor: json["sensor"],
        food: json["food"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "sensor": sensor,
        "food": food,
    };
}