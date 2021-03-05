import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/widgets/chat_message.dart';

import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/models/message.dart';

import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/auth_service.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  TextEditingController _chatBoxCtrler = new TextEditingController();
  FocusNode _focusNode = new FocusNode();
  bool _isWriting = false;
  List<ChatMessage> _messages = [];
  ChatService chatService;
  SocketService socketService;
  AuthService authService;

  @override
  void initState(){
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);
    _loadchatHistory();
    this.socketService.getSocket.on('mensaje-personal', _listenPersonalMessage);
    super.initState();
  }
    
      @override
      void dispose() {
        for (ChatMessage message in this._messages) {   //eliminar los reursos de las animaciones
          message.animationCtler.dispose();
        }
        this.socketService.getSocket.off('mensaje-personal'); //eliminar los reursos de estar escuchando el evento
        super.dispose();
      }
    
      @override
      Widget build(BuildContext context) {
        final Usuario userTo = this.chatService.userTo;
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
                  userTo.name,
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
    
    
      void _listenPersonalMessage(dynamic payload){
        ChatMessage newMessage = ChatMessage(
          message: payload['message'],
          uid: payload['from'],
          animationCtler: AnimationController(
              vsync: this, duration: const Duration(milliseconds: 400)),
        );
        setState(() {
          this._messages.insert(0, newMessage);
        });
        newMessage.animationCtler.forward();
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
        if (texto.trim().length == 0) return;  //no enviar mensajes vacios con la tecla enter
        _chatBoxCtrler.clear();
        _focusNode.requestFocus();
        ChatMessage newMessage = ChatMessage(
          message: texto,
          uid: this.authService.usuario.uid,
          animationCtler: AnimationController(
              vsync: this, duration: const Duration(milliseconds: 400)),
        );
        this._messages.insert(0, newMessage);
        newMessage.animationCtler.forward();
        setState(() {
          _isWriting = false;
        });
        this.socketService.getSocket.emit('mensaje-personal', {
          'from': this.authService.usuario.uid ,
          'to': this.chatService.userTo.uid ,
          'message': texto,
        });
      }
    
      void _loadchatHistory() async{
        List<Message> messages =  await this.chatService.getChat();
        final historyChatMessages = messages.map((e) => new ChatMessage(
          message: e.message,
          uid: e.from,
          animationCtler: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 0))..forward()
        ));
        setState(() {
          this._messages.insertAll(0, historyChatMessages); //insertar el historial en la lista de mensajes
        });
        }
}
 