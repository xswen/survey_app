import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

import '../../database/database.dart';
import '../dropdowns/drop_down_async_list.dart';

class SubstrateDepthSelectBuilder extends StatelessWidget {
  const SubstrateDepthSelectBuilder(
      {super.key,
      this.title = "Substrate Depth Measured To",
      required this.updateType,
      required this.substrateDepthCode});

  final String title;
  final void Function(Value<int>? depth) updateType;
  final int? substrateDepthCode;

  @override
  Widget build(BuildContext context) {
    final Database db = Database.instance;
    Future<String> getSubstrateDepth() async => substrateDepthCode == null
        ? "Please select depth limit"
        : await db.referenceTablesDao
            .getSubstrateDepthLimitNameFromCode(substrateDepthCode!);

    return FutureBuilder(
        future: getSubstrateDepth(),
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return DropDownAsyncList(
            title: title,
            searchable: true,
            onChangedFn: (s) async => updateType(Value(await db
                .referenceTablesDao
                .getSubstrateDepthLimitCodeFromName(s!))),
            asyncItems: (s) => db.referenceTablesDao.ssDepthList,
            selectedItem: text.data ?? "Please select substrate depth",
          );
        });
  }
}
