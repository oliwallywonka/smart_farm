import 'dart:convert';


import '../global/enviroment.dart';
import 'package:farmapp2/models/login_response.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier{

  Response response;
  bool _autenticate = false;

  final _storage = new FlutterSecureStorage();

  bool get autenticate => this._autenticate;
  set autenticate (bool valor){
    this._autenticate = valor;
    notifyListeners();
  }

  //Getters static token
  static Future<String> getToken()async{
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async{
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email,String password) async{

    this.autenticate = true;

    final data = {
      'email' : email,
      'password': password
    };

    final resp = await http.post(Uri.parse('${Enviroment.apiUrl}/api/auth/signin'),
      body:jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );
    this.autenticate = false;
    if(resp.statusCode == 200){
      final loginResponse = responseFromJson(resp.body);
      await this._saveToken(loginResponse.token);
      return true;
    }else {
      return false;
    }

  }

  Future<bool> isLoggedIn()async{
    final token = await this._storage.read(key: 'token');
    final resp = await http.get(Uri.parse('${Enviroment.apiUrl}/api/auth/renew'),
      headers:{
        'Content-Type': 'application/json',
        'x-access-token': token
      }
    );

    if(resp.statusCode == 200){
      final loginResponse = responseFromJson(resp.body);
      await this._saveToken(loginResponse.token);

      return true;
    }else{
      this.logout();
      return false; 
    }
  }

  Future _saveToken(String token) async{
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async{
    await _storage.delete(key: 'token');
  }

}