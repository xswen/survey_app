import 'package:flutter/material.dart';

class DisableWidget extends StatelessWidget {
  const DisableWidget({super.key, required this.disabled, required this.child});

  final bool disabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disabled,
      child: disabled
          ? Container(
              foregroundDecoration: const BoxDecoration(
                color: Colors.grey,
                backgroundBlendMode: BlendMode.saturation,
              ),
              child: child,
            )
          : child,
    );
  }
}
