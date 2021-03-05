import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/global/environments.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/messages_response.dart';
import 'package:chat_app/services/auth_service.dart';

class ChatService with  ChangeNotifier{
  Usuario  userTo;

  Future<List<Message>> getChat() async {
    try {
      final resp = await http.get('${Environments.apiUrl}/messages/${userTo.uid}',
          headers: {
            'Content-type': 'application/json',
            'x-token': await AuthService.getToken()
          }
      );

      if (resp.statusCode == 200) {
        final messagesResponse = messagesResponseFromJson(resp.body);
        return messagesResponse.messages;
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