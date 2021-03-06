import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Page 2'),
          centerTitle: true,
        ),
        body: Center(
          child: Text('Page 2 '),
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
