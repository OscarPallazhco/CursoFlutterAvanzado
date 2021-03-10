
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:estados/models/user.dart';

part 'user_state.dart';
part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  
  UserBloc() : super(UserState());
  // El bloc tmbn necesita un estado inicial, por eso se le envía una instancia 
  // de UserState

  @override
  Stream<UserState> mapEventToState(UserEvent event) async*{
    // esta funcion siempre debe emitir algo del tipo UserState
    // el yield solo se puede usar dentro de una funcion generadora, x lo tanto se debe
    // usar async o async*, async es para futures, async* es para streams
    if (event is EstablishUser) {
      yield UserState(user: event.user);
    }else if (event is ChangeAge) {
      yield UserState(user: state.user.copyWith(age: event.age));
    }else if (event is AddProfession) {
      // List<String> newProfessions = List.from(state.user.professions)..add(event.profession);
      //otra manera:
      List<String> newProfessions = [...state.user.professions, event.profession];
      yield UserState(user: state.user.copyWith(professions: newProfessions));
    }
  }
  
}