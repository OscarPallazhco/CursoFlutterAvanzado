part of 'custom_markers.dart';

class EndMarkerPainter extends CustomPainter {

  final String destinationName;
  final double value;
  final String lengthUnit;

  EndMarkerPainter({@required this.destinationName, @required this.value, @required this.lengthUnit});

  @override
  void paint(Canvas canvas, Size size) {

    final double height = size.height;
    final double width = size.width;
    final double radius1 = 20;
    final double radius2 = 7;

    Paint paint = new Paint();
    
    // circulo negro
    paint.color = Colors.black;
    canvas.drawCircle(
      Offset(radius1, height - radius1),
      radius1,
      paint
    );

    // circulo blanco
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(radius1, height - radius1),
      radius2,
      paint
    );

    // sombra
    final Path path = new Path();
    path.moveTo(0, 20);
    path.lineTo(width - 10, 20);
    path.lineTo(width - 10, 100);
    path.lineTo(0, 100);
    canvas.drawShadow(path, Colors.black87, 10, false);

    // caja blanca
    paint.color = Colors.white;
    final Rect whiteRect = Rect.fromLTWH(0, 20, width - 10, 80);
    canvas.drawRect(whiteRect, paint);

    // caja negra
    paint.color = Colors.black;
    final Rect blackRect = Rect.fromLTWH(0, 20, 70, 80);
    canvas.drawRect(blackRect, paint);

    // texto cant m/km
    TextSpan textSpan = new TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      text: '${this.value}',
    );

    TextPainter textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    
    textPainter.layout(
      maxWidth: 70,
      minWidth: 70,
    );

    textPainter.paint(canvas, Offset(0, 35));

    // texto km
    textSpan = new TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      text: '${this.lengthUnit}',
    );

    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    
    textPainter.layout(
      maxWidth: 70,
    );

    textPainter.paint(canvas, Offset(25, 67));

    // texto ubicacion destino
    textSpan = new TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      text: this.destinationName,
    );

    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      maxLines: 2,
      ellipsis: '...',      
    );
    
    textPainter.layout(
      maxWidth: width - 100,
    );

    textPainter.paint(canvas, Offset(80, 35));
  }

  @override
  bool shouldRepaint(EndMarkerPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(EndMarkerPainter oldDelegate) => false;
}