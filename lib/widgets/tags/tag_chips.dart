import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  const TagChip(
      {super.key,
      required this.title,
      required this.selected,
      required this.onSelected});
  final String title;
  final bool selected;
  final void Function(bool selected) onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      backgroundColor: Colors.tealAccent[200],
      label: Text(title),
      selected: selected,
      onSelected: onSelected,
      selectedColor: Colors.purpleAccent,
    );
  }
}
