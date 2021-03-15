part of 'myWidgets.dart';

class BtnMyLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // ignore: close_sinks
    final _myLocationBloc = BlocProvider.of<MyLocationBloc>(context);
    // ignore: close_sinks
    final _mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      child: CircleAvatar(
        backgroundColor: Colors.white70,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.my_location, color: Colors.black87,),
          onPressed: (){
            _mapBloc.moveCamera(_myLocationBloc.state.coord);
          }
        ),
      ),
    );
  }
}