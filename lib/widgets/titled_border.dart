import 'package:flutter/material.dart';

import '../constants/margins_padding.dart';
import '../constants/text_designs.dart';

class TitledBorder extends StatefulWidget {
  const TitledBorder(
      {super.key,
      required this.title,
      required this.child,
      this.titleStyle = kBorderTitleStyle,
      this.actions,
      this.boxMargin = kTitledBoxBoxMargin,
      this.boxPadding = kTitledBoxBoxPadding,
      this.titlePadding = kTitledBoxTitlePadding});
  final String title;
  final TextStyle titleStyle;
  final Widget child;
  final Widget? actions;
  final EdgeInsetsGeometry boxMargin;
  final EdgeInsetsGeometry boxPadding;
  final EdgeInsetsGeometry titlePadding;

  @override
  State<TitledBorder> createState() => _TitledBorderState();
}

class _TitledBorderState extends State<TitledBorder> {
  late Widget _actions;

  @override
  void initState() {
    if (widget.actions == null) {
      _actions = const SizedBox();
    } else {
      _actions = Positioned(
        right: 8,
        top: 12,
        child: widget.actions!,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        margin: widget.boxMargin,
        padding: widget.boxPadding,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 1),
          borderRadius: BorderRadius.circular(5),
          shape: BoxShape.rectangle,
        ),
        child: widget.child,
      ),
      Positioned(
          left: 32,
          top: 12,
          child: Container(
            padding: widget.titlePadding,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Text(
              widget.title,
              style: kBorderTitleStyle,
            ),
          )),
      _actions
    ]);
  }
}
