import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String label1, label2, routeName;

  const Labels(
      {Key key,
      @required this.label1,
      @required this.label2,
      @required this.routeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            this.label1,
            style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
                fontWeight: FontWeight.w300),
          ),
          GestureDetector(
            child: Text(
              this.label2,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue[600],
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, this.routeName);
            },
          ),
        ],
      ),
    );
  }
}
