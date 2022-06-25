import 'package:farmapp2/models/rol.dart';

class User {
    User({
        this.status,
        this.id,
        this.user,
        this.email,
        this.password,
        this.rol,
        this.createdAt,
        this.updatedAt,
    });

    bool status;
    String id;
    String user;
    String email;
    String password;
    Rol rol;
    DateTime createdAt;
    DateTime updatedAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        id: json["_id"],
        user: json["user"],
        email: json["email"],
        password: json["password"],
        rol: Rol.fromJson(json["rol"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "_id": id,
        "user": user,
        "email": email,
        "password": password,
        "rol": rol.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}