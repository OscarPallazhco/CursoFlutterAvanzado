import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  TextEditingController _chatBoxCtrler = new TextEditingController();
  FocusNode _focusNode = new FocusNode();
  bool _isWriting = false;
  List<ChatMessage> _messages = [];

  @override
  void dispose() {
    for (ChatMessage message in this._messages) {
      message.animationCtler.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Container(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
              )),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Icon(
                Icons.account_circle,
                size: 35,
                color: Colors.blue[200],
              ),
              backgroundColor: Colors.white,
            ),
            Text(
              "Karla Paredes",
              style: TextStyle(color: Colors.black87, fontSize: 20),
            )
          ],
        ),
        elevation: 4,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: this._messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return this._messages[index];
                },
                reverse: true,
              ),
            ),
            Divider(),
            Container(
              color: Colors.white,
              height: 50,
              width: double.infinity,
              child: _inputChatBox(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChatBox() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Flexible(
              child: Container(
            margin: EdgeInsetsDirectional.only(start: 2),
            child: TextField(
              controller: _chatBoxCtrler,
              onSubmitted:
                  _handleSubmit,
              onChanged: (String texto) {
                setState(() {
                  this._isWriting = this._chatBoxCtrler.text.trim().length > 0;
                });
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Enviar mensaje...',
              ),
              focusNode: _focusNode,
            ),
          )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: Platform.isAndroid
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                        icon: Icon(
                          Icons.send,
                        ),
                        onPressed: _isWriting
                            ? () => _handleSubmit(this._chatBoxCtrler.text)
                            : null,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                      ),
                    ))
                : CupertinoButton(
                    child: Text('Enviar'),
                    onPressed: _isWriting
                        ? () => _handleSubmit(this._chatBoxCtrler.text)
                        : null,
                  ),
          )
        ],
      ),
    ));
  }

  void _handleSubmit(String texto) {
    if (texto.length == 0) return;  //no enviar mensajes vacios con la tecla enter
    _chatBoxCtrler.clear();
    _focusNode.requestFocus();
    ChatMessage newMessage = ChatMessage(
      message: texto,
      uid: '1234',
      animationCtler: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 400)),
    );
    this._messages.insert(0, newMessage);
    newMessage.animationCtler.forward();
    setState(() {
      _isWriting = false;
    });
  }
}
 