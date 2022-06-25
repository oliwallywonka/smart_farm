// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
    Response({
        this.token,
    });

    String token;

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
}
