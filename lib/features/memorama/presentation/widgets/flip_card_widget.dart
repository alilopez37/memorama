
import 'dart:math';

import 'package:flutter/cupertino.dart';

class FlipCardWidget extends StatelessWidget {
  final Widget front;
  final Widget back;
  final bool isFlipped;
  final Duration duration;
  final VoidCallback? onTap;

  const FlipCardWidget({
    Key? key,
    required this.front,
    required this.back,
    required this.isFlipped,
    this.duration = const Duration(milliseconds: 400),
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: duration,
        transitionBuilder: (child, animation) {
          final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);

          return AnimatedBuilder(
            animation: rotateAnim,
            child: child,
            builder: (context, child) {
              final isUnder = (ValueKey(isFlipped) != child?.key);
              var tilt = (animation.value - 0.5).abs() - 0.5;
              tilt *= isUnder ? -0.003 : 0.003;

              final value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;

              return Transform(
                transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
                alignment: Alignment.center,
                child: child,
              );
            },
          );
        },
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut.flipped,
        child: isFlipped
            ? Container(
          key: const ValueKey(true),
          child: back,
        )
            : Container(
          key: const ValueKey(false),
          child: front,
        ),
      ),
    );
  }
}
