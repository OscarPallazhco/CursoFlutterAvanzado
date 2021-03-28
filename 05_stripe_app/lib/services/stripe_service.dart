import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:stripe_payment/stripe_payment.dart';

// models
import 'package:stripe_app/models/payment_intent_response.dart';
import 'package:stripe_app/models/stripe_custom_response.dart';

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

  Future<StripeCustomResponse> payWithExistentCard({
    @required String amount,
    @required String currency,
    @required CreditCard creditCard,
  }) async{
    try {
      
      // paymentMethod
      final paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(
          card: creditCard
        )
      );

      // hacer el pago
      final stripeCustomResponse = await this._makeThePayment(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod
      );

      // respuesta de si el pago fue exitoso o no
      return stripeCustomResponse;

    } catch (e) {
      print('Error en pagar con tarjeta existente: ${e.toString()}');
      return StripeCustomResponse(
        ok: false,
        msg: e.toString()
      );
    }
  }
  
  Future<StripeCustomResponse> payWithNewCard({
    @required String amount,
    @required String currency,
  }) async{
    try {
      // paymentMethod
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest()
      );
      
      // hacer el pago
      final stripeCustomResponse = await this._makeThePayment(
        amount: amount,
        currency: currency,
              paymentMethod: paymentMethod
      );

      // respuesta de si el pago fue exitoso o no
      return stripeCustomResponse;

    } catch (e) {
      print('Error en pagar con tarjeta nueva: ${e.toString()}');
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
    try {

      // androidPayOptions
      final AndroidPayPaymentRequest androidPayOptions = AndroidPayPaymentRequest(
        currencyCode: currency,
        totalPrice: amount
      );

      // newAmount for apple
      final newAmount = double.parse(amount) / 100;

      // applePayOptions
      final ApplePayPaymentOptions applePayOptions = ApplePayPaymentOptions(
        currencyCode: currency,
        countryCode: 'US',
        items: [
          ApplePayItem(
            label: 'Mi producto',
            amount: '$newAmount',            
          )
        ]
      );

      // token
      final token = await StripePayment.paymentRequestWithNativePay(
        androidPayOptions: androidPayOptions,
        applePayOptions: applePayOptions
      );
      
      // paymentMethod
      
      // final paymentMethod = await StripePayment.createPaymentMethod(
      //   PaymentMethodRequest(
      //     token: token
      //   )
      // );

      final paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(
          card: CreditCard(
            token: token.tokenId,
          )
        )
      );

      // hacer el pago
      final stripeCustomResponse = await this._makeThePayment(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod
      );

      // respuesta de si el pago fue exitoso o no
      return stripeCustomResponse;

    } catch (e) {
      print('Error en pagar con tarjeta existente: ${e.toString()}');
      return StripeCustomResponse(
        ok: false,
        msg: e.toString()
      );
    }
  }

  Future<PaymentIntentResponse> _createPaymentIntent({
    @required String amount,
    @required String currency,
  }) async{
    try {
      final dio = new Dio();

      final data = {
        'amount' : amount,
        'currency' : currency,
      };

      final headerOptions = new Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          'Authorization': 'Bearer $_secretKey'
        }
      );

      final resp = await dio.post(
        _paymentApiUrl,
        data: data,
        options: headerOptions,
      );

      //status diferentes de 200 caen en el catch
      return PaymentIntentResponse.fromJson(resp.data);

    } catch (e) {
      print('Error en crear el intento de pago: ${e.toString()}');
      return PaymentIntentResponse(
        status: '400',
      );
    }
  }

  Future<StripeCustomResponse> _makeThePayment({
    @required String amount,
    @required String currency,
    @required PaymentMethod paymentMethod,
  }) async{
    try {
      // intento
      final paymentIntentResponse = await this._createPaymentIntent(amount: amount, currency: currency);

      // confirmar el intento
      final paymentIntentResult = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntentResponse.clientSecret,
          paymentMethodId: paymentMethod.id
        )
      );

      if (paymentIntentResult.status == 'succeeded') {
        return StripeCustomResponse(ok: true);
      } else {
        print('Error en confirmar el intento de pago: ${paymentIntentResult.status}');
        return StripeCustomResponse(
          ok: false,
          msg: 'Error en confirmar el intento de pago: ${paymentIntentResult.status}'
        );
      }

    } catch (e) {
      print('Error en hacer el pago: ${e.toString()}');
      return StripeCustomResponse(
        ok: false,
        msg: e.toString(),        
      );
    }
  }


}