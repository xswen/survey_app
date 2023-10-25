import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:survey_app/constants/constant_values.dart';

import '../../database/database.dart';
import '../dropdowns/drop_down_async_list.dart';

class TreeGenusSelectBuilder extends StatelessWidget {
  const TreeGenusSelectBuilder(
      {super.key,
      this.title = "Tree Genus",
      this.enabled = true,
      this.onBeforePopup,
      required this.updateGenusFn,
      required this.genusCode});

  final String title;
  final bool enabled;
  final Future<bool?> Function(String?)? onBeforePopup;
  final void Function(Value<String>? genusCode, Value<String>? speciesCode)
      updateGenusFn;
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
            enabled: enabled,
            title: title,
            onBeforePopup: onBeforePopup,
            onChangedFn: (s) async {
              //Check that the same genus wasn't double selected so
              //you don't overwrite the species
              if (genusCode.isEmpty || s != genusCode) {
                String newGenusCode =
                    await db.referenceTablesDao.getGenusCodeFromName(s!);
                db.referenceTablesDao
                    .checkGenusUnknown(newGenusCode)
                    .then((value) {
                  Value<String>? speciesCode = value
                      ? const Value(kSpeciesUnknownCode)
                      : const Value.absent();
                  updateGenusFn(Value(newGenusCode), speciesCode);
                });
              }
            },
            asyncItems: (s) => db.referenceTablesDao.genusLatinNames,
            selectedItem: text.data ?? "Please select genus",
          );
        });
  }
}
