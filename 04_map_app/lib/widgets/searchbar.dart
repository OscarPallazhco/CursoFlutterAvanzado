part of 'myWidgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: GestureDetector(
        onTap: (){print('Search');},
        child: Container(
          width: deviceWidth * 0.8,
          height: deviceHeight * 0.08,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text('¿Dónde quieres ir?', style: TextStyle(color: Colors.black87),),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))
            ]),
        ),
      ),
    );
  }
}
