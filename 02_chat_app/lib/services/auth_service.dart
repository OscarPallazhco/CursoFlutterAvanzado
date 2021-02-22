import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:chat_app/global/environments.dart';

class AuthService with ChangeNotifier {
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

    print(resp);
    print(resp.body);
  }
}
