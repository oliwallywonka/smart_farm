import 'dart:convert';

import 'package:farmapp2/models/window.dart';

WindowResponse windowResponseFromJson(String str) => WindowResponse.fromJson(json.decode(str));

String windowResponseToJson(WindowResponse data) => json.encode(data.toJson());

class WindowResponse {
    WindowResponse({
        this.windows,
    });

    List<Window> windows;

    factory WindowResponse.fromJson(Map<String, dynamic> json) => WindowResponse(
        windows: List<Window>.from(json["windows"].map((x) => Window.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "windows": List<dynamic>.from(windows.map((x) => x.toJson())),
    };
}

