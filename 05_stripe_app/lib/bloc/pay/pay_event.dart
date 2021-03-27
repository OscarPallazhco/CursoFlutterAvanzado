part of 'pay_bloc.dart';

@immutable
abstract class PayEvent {}

class OnCreditCardIsSelected extends PayEvent{
  final CustomCreditCard creditCard;
  OnCreditCardIsSelected(this.creditCard);
}

class OnCreditCardIsDeselected extends PayEvent{}