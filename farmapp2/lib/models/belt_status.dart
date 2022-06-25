// To parse this JSON data, do
//
//     final beltStatus = beltStatusFromJson(jsonString);

import 'dart:convert';

BeltStatus beltStatusFromJson(String str) => BeltStatus.fromJson(json.decode(str));

String beltStatusToJson(BeltStatus data) => json.encode(data.toJson());

class BeltStatus {
    BeltStatus({
        this.belt,
        this.status,
    });

    String belt;
    bool status;

    factory BeltStatus.fromJson(Map<String, dynamic> json) => BeltStatus(
        belt: json["belt"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "belt": belt,
        "status": status,
    };
}
