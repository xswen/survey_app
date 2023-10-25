import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:survey_app/widgets/dropdowns/drop_down_async_list.dart';

import '../../database/database.dart';

class SubstrateTypeSelectBuilder extends StatelessWidget {
  const SubstrateTypeSelectBuilder(
      {super.key,
      required this.title,
      required this.enabled,
      required this.updateType,
      required this.substrateTypeCode});

  final String title;
  final bool enabled;
  final void Function(Value<String>? substrateTypeCode, Value<int?>? depth)
      updateType;
  final String substrateTypeCode;

  @override
  Widget build(BuildContext context) {
    final Database db = Database.instance;
    Future<String> getSubstrateType() =>
        db.referenceTablesDao.getSubstrateTypeNameFromCode(substrateTypeCode);

    return FutureBuilder(
        future: getSubstrateType(),
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return DropDownAsyncList(
            searchable: true,
            enabled: enabled,
            title: title,
            onChangedFn: (s) async {
              //Check that the same type wasn't double selected so
              //you don't overwrite the depth
              if (substrateTypeCode.isEmpty || s != substrateTypeCode) {
                SubstrateTypeData newSubstrateType = await db.referenceTablesDao
                    .getSubstrateTypeDataFromName(s!);
                if (newSubstrateType.hasDepth) {
                  updateType(
                      Value(newSubstrateType.typeCode), const Value.absent());
                } else {
                  updateType(
                      Value(newSubstrateType.typeCode), const Value(null));
                }
              }
            },
            asyncItems: (s) => db.referenceTablesDao.substrateTypeNames,
            selectedItem: text.data ?? "Please select substrate type",
          );
        });
  }
}
