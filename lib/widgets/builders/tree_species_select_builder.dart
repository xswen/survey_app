import 'package:flutter/material.dart';

import '../../database/database.dart';
import '../dropdowns/drop_down_async_list.dart';

class TreeSpeciesSelectBuilder extends StatefulWidget {
  const TreeSpeciesSelectBuilder({
    Key? key,
    this.onBeforePopup,
    required this.onChangedFn,
    required this.selectedSpeciesCode,
    required this.genusCode,
  }) : super(key: key);

  final Future<bool?> Function(String?)? onBeforePopup;
  final void Function(String?) onChangedFn;
  final String selectedSpeciesCode;
  final String genusCode;

  @override
  State<TreeSpeciesSelectBuilder> createState() =>
      _TreeSpeciesSelectBuilderState();
}

class _TreeSpeciesSelectBuilderState extends State<TreeSpeciesSelectBuilder> {
  final Database db = Database.instance;
  late String speciesName;

  Future<String> getSpeciesName() async {
    if (widget.genusCode.isEmpty) {
      return "Please select genus";
    } else if (widget.selectedSpeciesCode.isEmpty) {
      return "Please select species";
    } else {
      return db.referenceTablesDao
          .getSpeciesName(widget.genusCode, widget.selectedSpeciesCode);
    }
  }

  @override
  void initState() {
    getSpeciesName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<String>> getSpeciesList() {
      return widget.genusCode.isEmpty
          ? Future(() => [])
          : db.referenceTablesDao.getSpeciesNamesFromGenus(widget.genusCode);
    }

    return FutureBuilder(
        future: getSpeciesName(),
        initialData: "Please select genus",
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return DropDownAsyncList(
            searchable: true,
            title: "Tree Species",
            onBeforePopup: widget.onBeforePopup,
            onChangedFn: widget.onChangedFn,
            asyncItems: (s) => getSpeciesList(),
            selectedItem: text.data ?? "Error. Null received",
          );
        });
  }
}
