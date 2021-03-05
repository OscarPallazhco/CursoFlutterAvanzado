import 'package:http/http.dart' as http;

import 'package:chat_app/global/environments.dart';

import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/models/users_response.dart';

import 'package:chat_app/services/auth_service.dart';

class UsersService {
  Future<List<Usuario>> getUsers() async {
    try {
      final resp = await http.get('${Environments.apiUrl}/users',
          headers: {
            'Content-type': 'application/json',
            'x-token': await AuthService.getToken()
          }
      );

      // print('resp.body');
      // print(resp.body);

      if (resp.statusCode == 200) {
        final usersResponse = usersResponseFromJson(resp.body);
        return usersResponse.users;
      } else {
        print('respuesta faliida del servidor: ${resp.statusCode}');
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
