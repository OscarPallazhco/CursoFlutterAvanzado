part of 'myWidgets.dart';

class ManualMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _marker(),
        _cancelButton(context),
        _checkButton(context),
      ],
    );
  }

  Positioned _cancelButton(BuildContext context) {
    return Positioned(
        bottom: 20,
        left: MediaQuery.of(context).size.width*0.35,
        child: CircleAvatar(
          maxRadius: 25,
          backgroundColor: Colors.white,            
          child: IconButton(              
            iconSize: 30,
            color: Colors.black,
            icon: Icon(Icons.cancel_rounded, color: Colors.black87 ,),
            onPressed: (){}
          ),          
        )
      );
  }
  
  Positioned _checkButton(BuildContext context) {
    return Positioned(
        bottom: 20,
        right: MediaQuery.of(context).size.width*0.35,
        child: CircleAvatar(
          maxRadius: 25,
          backgroundColor: Colors.white,            
          child: IconButton(              
            iconSize: 30,
            color: Colors.black,
            icon: Icon(Icons.check_circle, color: Colors.black87),
            onPressed: (){}
          ),          
        )
      );
  }

  _marker() {
    return Center(
      child: Transform.translate(
        offset: Offset(0, -20),
        child: Icon(Icons.location_on, size: 50,),      
      ),
    );
  }
}