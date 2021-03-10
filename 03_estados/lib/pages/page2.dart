import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estados/models/user.dart';

import 'package:estados/bloc/user/user_bloc.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // ignore: close_sinks
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Page 2'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  User newUser = new User(name: 'Eduardo', age: 25, professions: []);
                  // BlocProvider.of<UserBloc>(context).add(EstablishUser(newUser));
                  userBloc.add(EstablishUser(newUser));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  alignment: Alignment.center,
                  child: Text(
                    'Establecer usuario',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                color: Colors.blue,
                shape: StadiumBorder(),
                elevation: 2,
              ),
              MaterialButton(
                onPressed: () {
                  userBloc.add(ChangeAge(26));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  alignment: Alignment.center,
                  child: Text(
                    'Cambiar edad',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                color: Colors.blue,
                shape: StadiumBorder(),
                elevation: 2,
              ),
              MaterialButton(
                onPressed: () {
                  userBloc.add(AddProfession('Developer'));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  alignment: Alignment.center,
                  child: Text(
                    'Añadir profesión',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                color: Colors.blue,
                shape: StadiumBorder(),
                elevation: 2,
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'btnpage1',
              child: Text('1'),
              onPressed: () => Navigator.pushNamed(context, 'page1'),
            ),
            // Divider( indent: 10,),
            // FloatingActionButton(
            //   heroTag: 'btnpage2',
            //   child: Text('2'),
            //   onPressed: () => Navigator.pushNamed(context, 'page2'),
            // ),
          ],
        ));
  }
}
