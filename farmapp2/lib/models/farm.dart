// To parse this JSON data, do
//
//     final farm = farmFromJson(jsonString);

import 'dart:convert';

import 'package:farmapp2/models/user.dart';

Farm farmFromJson(String str) => Farm.fromJson(json.decode(str));

String farmToJson(Farm data) => json.encode(data.toJson());

class Farm {
    Farm({
        this.openDoors,
        this.closeDoors,
        this.capMax,
        this.tempMin,
        this.tempMax,
        this.humidityMin,
        this.humidityMax,
        this.status,
        this.id,
        this.user,
        this.name,
        this.createdAt,
        this.updatedAt,
    });

    DateTime openDoors;
    DateTime closeDoors;
    int capMax;
    int tempMin;
    int tempMax;
    int humidityMin;
    int humidityMax;
    bool status;
    String id;
    User user;
    String name;
    DateTime createdAt;
    DateTime updatedAt;

    factory Farm.fromJson(Map<String, dynamic> json) => Farm(
        openDoors: DateTime.parse(json["open_doors"]),
        closeDoors: DateTime.parse(json["close_doors"]),
        capMax: json["cap_max"],
        tempMin: json["temp_min"],
        tempMax: json["temp_max"],
        humidityMin: json["humidity_min"],
        humidityMax: json["humidity_max"],
        status: json["status"],
        id: json["_id"],
        user: User.fromJson(json["user"]),
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "open_doors": openDoors.toIso8601String(),
        "close_doors": closeDoors.toIso8601String(),
        "cap_max": capMax,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "humidity_min": humidityMin,
        "humidity_max": humidityMax,
        "status": status,
        "_id": id,
        "user": user.toJson(),
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

