import 'package:chat_app/models/login_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:chat_app/global/environments.dart';
import 'package:chat_app/models/usuario.dart';

class AuthService with ChangeNotifier {

  Usuario usuario;

  Future login(String email, String password) async {
    final data = {
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      '${Environments.apiUrl}/auth/login',
      body: jsonEncode(data),
      headers: {'Content-type': 'application/json'}
    );

    print('resp.body');
    print(resp.body);

    if (resp.statusCode==200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
    }

    print('usuario');
    print(this.usuario.toJson());
  }
}
