import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Page 1'),
          centerTitle: true,
        ),
        body: UserInformation(),
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

class UserInformation extends StatelessWidget {
  const UserInformation({
    Key key,
  }) : super(key: key);

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
            ListTile(title: Text('Nombre: '),),
            ListTile(title: Text('Edad: '),),
            

            Text('Profesiones', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            Divider(),
            ListTile(title: Text('Profesión 1: '),),
            ListTile(title: Text('Profesión 2: '),),
            ListTile(title: Text('Profesión 3: '),),
          ],
        ),
      ),
    );
  }
}
