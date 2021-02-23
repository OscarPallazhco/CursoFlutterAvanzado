import 'package:chat_app/models/login_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:chat_app/global/environments.dart';
import 'package:chat_app/models/usuario.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _authenticating = false;

  bool get authenticating => this._authenticating;

  set authenticating(bool value) {
    this._authenticating = value;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    this.authenticating = true;

    final data = {
      'email': email,
      'password': password,
    };

    try {
      final resp = await http.post('${Environments.apiUrl}/auth/login',
          body: jsonEncode(data),
          headers: {'Content-type': 'application/json'});

      print('resp.body');
      print(resp.body);

      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        this.usuario = loginResponse.usuario;
        print('usuario');
        print(this.usuario.toJson());
      }else{
        print('Credenciales incorrectas');
        this.authenticating = false;
        return false;
      }

    } catch (e) {
      print(e);
      this.authenticating = false;
      return false;
    }
    this.authenticating = false;
    return true;
  }
}
