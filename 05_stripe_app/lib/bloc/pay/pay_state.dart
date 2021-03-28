part of 'pay_bloc.dart';

@immutable
class PayState {
  final double amount;
  final String currency;
  final bool creditCardIsSelected;
  final CustomCreditCard creditCard;

  PayState({    
    this.amount = 0.0,
    this.currency = 'USD',
    this.creditCardIsSelected = false,
    this.creditCard
  });
  
  PayState copyWith({
    double amount,
    String currency,
    bool creditCardIsSelected,
    CustomCreditCard creditCard
  }) => PayState(
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    creditCardIsSelected: creditCardIsSelected ?? this.creditCardIsSelected,
    creditCard: creditCard ?? this.creditCard,
  );
}
