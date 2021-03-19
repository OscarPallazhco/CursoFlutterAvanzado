import 'package:flutter/material.dart';
import 'package:map_app/models/search_result.dart';

class SearchDestination extends SearchDelegate<SearchResult>{

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
    final SearchResult result = new SearchResult(cancel: true);
    return IconButton(
      icon: Icon(Icons.arrow_back_rounded),
      onPressed: ()=>this.close(context, result)
    );
  }
  
  @override
  Widget buildResults(BuildContext context) {
    return Text('BuildResults');
  }
  
  @override
  Widget buildSuggestions(BuildContext context) {
    SearchResult result = new SearchResult(cancel: false, manual: true);
    return ListView(
      children: [        
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text('Colocar ubicación manualmente'),
          onTap: (){
            this.close(context, result);
          },
        )
      ],
    );
  }
  
}