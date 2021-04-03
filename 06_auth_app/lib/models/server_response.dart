// To parse this JSON data, do
//
//     final serverResponse = serverResponseFromJson(jsonString);

import 'dart:convert';

ServerResponse serverResponseFromJson(String str) => ServerResponse.fromJson(json.decode(str));

String serverResponseToJson(ServerResponse data) => json.encode(data.toJson());

class ServerResponse {
    ServerResponse({
        this.ok,
        this.googleUser,
    });

    bool ok;
    GoogleUser googleUser;

    factory ServerResponse.fromJson(Map<String, dynamic> json) => ServerResponse(
        ok: json["ok"],
        googleUser: GoogleUser.fromJson(json["googleUser"]),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "googleUser": googleUser.toJson(),
    };
}

class GoogleUser {
    GoogleUser({
        this.name,
        this.picture,
        this.email,
    });

    String name;
    String picture;
    String email;

    factory GoogleUser.fromJson(Map<String, dynamic> json) => GoogleUser(
        name: json["name"],
        picture: json["picture"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "picture": picture,
        "email": email,
    };
}
