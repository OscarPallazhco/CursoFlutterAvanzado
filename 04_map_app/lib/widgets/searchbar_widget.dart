part of 'myWidgets.dart';

class SearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.manualSelection) {
          return Container();
        } else {
          return FadeInDown(
            duration: Duration(milliseconds: 300),
            child: _buildSearchBar(context)
          );
        }
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: GestureDetector(        
        child: Container(
          width: deviceWidth * 0.8,
          height: deviceHeight * 0.08,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text('¿Dónde quieres ir?', style: TextStyle(color: Colors.black54,)),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))
            ]),
        ),
        onTap: () async{
          // ignore: close_sinks
          final myLocationBloc = BlocProvider.of<MyLocationBloc>(context);
          // ignore: close_sinks
          final _searchBloc = BlocProvider.of<SearchBloc>(context);
          final SearchResult result = await showSearch(
            context: context,
            delegate: SearchDestination(myLocationBloc.state.coord, _searchBloc.state.history)
          );
          _handleSearch(context, result);
        },
      ),
    );
  }

  void _handleSearch(BuildContext context, SearchResult result) async{
    // ignore: close_sinks
    final _searchBloc = BlocProvider.of<SearchBloc>(context);
    if (result.cancel) {
      return;
    }else if (result.manual) {
      _searchBloc.add(OnActivateManualMarker());
      return;
    }else{
      // seleccionó un lugar, con lo cual en el SearchResult viene las coordenadas del lugar destino
      
      calculatingAlert(context);    
      final _trafficService = new TrafficService();
      // ignore: close_sinks
      final _myLocationBloc = BlocProvider.of<MyLocationBloc>(context);
      // ignore: close_sinks
      final _mapBloc = BlocProvider.of<MapBloc>(context);
      final start = _myLocationBloc.state.coord;
      final end = result.destinationPosition;

      // obtener de la respuesta las coordenadas, pasarlas a una lista de LatLngs necesario para crear un
      // PolyLine
      final trafficResponse = await _trafficService.getStartAndEndCoords(start, end);
      final geometry = trafficResponse.routes[0].geometry;
      final duration = trafficResponse.routes[0].duration;
      final distance = trafficResponse.routes[0].distance;
      final pointsDoubles = Poly.Polyline.Decode(encodedString: geometry, precision: 6).decodedCoords;
      List<LatLng> pointsLatLngs = pointsDoubles.map((par){
        return new LatLng(par[0], par[1]);
      }).toList();
      _mapBloc.add(OnCreateRoute(pointsLatLngs, distance, duration));
      }
      Navigator.of(context).pop();  // quita la alert de 'calculando'
      _searchBloc.add(OnSaveToHistory(result));

  }
}
