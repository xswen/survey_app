import 'package:flutter/material.dart';

import '../../database/database.dart';
import '../dropdowns/drop_down_async_list.dart';

class EcpPlotTypeSelectBuilder extends StatelessWidget {
  const EcpPlotTypeSelectBuilder(
      {super.key,
      required this.code,
      this.enabled = true,
      this.onBeforePopup,
      required this.updatePlotType});

  final String code;
  final bool enabled;
  final Future<bool?> Function(String?)? onBeforePopup;
  final void Function(String code) updatePlotType;

  @override
  Widget build(BuildContext context) {
    Database db = Database.instance;
    return FutureBuilder(
      future: db.referenceTablesDao.getEcpPlotTypeName(code),
      builder: (BuildContext context, AsyncSnapshot<String> name) {
        String selectedValue = name.data ?? "Please select plot type";
        return DropDownAsyncList(
          title: "Plot type",
          enabled: enabled,
          onChangedFn: (s) => (selectedValue.isEmpty || s != selectedValue)
              ? db.referenceTablesDao
                  .getEcpPlotTypeCode(s!)
                  .then((code) => updatePlotType(code))
              : null,
          asyncItems: (s) => db.referenceTablesDao.getEcpPlotTypeNameList(),
          selectedItem: selectedValue,
        );
      },
    );
  }
}
