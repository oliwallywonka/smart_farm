import 'dart:io';

class Enviroment {
  static String apiUrl = Platform.isAndroid ? 'http://10.0.2.2:8000' : 'http://localhost:8000';
  static String socketUrl = Platform.isAndroid ? 'http://10.0.2.2:8000': 'http://localhost:8000';
  //static String apiUrl = 'https://gentle-tor-35472.herokuapp.com';
  //static String socketUrl = 'https://gentle-tor-35472.herokuapp.com';
}