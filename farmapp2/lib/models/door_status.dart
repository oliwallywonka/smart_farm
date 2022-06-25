import 'dart:convert';

DoorStatus doorStatusFromJson(String str) => DoorStatus.fromJson(json.decode(str));

String doorStatusToJson(DoorStatus data) => json.encode(data.toJson());

class DoorStatus {
    DoorStatus({
        this.door,
        this.status,
    });

    String door;
    bool status;

    factory DoorStatus.fromJson(Map<String, dynamic> json) => DoorStatus(
        door: json["door"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "door": door,
        "status": status,
    };
}