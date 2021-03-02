import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/models/usuario.dart';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';

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
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  _UsersPageState({this.userName = "Eduardo", this.isConnected = false});

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          usuario.name,
          style: TextStyle(color: Colors.black87),
        ),
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          color: Colors.black87,
          onPressed: () {
            socketService.disconnect();
            AuthService.deleteToken();
            Navigator.pushReplacementNamed(context, 'login');
          }
        ),
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
      body: SmartRefresher(
        controller: _refreshController,
        child: _userListView(),
        enablePullDown: true,
        onRefresh: _loadUsers,
      ),
    );
  }

  ListView _userListView() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: this.usuarios.length,
      itemBuilder: (BuildContext context, int index) => _userListTile(this.usuarios[index]),
      separatorBuilder: (BuildContext context, int index) => Divider(),
    );
  }

  ListTile _userListTile(Usuario user) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(user.name.substring(0, 2)),
      ),
      trailing: Container(
        //child: Icon(Icons.check_circle),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: user.isOnline ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(200),
        ),
      ),
      title: Text(user.name),
    );
  }

  void _loadUsers() async{
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
