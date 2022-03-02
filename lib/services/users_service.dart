import 'package:chat/global/environment.dart';
import 'package:chat/services/auth_service.dart';

import 'package:http/http.dart' as http;

import '../models/models.dart';

class UsersService {
  
  Future<List<User>> getUsers() async {
    try {

      final uri = Uri.http(Environment.apiUrl, '/api/users');
      final headers = { 
        'Content-Type': 'application/json', 
        'x-token' : await AuthService.getToken() ?? '' 
      };
      final response = await http.get(uri, headers: headers);
      
      final users = usersResponseFromJson(response.body).users;
      return users;
    
    } catch (e) {
      return [];
    }
  }

}