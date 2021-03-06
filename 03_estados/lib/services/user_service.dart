import 'package:estados/models/user.dart';

class _UserService {
  User _user;

  User get getUser => this._user;

  void setUser(User user){
    this._user = user;
  }

  bool get existUser => this._user!=null;

  void changeAge(int age){
    if (this._user!= null) {
      this._user.age = age;
    }
  }

  void addProfession(String profession){
    if (this._user!= null) {
      this._user.professions.add(profession);
    }
  }
}

final userService = new _UserService();