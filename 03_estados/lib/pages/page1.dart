import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estados/models/user.dart';
import 'package:estados/bloc/user/user_cubit.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final userCubit = BlocProvider.of<UserCubit>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Page 1'),
          centerTitle: true,
          actions: [
            BlocBuilder<UserCubit, UserState>(
              builder: (BuildContext context, state) {
                return IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: state is ActiveUserState
                  ? userCubit.deleteUser
                  : null,
                );
              },
            )
          ],
        ),
        body: BodyScaffold(),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // FloatingActionButton(
            //   heroTag: 'btnpage1',
            //   child: Text('1'),
            //   onPressed: () => Navigator.pushNamed(context, 'page1'),
            // ),
            // Divider( indent: 10,),
            FloatingActionButton(
              heroTag: 'btnpage2',
              child: Text('2'),
              onPressed: () => Navigator.pushNamed(context, 'page2'),
            ),
          ],
        ));
  }
}

class BodyScaffold extends StatelessWidget {
  const BodyScaffold({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (BuildContext context, state) { 
        if (state is InitialUserState) {
          return Center(child: Text('No existe información del usuario'),);
        } else if(state is ActiveUserState){
          return UserInformation(user: state.activeUser,);
        } else {
          return Center(child: Text('Estado no reconocido'),);
        }
      },
    );
  }
}

class UserInformation extends StatelessWidget {

  final User user;

  const UserInformation({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('General', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            Divider(),            
            ListTile(title: Text('Nombre: ${this.user.name}'),),
            ListTile(title: Text('Edad: ${this.user.age}'),),

            Text('Profesiones', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            Divider(),
            _showProfessions(),
          ],
        ),
      ),
    );
  }

  _showProfessions() {
    return this.user.professions.length>0
    ? Expanded(
      child: ListView.builder(
        itemCount: this.user.professions.length,
        itemBuilder: (BuildContext context, int index) {  
          return ListTile(title: Text('${this.user.professions[index]}'),);
        },
      ),
    )
    :ListTile(title: Text('Ninguna'),);
  }
}