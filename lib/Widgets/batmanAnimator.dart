import 'package:flutter/cupertino.dart';

class BatmanPageRoute extends PageRouteBuilder {
  final Widget child;

  BatmanPageRoute(this.child)
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return child;
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return Transform.scale(
            scale: animation.value,
            child: Transform.rotate(
              angle: 18 - 18 * animation.value,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          );
        });
}
