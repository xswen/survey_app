import 'package:flutter/material.dart';

import '../../database/database.dart';
import '../dropdowns/drop_down_async_list.dart';

class ReferenceNameSelectBuilder extends StatelessWidget {
  const ReferenceNameSelectBuilder({
    super.key,
    required this.name,
    required this.asyncListFn,
    required this.enabled,
    required this.onChange,
    this.title = "Plot type",
    this.defaultSelectedValue = "Please select plot type",
  });

  final Future<String> name;
  final Future<List<String>> Function() asyncListFn;
  final bool enabled;
  final void Function(String value) onChange;
  final String title;
  final String defaultSelectedValue;

  @override
  Widget build(BuildContext context) {
    Database db = Database.instance;
    return FutureBuilder(
      future: name,
      builder: (BuildContext context, AsyncSnapshot<String> name) {
        String selectedValue = name.data ?? defaultSelectedValue;
        return DropDownAsyncList(
          title: title,
          enabled: enabled,
          onChangedFn: (s) => (selectedValue.isEmpty || s != selectedValue)
              ? onChange(s!)
              : null,
          asyncItems: (s) => asyncListFn(),
          selectedItem: selectedValue,
        );
      },
    );
  }
}
