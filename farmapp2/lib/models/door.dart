// To parse this JSON data, do
//
//     final door = doorFromJson(jsonString);

import 'dart:convert';

Door doorFromJson(String str) => Door.fromJson(json.decode(str));

String doorToJson(Door data) => json.encode(data.toJson());

class Door {
    Door({
        this.status,
        this.open,
        this.close,
        this.id,
        this.farm,
        this.createdAt,
        this.updatedAt,
    });

    bool status;
    DateTime open;
    DateTime close;
    String id;
    String farm;
    DateTime createdAt;
    DateTime updatedAt;

    factory Door.fromJson(Map<String, dynamic> json) => Door(
        status: json["status"],
        open: DateTime.parse(json["open"]),
        close: DateTime.parse(json["close"]),
        id: json["_id"],
        farm: json["farm"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "open": open.toIso8601String(),
        "close": close.toIso8601String(),
        "_id": id,
        "farm": farm,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
