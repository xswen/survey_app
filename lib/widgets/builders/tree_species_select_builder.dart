import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  String speciesName = "";

  @override
  void initState() {
    widget.genusCode.isEmpty
        ? speciesName = "Please select genus"
        : _getSpeciesName();

    print(speciesName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropDownAsyncList(
      searchable: true,
      title: "Tree Species",
      onBeforePopup: widget.onBeforePopup,
      onChangedFn: widget.onChangedFn,
      asyncItems: (s) => _getSpeciesList(),
      selectedItem: speciesName,
    );
  }

  Future<List<String>> _getSpeciesList() {
    final db = Get.find<Database>();
    if (widget.genusCode.isEmpty) {
      return Future(() => []);
    }
    return db.referenceTablesDao.getSpeciesNamesFromGenus(widget.genusCode);
  }

  void _getSpeciesName() {
    final db = Get.find<Database>();
    db.referenceTablesDao
        .getSpeciesName(widget.genusCode, widget.selectedSpeciesCode)
        .then((value) => setState(() => speciesName = value));
  }
}
