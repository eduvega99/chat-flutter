import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import 'package:chat/models/models.dart';
import 'package:chat/global/environment.dart';


class AuthService with ChangeNotifier {

  User? user;
  bool _isLoading = false;
  final _storage = const FlutterSecureStorage();

  bool get isLoading => _isLoading;

  static Future<String?> getToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token'); 
    return token;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  } 
  
  Future<bool> login(String email, String password) async {
    isLoading = true;
    
    final data = {
      'email'   : email,
      'password': password
    };

    final response = await _doPostRequest(data, '/api/login');

    isLoading = false;

    if ( response.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson( response.body );
      user = loginResponse.user;
      await _saveToken( loginResponse.token );
      return true;
    }
    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    isLoading = true;
    
    final data = {
      'name'    : name,
      'email'   : email,
      'password': password
    };

    final response = await _doPostRequest(data, '/api/login/new');

    isLoading = false;

    if ( response.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson( response.body );
      user = loginResponse.user;
      await _saveToken( loginResponse.token );
      return true;
    }
    return false;
  }

  Future<http.Response> _doPostRequest(Map<String, dynamic> data, String endpoint) async {
    final uri = Uri.http(Environment.apiUrl, endpoint);
    final response = await http.post(uri, body: jsonEncode(data), headers: { 'Content-Type': 'application/json' });
    return response;
  }

  Future<void> _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future<void> logout() async {
    await _storage.delete(key: 'token');
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    print(token);
    if ( token == null ) return false;

    final header = { 'x-token' : token };
    final response = await _doGetRequest(header, '/api/login/renew');

    print(response.statusCode);

    if ( response.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson( response.body );
      user = loginResponse.user;
      await _saveToken( loginResponse.token );
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future<http.Response> _doGetRequest(Map<String, String> data, String endpoint) async {
    final uri = Uri.http(Environment.apiUrl, endpoint);
    final headers = { 'Content-Type': 'application/json' };
    headers.addAll(data);
    final response = await http.get(uri, headers: headers);
    return response;
  }
  


}