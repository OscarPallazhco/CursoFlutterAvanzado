import 'dart:io';

import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_name_app/models/band.dart';
import 'package:band_name_app/services/socket.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: "1", name: "Metallica", votes: 3),
    Band(id: "2", name: "Queen", votes: 5),
    Band(id: "3", name: "Heroes del silencio", votes: 1),
    Band(id: "4", name: "Bon Jovi", votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Band Names",
          style: TextStyle(color: Colors.black87),
        )),
        backgroundColor: Colors.white,
        actions: [
          Container(
            child: socketService.getServerStatus == ServerStatus.Online
                ? Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                  )
                : Icon(
                    Icons.offline_bolt,
                    color: Colors.red,
                  ),
            margin: EdgeInsets.only(right: 15),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) {
          return _bandTile(bands[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: _addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Delete Band",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      onDismissed: (dismissDirection) {
        //TODO: borrado en el server
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          band.votes.toString(),
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {},
      ),
    );
  }

  _addNewBand() {
    final textController = new TextEditingController();

    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add New Band"),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  _addBandToList(textController.text);
                },
                child: Text("Add"),
                elevation: 3,
                textColor: Colors.blue,
              ),
            ],
          );
        },
      );
    } else if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Add New Band"),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: [
              CupertinoDialogAction(
                child: Text("Add"),
                isDefaultAction: true,
                onPressed: () {
                  _addBandToList(textController.text);
                },
              ),
              CupertinoDialogAction(
                child: Text("Dismiss"),
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  _addBandToList(String bandInput) {
    if (bandInput.length > 1) {
      this.bands.add(new Band(
          id: (this.bands.length + 1).toString(), name: bandInput, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
