import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
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
                itemBuilder: (BuildContext context, int index) {
                  return Text('$index');
                },
                reverse: true,
              ),
            ),
            Divider(),
            Container(
              color: Colors.grey[300],
              height: 50,
              width: double.infinity,
              child: Center(child: Text('Escribir....')),
            )
          ],
        ),
      ),
    );
  }
}
