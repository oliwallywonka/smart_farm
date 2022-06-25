// To parse this JSON data, do
//
//     final windowStatus = windowStatusFromJson(jsonString);

import 'dart:convert';

WindowStatus windowStatusFromJson(String str) => WindowStatus.fromJson(json.decode(str));

String windowStatusToJson(WindowStatus data) => json.encode(data.toJson());

class WindowStatus {
    WindowStatus({
        this.window,
        this.status,
    });

    String window;
    bool status;

    factory WindowStatus.fromJson(Map<String, dynamic> json) => WindowStatus(
        window: json["window"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "window": window,
        "status": status,
    };
}
