// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        this.isOnline,
        this.name,
        this.email,
        this.uid,
    });

    bool isOnline;
    String name;
    String email;
    String uid;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        isOnline: json["isOnline"],
        name: json["name"],
        email: json["email"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "isOnline": isOnline,
        "name": name,
        "email": email,
        "uid": uid,
    };
}
