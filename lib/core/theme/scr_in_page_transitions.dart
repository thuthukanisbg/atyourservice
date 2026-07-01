import 'package:flutter/material.dart';

/// Matches the design handoff's `scrIn` keyframe (`opacity 0→1,
/// translateY 8px→0, 0.35s ease`), which every screen in the prototype
/// uses on entry. Flutter's platform-default transitions (slide-from-right
/// on iOS, fade-through on Android) don't match that motion language, so
/// this replaces them uniformly across platforms.
class ScrInPageTransitionsBuilder extends PageTransitionsBuilder {
  const ScrInPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: curved.drive(
          Tween<Offset>(begin: const Offset(0, 0.012), end: Offset.zero),
        ),
        child: child,
      ),
    );
  }
}
