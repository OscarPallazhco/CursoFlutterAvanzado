import 'dart:io';

class Environments {
  static String apiUrl = Platform.isAndroid ? 'http://192.168.100.42:3000/api' : 'http://localhost/3000/api';
  static String socketUrl = Platform.isAndroid ? 'http://192.168.100.42:3000' : 'http://localhost/3000';
  // static String apiUrl =  'https://chatserver-02-2021.herokuapp.com/api';
  // static String socketUrl =  'https://chatserver-02-2021.herokuapp.com/';
}
