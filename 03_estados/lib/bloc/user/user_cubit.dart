import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  //Un cubit se le debe pasar siempre un estado inicial
  //los estados que maneja el cubit deben ser inmutables y extender de UserState
  // UserCubit(UserState state) : super(state);
  UserCubit() : super(InitialUserState());    //constructor con el estado inicial
    
}