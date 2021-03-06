import 'package:estados/models/user.dart';
import 'package:flutter/material.dart';

class UserService with ChangeNotifier{
  User _user;

  User get user => this._user;
  bool get existUser => this._user!=null;
  
}