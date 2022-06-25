import 'dart:convert';

Belt beltFromJson(String str) => Belt.fromJson(json.decode(str));

String beltToJson(Belt data) => json.encode(data.toJson());

class Belt {
    Belt({
        this.status,
        this.id,
        this.farm,
        this.createdAt,
        this.updatedAt,
    });

    bool status;
    String id;
    String farm;
    DateTime createdAt;
    DateTime updatedAt;

    factory Belt.fromJson(Map<String, dynamic> json) => Belt(
        status: json["status"],
        id: json["_id"],
        farm: json["farm"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "_id": id,
        "farm": farm,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
