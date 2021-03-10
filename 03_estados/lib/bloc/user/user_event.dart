
part of 'user_bloc.dart';

@immutable
abstract class UserEvent {
  
}

class EstablishUser extends UserEvent{
  final User user;

  EstablishUser(this.user);

}