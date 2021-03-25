part of 'myWidgets.dart';

class ManualMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.manualSelection) {
          return Stack(
            children: [
              _marker(),
              _cancelButton(context),
              _checkButton(context),
            ],
          ); 
        } else {return Container();}
         
      },
    );
  }

  Positioned _cancelButton(BuildContext context) {
    // ignore: close_sinks
    final _searchBloc = BlocProvider.of<SearchBloc>(context);
    return Positioned(
        bottom: 20,
        left: MediaQuery.of(context).size.width*0.35,
        child: FadeInUp(
          duration: Duration(milliseconds: 300),
          child: CircleAvatar(
            maxRadius: 25,
            backgroundColor: Colors.white,
            child: IconButton(
              iconSize: 30,
              color: Colors.black,
              icon: Icon(Icons.cancel_rounded, color: Colors.black87 ,),
              onPressed: (){
                _searchBloc.add(OnDesactivateManualMarker());
              }
            ),
          ),
        )
      );
  }
  
  Positioned _checkButton(BuildContext context) {
    return Positioned(
        bottom: 20,
        right: MediaQuery.of(context).size.width*0.35,
        child: FadeInUp(
          duration: Duration(milliseconds: 300),
          child: CircleAvatar(
            maxRadius: 25,
            backgroundColor: Colors.white,
            child: IconButton(
              iconSize: 30,
              color: Colors.black,
              icon: Icon(Icons.check_circle, color: Colors.black87),
              onPressed: (){
                _calculateDestination(context);
              }
            ),
          ),
        )
      );
  }

  _marker() {
    return Center(
      child: Transform.translate(
        offset: Offset(0, -20),
        child: BounceInDown(child: Icon(Icons.location_on, size: 50,)),      
      ),
    );
  }

  void _calculateDestination(BuildContext context) async{
    calculatingAlert(context);
    final _trafficService = new TrafficService();
    // ignore: close_sinks
    final _myLocationBloc = BlocProvider.of<MyLocationBloc>(context);
        // ignore: close_sinks
    final _searchBloc = BlocProvider.of<SearchBloc>(context);
    // ignore: close_sinks
    final _mapBloc = BlocProvider.of<MapBloc>(context);
    final start = _myLocationBloc.state.coord;
    final end = _mapBloc.state.centralPosition;

    // info del destino
    final infoEnd = await _trafficService.getInfoOfCoords(end);
    final destinationName = infoEnd.features[0].text;

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
    _mapBloc.add(OnCreateRoute(pointsLatLngs, distance, duration, destinationName));
    Navigator.of(context).pop();  // quita la alert de 'calculando'
    _searchBloc.add(OnDesactivateManualMarker());
  }
}