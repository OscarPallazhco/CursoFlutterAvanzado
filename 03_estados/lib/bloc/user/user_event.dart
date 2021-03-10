
part of 'user_bloc.dart';

@immutable
abstract class UserEvent {
  
}

class EstablishUser extends UserEvent{
  final User user;
  EstablishUser(this.user);
}

class ChangeAge extends UserEvent{
  final int age;
  ChangeAge(this.age);
}