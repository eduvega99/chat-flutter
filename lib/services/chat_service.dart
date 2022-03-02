import 'package:chat/models/messages_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:chat/global/environment.dart';
import 'package:chat/models/models.dart';


class ChatService with ChangeNotifier {
  
  late User _fromUser;
  late int page;
  
  User get fromUser => _fromUser;

  set fromUser(User value) {
    _fromUser = value;
    page = 0;
  }

  Future<List<Message>> getChat(String uid) async {

    final uri = Uri.http( Environment.apiUrl, '/api/messages/$uid', {'page': page.toString()} );
    final headers = { 
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken() ?? ''
    };

    final response = await http.get(uri, headers: headers);
    final messageResponse =  messagesResponseFromJson(response.body);

    return messageResponse.messages;
  }


}