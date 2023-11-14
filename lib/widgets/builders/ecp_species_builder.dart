import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:survey_app/widgets/dropdowns/drop_down_async_list.dart';

import '../../database/database.dart';

class EcpSpeciesSelectBuilder extends StatelessWidget {
  const EcpSpeciesSelectBuilder(
      {super.key,
      required this.title,
      required this.updateSpecies,
      required this.genus,
      required this.species});

  final String title;
  final void Function(Value<String>? species, Value<String>? variety)
      updateSpecies;
  final String genus;
  final String species;

  @override
  Widget build(BuildContext context) {
    final Database db = Database.instance;

    String getSelectedItem() {
      if (genus.isEmpty) {
        return "Please select a genus first";
      }
      if (species.isEmpty) {
        return "Please select species";
      }

      return species;
    }

    return DropDownAsyncList(
        searchable: true,
        enabled: genus.isNotEmpty,
        title: title,
        onChangedFn: (s) {
          //Check that the same genus wasn't double selected so
          //you don't overwrite the species
          if (genus.isEmpty || s != genus) {
            species == "unknown"
                ? updateSpecies(
                    Value(s ?? "Error setting species"), const Value("N/A"))
                : updateSpecies(
                    Value(s ?? "Error setting species"), const Value.absent());
          }
        },
        asyncItems: (s) => db.referenceTablesDao.getEcpSpeciesList(genus),
        selectedItem: getSelectedItem());
  }
}
