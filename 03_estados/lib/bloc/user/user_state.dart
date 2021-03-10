
part of 'user_bloc.dart';
  
class UserState {

  final bool existUser;
  final User user;
  final String anotherPropertie;

  // constructor
  UserState({User user, String anotherPropertie}):
    user = user ?? null,
    existUser = (user != null),
    anotherPropertie = anotherPropertie ?? 'example of another possible propertie'
  ;

  // copywith para en caso de tener otras propiedades, estas no se pierdan al crear un nuevo estado
  UserState copyWith({User user, String anotherPropertie}){
    return UserState(
      user: user ?? this.user,
      anotherPropertie: anotherPropertie ?? this.anotherPropertie,
    );
  }

  UserState initialState() => new UserState();
  
}