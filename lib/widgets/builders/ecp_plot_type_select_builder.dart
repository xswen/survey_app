import 'package:flutter/material.dart';

import '../../database/database.dart';
import '../dropdowns/drop_down_async_list.dart';

class EcpPlotTypeSelectBuilder extends StatelessWidget {
  const EcpPlotTypeSelectBuilder(
      {super.key,
      required this.selectedItem,
      this.enabled = true,
      this.onBeforePopup,
      required this.updatePlotType});

  final String selectedItem;
  final bool enabled;
  final Future<bool?> Function(String?)? onBeforePopup;
  final void Function(String code) updatePlotType;

  @override
  Widget build(BuildContext context) {
    Database db = Database.instance;

    return DropDownAsyncList(
      title: "Plot type",
      enabled: enabled,
      onChangedFn: (s) => (selectedItem.isEmpty || s != selectedItem)
          ? db.referenceTablesDao
              .getEcpPlotTypeCode(s!)
              .then((code) => updatePlotType(code))
          : null,
      asyncItems: (s) => db.referenceTablesDao.getEcpPlotTypeNameList(),
      selectedItem:
          selectedItem.isEmpty ? "Please select plot type" : selectedItem,
    );
  }
}
