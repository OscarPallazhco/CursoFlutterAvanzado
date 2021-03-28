import 'package:meta/meta.dart';
import 'package:stripe_app/models/stripe_custom_response.dart';
import 'package:stripe_payment/stripe_payment.dart';

import 'package:stripe_app/global/environments.dart';

class StripeService {

  // singleton
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance;

  String _paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';
  String _secretKey = Environments.secretKey;
  String _publishableKey = Environments.publishableKey;
  
  void init(){
    final stripeOptions = StripeOptions(
      publishableKey: this._publishableKey,
      androidPayMode: 'test',
      merchantId: 'test',
    );
    StripePayment.setOptions(stripeOptions);
  }

  Future payWithExistentCard({
    @required String amount,
    @required String currency,
    @required CreditCard creditCard,
  }) async{
  
  }
  
  Future<StripeCustomResponse> payWithNewCard({
    @required String amount,
    @required String currency,
  }) async{
    try {

      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest()
      );

      //ningún inconveniente
      return StripeCustomResponse(ok: true);

    } catch (e) {
      return StripeCustomResponse(
        ok: false,
        msg: e.toString()
      );
    }
  }

  Future payWithNativePay({
    @required String amount,
    @required String currency,
  }) async{

  }

  Future _createPaymentIntent({
    @required String amount,
    @required String currency,
  }) async{

  }

  Future _makeThePayment({
    @required String amount,
    @required String currency,
    @required PaymentMethod paymentMethod,
  }) async{

  }


}