import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:estados/models/user.dart';
import 'package:estados/services/user_service.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final userService = Provider.of<UserService>(context);

    return Scaffold(
        appBar: AppBar(
          title: userService.existUser
          ? Text(userService.getUser.name)
          : Text('Page 2'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: (){
                  final userService = Provider.of<UserService>(context, listen: false);
                  //por defecto el listen está en true, cuando se usa dentro de un método hay que
                  //setearlo en false, porque el provider necesita estar dentro de un build para
                  //redibujarlo

                  final User user = new User(
                    name: 'Eduardo',
                    age: 25,
                    professions: []
                  );

                  userService.setUser = user;
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
                onPressed: (){
                  final userService = Provider.of<UserService>(context, listen: false);
                  userService.changeAge(26);
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
                onPressed: (){
                  final userService = Provider.of<UserService>(context, listen: false);
                  userService.addProfession('Developer');
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
