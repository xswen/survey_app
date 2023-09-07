import 'package:flutter/material.dart';

import '../../database/database.dart';
import '../dropdowns/drop_down_async_list.dart';

class TreeGenusSelectBuilder extends StatelessWidget {
  const TreeGenusSelectBuilder(
      {super.key,
      this.onBeforePopup,
      required this.onChangedFn,
      required this.genusCode});

  final Future<bool?> Function(String?)? onBeforePopup;
  final void Function(String?) onChangedFn;
  final String genusCode;

  @override
  Widget build(BuildContext context) {
    final Database db = Database.instance;
    Future<String> getGenusName() =>
        db.referenceTablesDao.getGenusNameFromCode(genusCode);

    return FutureBuilder(
        future: getGenusName(),
        initialData: "Please select genus",
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return DropDownAsyncList(
            searchable: true,
            title: "Tree Genus",
            onBeforePopup: onBeforePopup,
            onChangedFn: onChangedFn,
            asyncItems: (s) => db.referenceTablesDao.genusLatinNames,
            selectedItem: text.data ?? "Please select genus",
          );
        });
  }
}
