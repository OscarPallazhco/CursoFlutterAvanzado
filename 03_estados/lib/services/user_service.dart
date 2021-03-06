import 'dart:async';

import 'package:estados/models/user.dart';

class _UserService {
  User _user;
  StreamController<User> _userStreamCtrller = new StreamController<User>();
  /*al poner <User> se le indica que lo que va a fluir por el stream serán Users*/ 
  
  Stream<User> get userStream => _userStreamCtrller.stream;   //con userStream pueden obtener el User que está fluyendo por el stream

  User get getUser => this._user;

  void setUser(User user){
    this._user = user;
    this._userStreamCtrller.add(this._user);  //después de actualizar el user lo hace fluir por el stream
  }

  bool get existUser => this._user!=null;

  void changeAge(int age){
    if (this._user!= null) {
      this._user.age = age;
      this._userStreamCtrller.add(this._user); //después de actualizar el user lo hace fluir por el stream
    }
  }

  void addProfession(String profession){
    if (this._user!= null) {
      this._user.professions.add(profession);
      this._userStreamCtrller.add(this._user); //después de actualizar el user lo hace fluir por el stream
    }
  }
}

final userService = new _UserService();