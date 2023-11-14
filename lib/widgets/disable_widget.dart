import 'package:flutter/material.dart';

//TODO: Potentially deprecated
class DisableWidget extends StatefulWidget {
  const DisableWidget({super.key, required this.disabled, required this.child});

  final bool disabled;
  final Widget child;
  @override
  State<DisableWidget> createState() => _DisableWidgetState();
}

class _DisableWidgetState extends State<DisableWidget> {
  late Widget childEnabled;
  late Widget childDisabled;

  @override
  void initState() {
    childEnabled = widget.child;
    childDisabled = Container(
      foregroundDecoration: const BoxDecoration(
        color: Colors.grey,
        backgroundBlendMode: BlendMode.saturation,
      ),
      child: widget.child,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.disabled,
      child: widget.disabled ? childDisabled : childEnabled,
    );
  }
}
