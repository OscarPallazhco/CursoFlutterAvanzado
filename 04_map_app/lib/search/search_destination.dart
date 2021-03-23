import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:map_app/services/traffic_service.dart';

import 'package:map_app/models/places_response.dart';
import 'package:map_app/models/search_result.dart';

class SearchDestination extends SearchDelegate<SearchResult>{

  @override
  final String searchFieldLabel;
  final LatLng _proximity;
  final TrafficService _trafficService = new TrafficService();

  SearchDestination(this._proximity, {this.searchFieldLabel = 'Buscar'});


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
    return this._getSuggestions();
  }
  
  @override
  Widget buildSuggestions(BuildContext context) {
    SearchResult result = new SearchResult(cancel: false, manual: true);
    if (this.query.trim().length == 0) {
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
    return this._getSuggestions();
  }

  Widget _getSuggestions(){
    if (this.query.trim().length == 0) {
      return Container();
    }
    this._trafficService.getPlacesResults(this.query.trim(), this._proximity);
    return StreamBuilder(
      stream: this._trafficService.getPlacesStream,
      builder: (BuildContext context, AsyncSnapshot<PlacesResponse> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }
        final places = snapshot.data.features;
        if (places.length == 0) {
          return ListTile(
            title: Text('No hay coincidencias para ${this.query}'),
          );
        }
        return ListView.separated(
          itemCount: places.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),        
          itemBuilder: (BuildContext context, int index) {
            final place = places[index];
            return ListTile(
              leading: Icon(Icons.place_rounded),
              title: Text(place.text),
              subtitle: Text(place.placeName),
            );
          },
        );
      },
    );
  }
  
}