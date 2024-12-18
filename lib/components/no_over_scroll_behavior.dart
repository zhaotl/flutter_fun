import 'package:flutter/material.dart';

class NoOverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return GlowingOverscrollIndicator(
        axisDirection: details.direction,
        showLeading: false,
        showTrailing: false,
        color: Colors.transparent,
        child: child);
  }
}
