// To parse this JSON data, do
//
//     final doorResponse = doorResponseFromJson(jsonString);

import 'dart:convert';

import 'package:farmapp2/models/door.dart';

DoorResponse doorResponseFromJson(String str) => DoorResponse.fromJson(json.decode(str));

String doorResponseToJson(DoorResponse data) => json.encode(data.toJson());

class DoorResponse {
    DoorResponse({
        this.doors,
    });

    List<Door> doors;

    factory DoorResponse.fromJson(Map<String, dynamic> json) => DoorResponse(
        doors: List<Door>.from(json["doors"].map((x) => Door.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "doors": List<dynamic>.from(doors.map((x) => x.toJson())),
    };
}
