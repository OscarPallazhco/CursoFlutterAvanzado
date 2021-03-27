part of 'pay_bloc.dart';

@immutable
class PayState {
  final double amount;
  final String coin;
  final bool creditCardIsSelected;
  final CustomCreditCard creditCard;

  PayState({    
    this.amount = 0.0,
    this.coin = 'USD',
    this.creditCardIsSelected = false,
    this.creditCard
  });
  
  PayState copyWith({
    double amount,
    String coin,
    bool creditCardIsSelected,
    CustomCreditCard creditCard
  }) => PayState(
    amount: amount ?? this.amount,
    coin: coin ?? this.coin,
    creditCardIsSelected: creditCardIsSelected ?? this.creditCardIsSelected,
    creditCard: creditCard ?? this.creditCard,
  );
}
