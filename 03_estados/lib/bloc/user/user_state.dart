
part of 'user_cubit.dart';

@immutable
abstract class UserState {
  //Las clases que extiendan de este estado son los unicos que podrá manejar el UserCubit
}

class InitialUserState extends UserState {
  //Esta es una clase que extiende de UserState, por lo tanto el UserCubit lo puede recibir,
  //además se usará para pasarle como el estado inicial que requieren los cubits
  final existUser = false;
}

class ActiveUserState extends UserState {
  //estado que será pasado al cubit cuando en la ui se seleccione establecer usuario
  final existUser = true;
  final User activeUser;

  ActiveUserState(this.activeUser);
  
}
