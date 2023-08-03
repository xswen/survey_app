import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../database/database.dart';
import '../dropdowns/drop_down_async_list.dart';

class TreeGenusSelectBuilder extends StatefulWidget {
  const TreeGenusSelectBuilder({
    Key? key,
    this.onBeforePopup,
    required this.onChangedFn,
    required this.genusCode,
  }) : super(key: key);
  final Future<bool?> Function(String?)? onBeforePopup;
  final void Function(String?) onChangedFn;
  final String genusCode;

  @override
  State<TreeGenusSelectBuilder> createState() => _TreeGenusSelectBuilderState();
}

class _TreeGenusSelectBuilderState extends State<TreeGenusSelectBuilder> {
  String genusName = "";

  @override
  void initState() {
    widget.genusCode.isEmpty
        ? genusName = "Please select genus"
        : _getGenusName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropDownAsyncList(
      searchable: true,
      title: "Tree Genus",
      onBeforePopup: widget.onBeforePopup,
      onChangedFn: widget.onChangedFn,
      asyncItems: (s) => _getGenusList(),
      selectedItem: genusName,
    );
  }

  Future<List<String>> _getGenusList() {
    final db = Get.find<Database>();
    return db.referenceTablesDao.genusLatinNames;
  }

  void _getGenusName() {
    final db = Get.find<Database>();
    db.referenceTablesDao
        .getGenusNameFromCode(widget.genusCode)
        .then((value) => setState(() => genusName = value));
  }
}
