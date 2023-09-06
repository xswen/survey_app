import 'package:flutter/material.dart';

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
  final Database db = Database.instance;
  String genusName = "";

  void _getGenusName() {
    db.referenceTablesDao
        .getGenusNameFromCode(widget.genusCode)
        .then((value) => setState(() => genusName = value));
  }

  @override
  void initState() {
    widget.genusCode.isEmpty
        ? genusName = "Please select genus"
        : _getGenusName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<String>> getGenusList() =>
        db.referenceTablesDao.genusLatinNames;

    return DropDownAsyncList(
      searchable: true,
      title: "Tree Genus",
      onBeforePopup: widget.onBeforePopup,
      onChangedFn: widget.onChangedFn,
      asyncItems: (s) => getGenusList(),
      selectedItem: genusName,
    );
  }
}
