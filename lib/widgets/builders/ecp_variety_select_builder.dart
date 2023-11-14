import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../database/database.dart';
import '../dropdowns/drop_down_async_list.dart';

class EcpVarietySelectBuilder extends StatelessWidget {
  const EcpVarietySelectBuilder(
      {super.key,
      required this.title,
      required this.updateVariety,
      required this.genus,
      required this.species,
      required this.variety});

  final String title;
  final void Function(Value<String>? variety) updateVariety;
  final String genus;
  final String species;
  final String variety;

  @override
  Widget build(BuildContext context) {
    final Database db = Database.instance;

    return DropDownAsyncList(
        searchable: true,
        title: title,
        onChangedFn: (s) {
          //Check that the same variety wasn't double selected so
          //you don't overwrite the variety
          if (variety.isEmpty || s != variety) {
            updateVariety(Value(s ?? "Error setting variety"));
          }
        },
        asyncItems: (s) =>
            db.referenceTablesDao.getEcpVarietyList(genus, species),
        selectedItem: variety.isEmpty ? "Please select variety" : variety);
  }
}
