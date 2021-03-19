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
              onPressed: (){}
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
}