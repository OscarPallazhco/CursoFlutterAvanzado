import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/services/auth_service.dart';

class ChatMessage extends StatelessWidget {
  final String message, uid;
  final AnimationController animationCtler;

  const ChatMessage(
    {
      Key key,
      @required this.message,
      @required this.uid,
      @required this.animationCtler,
    }
  )
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return FadeTransition(
      opacity: animationCtler,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(curve: Curves.easeOut, parent: animationCtler),
        child: Container(
          child: this.uid == authService.usuario.uid
              ? _displayMineMessage()
              : _displayOtherMessage(),
        ),
      ),
    );
  }

  Widget _displayOtherMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(9),
        margin: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 80),
        child: Text(
          this.message,
          style: TextStyle(color: Colors.black87),
        ),
        decoration: BoxDecoration(
          color: Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _displayMineMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(9),
        margin: EdgeInsets.only(top: 4, bottom: 4, left: 80, right: 4),
        child: Text(
          this.message,
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
          color: Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
