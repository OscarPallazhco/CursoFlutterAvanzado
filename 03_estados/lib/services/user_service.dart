import 'dart:async';

import 'package:estados/models/user.dart';

class _UserService {
  User _user;
  // StreamController<User> _userStreamCtrller = new StreamController<User>();
  StreamController<User> _userStreamCtrller = new StreamController<User>.broadcast();
  //al poner <User> se le indica que lo que va a fluir por el stream serán Users
  //por defecto el streamcontroller solo se crea para un suscriptor, solo uno streambuilder podrá usar el stream
  //con el .broadcast() ya se permite tener más de un streambuilder atendiendo el stream
  
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

  void dispose(){   //Close instances of `dart.core.Sink`
    _userStreamCtrller?.close();
  }

}


final userService = new _UserService();