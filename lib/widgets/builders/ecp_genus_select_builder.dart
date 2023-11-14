import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:survey_app/widgets/dropdowns/drop_down_async_list.dart';

import '../../database/database.dart';

class EcpGenusSelectBuilder extends StatelessWidget {
  const EcpGenusSelectBuilder(
      {super.key,
      required this.title,
      required this.updateGenus,
      required this.genus});
  final String title;
  final void Function(
          Value<String>? genus, Value<String>? species, Value<String>? variety)
      updateGenus;
  final String genus;
  @override
  Widget build(BuildContext context) {
    final Database db = Database.instance;
    return DropDownAsyncList(
        searchable: true,
        title: title,
        onChangedFn: (s) {
          //Check that the same genus wasn't double selected so
          //you don't overwrite the species
          if (genus.isEmpty || s != genus) {
            updateGenus(Value(s ?? "Error setting ecp genus"),
                const Value.absent(), const Value.absent());
          }
        },
        asyncItems: (s) => db.referenceTablesDao.ecpGenusList,
        selectedItem: genus.isEmpty ? "Please select genus" : genus);
  }
}
