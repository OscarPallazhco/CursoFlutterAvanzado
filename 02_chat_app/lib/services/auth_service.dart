import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/usuario.dart';

import 'package:chat_app/global/environments.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _authenticating = false;
  final _storage = new FlutterSecureStorage(); // Create storage

  bool get authenticating => this._authenticating;

  set authenticating(bool value) {
    this._authenticating = value;
    notifyListeners();
  }

  static Future<String> getToken() async {
    //obtener el token desde cualquie lugar de la aplicación
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    //eliminar el token desde cualquie lugar de la aplicación
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
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
        await this._saveToken(loginResponse.token);
      } else {
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

  Future register(String name, String email, String password) async {
    this.authenticating = true;

    final data = {
      'name': name,
      'email': email,
      'password': password,
    };

    try {
      final resp = await http.post('${Environments.apiUrl}/auth/new',
          body: jsonEncode(data),
          headers: {'Content-type': 'application/json'});

      print('resp.body');
      print(resp.body);

      if (resp.statusCode == 200) {
        final loginResponse = loginResponseFromJson(resp.body);
        this.usuario = loginResponse.usuario;
        await this._saveToken(loginResponse.token);
      } else {
        print('Registro incorrecto');
        final failResp = jsonDecode(resp.body); //si no es status 200, la respuesta no puede ser mapeada a LoginResponse
        this.authenticating = false;
        return failResp['msg']; //future no necesariamente tiene que retornarnar en todos los casos un bool
      }
    } catch (e) {
      print(e);
      this.authenticating = false;
      return false;
    }
    this.authenticating = false;
    return true;
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token); // Write value
  }

  Future _deleteToken(String token) async {
    return await _storage.delete(key: 'token');
  }
}
