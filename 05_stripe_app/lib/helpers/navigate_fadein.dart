part of 'helpers.dart';

Route navigateFadeInToPage(BuildContext context, Widget page){
  return PageRouteBuilder(
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page,
    transitionDuration: Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        child: child,
        opacity: Tween<double>(
          begin: 0.0,
          end: 1.0
        ).animate(
          CurvedAnimation(
            curve: Curves.easeOut,
            parent: animation
          )
        ),
      );
    },
  );
}