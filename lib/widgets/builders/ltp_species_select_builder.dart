import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../database/database.dart';
import '../dropdowns/drop_down_async_list.dart';

class LtpSpeciesSelectBuilder extends StatelessWidget {
  const LtpSpeciesSelectBuilder(
      {super.key,
      this.onBeforePopup,
      required this.enabled,
      required this.selectedSpeciesCode,
      required this.genusCode,
      required this.updateSpeciesFn});

  final Future<bool?> Function(String?)? onBeforePopup;
  final bool enabled;
  final String selectedSpeciesCode;
  final String genusCode;
  final void Function(Value<String>? speciesCode, Value<String>? varietyCode)
      updateSpeciesFn;

  @override
  Widget build(BuildContext context) {
    final Database db = Database.instance;

    Future<String> getSpeciesName() async {
      if (genusCode.isEmpty) {
        return "Please select genus";
      } else if (selectedSpeciesCode.isEmpty) {
        return "Please select species";
      } else {
        return db.referenceTablesDao
            .getLtpSpeciesName(genusCode, selectedSpeciesCode);
      }
    }

    Future<List<String>> getSpeciesList() {
      return genusCode.isEmpty
          ? Future(() => [])
          : db.referenceTablesDao.getLtpSpeciesNamesFromGenus(genusCode);
    }

    return FutureBuilder(
        future: getSpeciesName(),
        initialData: "Please select species",
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return DropDownAsyncList(
            searchable: true,
            enabled: enabled,
            title: "Tree Species",
            onBeforePopup: onBeforePopup,
            onChangedFn: (s) async {
              //Check that the same variety wasn't double selected so
              //you don't overwrite the species
              if (genusCode.isEmpty ||
                  selectedSpeciesCode.isEmpty ||
                  s != selectedSpeciesCode) {
                String newSpeciesCode = await db.referenceTablesDao
                    .getLtpSpeciesCode(genusCode, s!);
                db.referenceTablesDao
                    .checkLtpNonNullVarietyExists(genusCode, newSpeciesCode)
                    .then((value) {
                  Value<String>? varietyCode =
                      value ? const Value("NULL") : const Value.absent();
                  updateSpeciesFn(Value(newSpeciesCode), varietyCode);
                });
              }
            },
            asyncItems: (s) => getSpeciesList(),
            selectedItem: text.data ?? "Error. Null received",
          );
        });
  }
}
