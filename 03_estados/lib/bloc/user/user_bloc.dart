
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
  Stream<UserState> mapEventToState(UserEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
  
}