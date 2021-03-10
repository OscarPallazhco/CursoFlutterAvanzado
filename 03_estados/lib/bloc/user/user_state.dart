
part of 'user_bloc.dart';
  
class UserState {

  final existUser;
  final User user;

  //constructor
  UserState({User user})
    :user = user ?? null,
    existUser = (user != null);
  
}