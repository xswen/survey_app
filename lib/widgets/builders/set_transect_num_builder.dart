import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/constant_values.dart';

class SetTransectNumBuilder extends StatelessWidget {
  const SetTransectNumBuilder(
      {super.key,
      this.transectName = "transect",
      required this.selectedItem,
      this.transList = kTransectNumsList,
      required this.disabledFn,
      required this.onChanged,
      required this.onSubmit});

  final String transectName;
  final String selectedItem;
  final List<String> transList;
  final bool Function(String s)? disabledFn;
  final void Function(String? s)? onChanged;
  final void Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("Please select $transectName value"),
      content: Card(
        child: DropdownSearch<String>(
          selectedItem: selectedItem,
          onChanged: onChanged,
          items: transList,
          popupProps: PopupProps.menu(
            disabledItemFn: disabledFn,
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onSubmit,
          child: const Text('Set transect'),
        ),
      ],
    );
  }
}
