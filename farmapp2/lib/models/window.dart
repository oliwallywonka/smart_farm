class Window {
    Window({
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

    factory Window.fromJson(Map<String, dynamic> json) => Window(
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