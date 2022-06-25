
class Rol {
    Rol({
        this.status,
        this.id,
        this.rol,
    });

    bool status;
    String id;
    String rol;

    factory Rol.fromJson(Map<String, dynamic> json) => Rol(
        status: json["status"],
        id: json["_id"],
        rol: json["rol"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "_id": id,
        "rol": rol,
    };
}