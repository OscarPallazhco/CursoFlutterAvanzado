import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estados/models/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  //Un cubit se le debe pasar siempre un estado inicial
  //los estados que maneja el cubit deben ser inmutables y extender de UserState
  // UserCubit(UserState state) : super(state);
  UserCubit() : super(InitialUserState());    //constructor con el estado inicial

  void establishUser(User user){
    emit(ActiveUserState(user));
    //emit actualiza el estado del cubit, y todos los listeners se actualizarán
    //ahora no tendrá un InitialUserState sino un ActiveUserState
  }

  void changeAge(int age){
    //se puede usar el state para cambiar el estado, pero no es buena practica mutar
    //el estado, siempre se debe trabajar con nuevos estados
    final currentState = state;
    if (currentState is ActiveUserState) {
      User newUser = currentState.activeUser.copyWith(age: 26);
      //copia del usuario actual, pero con otra edad
      emit(ActiveUserState(newUser)); //cambiar el estado y notificar a los listeners
    }
  }
    
}