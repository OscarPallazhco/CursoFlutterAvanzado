// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat_app/models/usuario.dart';

UsersResponse usersResponseFromJson(String str) => UsersResponse.fromJson(json.decode(str));

String usersResponseToJson(UsersResponse data) => json.encode(data.toJson());

class UsersResponse {
    UsersResponse({
        this.ok,
        this.count,
        this.users,
    });

    bool ok;
    int count;
    List<Usuario> users;

    factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        ok: json["ok"],
        count: json["count"],
        users: List<Usuario>.from(json["users"].map((x) => Usuario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "count": count,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
    };
}



