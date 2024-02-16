import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../database/database.dart';
import '../dropdowns/drop_down_async_list.dart';

class LtpVarietySelectBuilder extends StatelessWidget {
  const LtpVarietySelectBuilder(
      {super.key,
      required this.title,
      required this.enabled,
      this.onBeforePopup,
      required this.genusCode,
      required this.speciesCode,
      required this.selectedVarietyCode,
      required this.updateVarietyFn});

  final String title;
  final bool enabled;
  final Future<bool?> Function(String?)? onBeforePopup;
  final String genusCode;
  final String speciesCode;
  final String selectedVarietyCode;
  final void Function(Value<String>? varietyCode) updateVarietyFn;

  @override
  Widget build(BuildContext context) {
    final Database db = Database.instance;

    Future<String> getVarietyName() async {
      if (genusCode.isEmpty) {
        return "Please select genus";
      } else if (speciesCode.isEmpty) {
        return "Please select species";
      } else if (selectedVarietyCode.isEmpty) {
        return "Please select variety";
      } else {
        return db.referenceTablesDao
            .getLtpVarietyName(genusCode, speciesCode, selectedVarietyCode);
      }
    }

    Future<List<String>> getVarietyList() {
      return genusCode.isEmpty || speciesCode.isEmpty
          ? Future(() => [])
          : db.referenceTablesDao
              .getLtpVarietyNamesFromGenusSpecies(genusCode, speciesCode);
    }

    return FutureBuilder(
        future: getVarietyName(),
        initialData: "Please select genus",
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return DropDownAsyncList(
            searchable: true,
            enabled: enabled,
            title: "Tree variety",
            onBeforePopup: onBeforePopup,
            onChangedFn: (s) async {
              String newVarietyCode = await db.referenceTablesDao
                  .getLtpVarietyCode(genusCode, speciesCode, s!);
              updateVarietyFn(Value(newVarietyCode));
            },
            asyncItems: (s) => getVarietyList(),
            selectedItem: text.data ?? "Error. Null received",
          );
        });
  }
}
