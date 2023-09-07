import 'package:flutter/material.dart';

import '../../database/database.dart';
import '../dropdowns/drop_down_async_list.dart';

class TreeSpeciesSelectBuilder extends StatelessWidget {
  const TreeSpeciesSelectBuilder(
      {super.key,
      this.onBeforePopup,
      required this.onChangedFn,
      required this.selectedSpeciesCode,
      required this.genusCode});

  final Future<bool?> Function(String?)? onBeforePopup;
  final void Function(String?) onChangedFn;
  final String selectedSpeciesCode;
  final String genusCode;

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
            .getSpeciesName(genusCode, selectedSpeciesCode);
      }
    }

    Future<List<String>> getSpeciesList() {
      return genusCode.isEmpty
          ? Future(() => [])
          : db.referenceTablesDao.getSpeciesNamesFromGenus(genusCode);
    }

    return FutureBuilder(
        future: getSpeciesName(),
        initialData: "Please select genus",
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return DropDownAsyncList(
            searchable: true,
            title: "Tree Species",
            onBeforePopup: onBeforePopup,
            onChangedFn: onChangedFn,
            asyncItems: (s) => getSpeciesList(),
            selectedItem: text.data ?? "Error. Null received",
          );
        });
  }
}
