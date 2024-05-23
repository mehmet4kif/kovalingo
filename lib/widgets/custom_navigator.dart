import 'package:flutter/material.dart';

PageRouteBuilder customNavigator(Widget page){
  return PageRouteBuilder(
    opaque: false,
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, anim, __, child) {
      return ScaleTransition(
        scale: anim,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 250),
  );
}
