part of 'custom_markers.dart';

class StartMarkerPainter extends CustomPainter {

  final int minutes;

  StartMarkerPainter({@required this.minutes});

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
    path.moveTo(40, 20);
    path.lineTo(width - 10, 20);
    path.lineTo(width - 10, 100);
    path.lineTo(40, 100);
    canvas.drawShadow(path, Colors.black87, 10, false);

    // caja blanca
    paint.color = Colors.white;
    final Rect whiteRect = Rect.fromLTWH(40, 20, width - 55, 80);
    canvas.drawRect(whiteRect, paint);

    // caja negra
    paint.color = Colors.black;
    final Rect blackRect = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(blackRect, paint);

    // texto cant minutos
    TextSpan textSpan = new TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w400,
      ),
      text: '${this.minutes}',
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

    textPainter.paint(canvas, Offset(40, 35));

    // texto minutos
    textSpan = new TextSpan(
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      text: 'Min',
    );

    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    
    textPainter.layout(
      maxWidth: 70,
      minWidth: 70,
    );

    textPainter.paint(canvas, Offset(40, 67));

    // texto mi ubicacion
    textSpan = new TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      text: 'Mi ubicación',
    );

    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    
    textPainter.layout(
      maxWidth: width - 130,
    );

    textPainter.paint(canvas, Offset(150, 50));
  }

  @override
  bool shouldRepaint(StartMarkerPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(StartMarkerPainter oldDelegate) => false;
}