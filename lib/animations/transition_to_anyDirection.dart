import 'package:flutter/material.dart';

class VerticalPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final SlideDirection direction;

  VerticalPageRoute({required this.page, required this.direction})
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Determine the slide direction
            Offset begin;
            switch (direction) {
              case SlideDirection.fromTop:
                begin = const Offset(0.0, -1.0); // Slide from top
                break;
              case SlideDirection.fromBottom:
                begin = const Offset(0.0, 1.0); // Slide from bottom
                break;
              // Default fallback
            }
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}

enum SlideDirection { fromTop, fromBottom }