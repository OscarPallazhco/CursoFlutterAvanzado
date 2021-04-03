import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

import 'package:auth_app/models/server_response.dart';


class GoogleSignInService {

  static GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email'
    ],

  );


  static Future<GoogleUser> signInWithGoogle() async {
    
    try {

      final GoogleSignInAccount account = await _googleSignIn.signIn();
      final googleKey = await account.authentication;

      // print(account);
      // print('======  == ID TOKEN ========= ');
      // print( googleKey.idToken );
      
      final backEndUri = Uri(
        scheme: 'https',
        host: 'flutterauthappserver.herokuapp.com',
        path: '/google',
      );

      final resp = await http.post(
        backEndUri,
        body: {
          'token': googleKey.idToken
        }
      );
      if (resp.statusCode!=200) {
        return null;
      }

      ServerResponse serverResponse = serverResponseFromJson(resp.body);
      if (!serverResponse.ok) {
        return null;
      }

      return serverResponse.googleUser;

      
    } catch (e) {
      print('Error en google Signin');
      print(e);
      return null;
    }

  }

  static Future signOut() async {
    await _googleSignIn.signOut();
  }

}