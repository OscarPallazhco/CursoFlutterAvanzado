import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/models/usuario.dart';

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/users_service.dart';
import 'package:chat_app/services/chat_service.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  final usersService = new UsersService();
  List<Usuario> users = [];
  RefreshController _refreshController = RefreshController(initialRefresh: false);


  @override
  void initState() {
    this._loadUsers();
    super.initState();
  }

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
            child: socketService.getServerStatus == ServerStatus.Online
              ? Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                )
              : Icon(
                  Icons.offline_bolt,
                  color: Colors.red,
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
      itemCount: this.users.length,
      itemBuilder: (BuildContext context, int index) => _userListTile(this.users[index]),
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
      onTap: (){
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userTo = user;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  void _loadUsers() async{
    this.users = await usersService.getUsers();      
    setState(() {
    });
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
