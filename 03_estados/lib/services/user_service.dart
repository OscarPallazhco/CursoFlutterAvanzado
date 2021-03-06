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
  void changeAge(int age){
    if (this._user!= null) {
      this._user.age = age;
      notifyListeners();
    }
  }

  void addProfession(String profession){
    if (this._user!= null) {
      this._user.professions.add(profession);
      notifyListeners();
    }
  }

  void deleteUser(){
    this._user = null;
    notifyListeners();
  }
  
}