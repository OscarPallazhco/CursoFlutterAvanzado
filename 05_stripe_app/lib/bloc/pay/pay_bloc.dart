import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

// models
import 'package:stripe_app/models/custom_credit_card.dart';

part 'pay_event.dart';
part 'pay_state.dart';

class PayBloc extends Bloc<PayEvent, PayState> {
  PayBloc() : super(PayState());

  @override
  Stream<PayState> mapEventToState(PayEvent event,) async* {
    if (event is OnCreditCardIsSelected) {
      yield state.copyWith(creditCardIsSelected: true, creditCard: event.creditCard);
    } else if(event is OnCreditCardIsDeselected){
      yield state.copyWith(creditCardIsSelected: false);
    }
    
  }
}
