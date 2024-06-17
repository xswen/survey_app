import 'package:flutter/material.dart';

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
    this.searchable = false,
    this.disabledFn,
  });

  final Future<String> name;
  final Future<List<String>> Function() asyncListFn;
  final bool enabled;
  final void Function(String value) onChange;
  final String title;
  final String defaultSelectedValue;
  final bool searchable;
  final bool Function(String?)? disabledFn;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: name,
      builder: (BuildContext context, AsyncSnapshot<String> name) {
        String selectedValue = name.data ?? "Error loading data";
        return DropDownAsyncList(
          title: title,
          enabled: enabled,
          searchable: searchable,
          onChangedFn: (s) => (selectedValue.isEmpty || s != selectedValue)
              ? onChange(s!)
              : null,
          disabledFn: disabledFn,
          asyncItems: (s) => asyncListFn(),
          selectedItem:
              selectedValue.isEmpty ? defaultSelectedValue : selectedValue,
        );
      },
    );
  }
}
