import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  //final String userName = "dfdf";
  //final bool isConnected = false;
  final String userName;
  final bool isConnected;
  final usuarios = [
    Usuario(uid: '1', name: "Jose", email: "Jose@gmail.com", isOnline: true),
    Usuario(uid: '2', name: "Marbella",email: "Marbella@gmail.com",isOnline: false),
    Usuario(uid: '3', name: "Juan", email: "Juan@gmail.com", isOnline: true),
    Usuario(uid: '4', name: "Carlos", email: "Carlos@gmail.com", isOnline: false),
    Usuario(uid: '5', name: "Karla", email: "Karla@gmail.com", isOnline: true),
    Usuario(uid: '6', name: "Maria", email: "Maria@gmail.com", isOnline: true),
    Usuario(uid: '7', name: "Estefanía", email: "Estefania@gmail.com", isOnline: false),
    Usuario(uid: '8', name: "José", email: "Jose@gmail.com", isOnline: false),
    Usuario(uid: '9', name: "Pedro", email: "Pedro@gmail.com", isOnline: true),
    Usuario(uid: '10', name: "Luis", email: "Luis@gmail.com", isOnline: true),
    Usuario(uid: '11', name: "Elizabeth", email: "Elizabeth@gmail.com", isOnline: false),
    Usuario(uid: '12', name: "Monica", email: "Monica@gmail.com", isOnline: true),
  ];

  _UsersPageState({this.userName = "Eduardo", this.isConnected = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          this.userName,
          style: TextStyle(color: Colors.black87),
        ),
        leading: IconButton(
            icon: Icon(Icons.exit_to_app),
            color: Colors.black87,
            onPressed: () {}),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.check_circle,
              color: this.isConnected ? Colors.green[400] : Colors.red[400],
            ),
          )
        ],
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: this.usuarios.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(this.usuarios[index].name.substring(0, 2)),
            ),
            trailing: Container(
              //child: Icon(Icons.check_circle),
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: this.usuarios[index].isOnline ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(200),
              ),
            ),
            title: Text(this.usuarios[index].name),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }
}
