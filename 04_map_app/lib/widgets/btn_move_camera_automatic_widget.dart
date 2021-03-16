part of 'myWidgets.dart';

class BtnMoveCameraAutomatic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // ignore: close_sinks
    final _mapBloc = BlocProvider.of<MapBloc>(context);
    // se lo envuelve en un blocbuilder porque este boton estará cambiando su apariencia
    return BlocBuilder<MapBloc, MapState>(
      builder: (BuildContext context, state) {
        return Container(
          margin: EdgeInsets.only(bottom: 5),
          child: CircleAvatar(
            backgroundColor: state.moveCameraAutomatic
              ? Colors.blue
              : Colors.white,
            maxRadius: 25,
            child: IconButton(
              icon: Icon(
                state.moveCameraAutomatic
                  ? Icons.accessibility_new_rounded
                  : Icons.directions_run,
                color:state.moveCameraAutomatic
                  ? Colors.white
                  : Colors.black87,
              ),
              onPressed: (){
                _mapBloc.add(OnMapMoveCameraAutomatic());
              }
            ),
          ),
        );
      },
    );
  }
}