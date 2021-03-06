import 'package:estados/models/user.dart';

class _UserService {
  User _user;

  User get getUser => this._user;

  void setUser(User user){
    this._user = user;
  }

  bool get existUser => this._user!=null;
}

final userService = new _UserService();