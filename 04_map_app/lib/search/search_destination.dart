import 'package:flutter/material.dart';

class SearchDestination extends SearchDelegate{

  @override
  final String searchFieldLabel;

  SearchDestination({this.searchFieldLabel='Buscar'});


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.mic),
        onPressed: (){
          print('Mic pressed');
        },
      )
    ];
  }
  
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_rounded),
      onPressed: ()=>this.close(context, null)
    );
  }
  
  @override
  Widget buildResults(BuildContext context) {
    return Text('BuildResults');
  }
  
  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [        
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text('Colocar ubicación manualmente'),
          onTap: (){
            this.close(context, null);
          },
        )
      ],
    );
  }
  
}