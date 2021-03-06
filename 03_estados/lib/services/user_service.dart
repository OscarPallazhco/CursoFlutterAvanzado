import 'package:flutter/material.dart';

import 'package:estados/models/user.dart';

class UserService with ChangeNotifier{
  User _user;

  User get getUser => this._user;
  bool get existUser => this._user!=null;
  set setUser(User user){
    this._user = user;
    notifyListeners();
  }
  
}