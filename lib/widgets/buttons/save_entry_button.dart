import 'package:flutter/material.dart';

import 'delete_button.dart';

class SaveEntryButton extends StatelessWidget {
  const SaveEntryButton(
      {super.key,
      required this.saveRetFn,
      this.saveRetTitle = "Save and return",
      required this.saveAndAddFn,
      this.saveAndAddTitle = "Save and Add New Entry",
      required this.delVisible,
      required this.deleteFn});

  final void Function() saveRetFn;
  final String saveRetTitle;
  final void Function() saveAndAddFn;
  final String saveAndAddTitle;
  final bool delVisible;
  final void Function() deleteFn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: saveRetFn, child: Text(saveRetTitle)),
              ElevatedButton(
                  onPressed: saveAndAddFn, child: Text(saveAndAddTitle)),
            ],
          ),
          Visibility(visible: delVisible, child: DeleteButton(delete: deleteFn))
        ],
      ),
    );
  }
}
