import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../wrappers/column_header_object.dart';

class DataGridSourceBuilder extends DataGridSource {
  DataGridSourceBuilder({required this.dataGridRows});

  List<DataGridRow> dataGridRows;

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    //skip Id. Id is only here for referencing
    DataGridRow newRow = DataGridRow(cells: row.getCells().sublist(1));
    return DataGridRowAdapter(
        cells: newRow.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: (dataGridCell.columnName == ColumnHeaders.headerNameId)
              ? Alignment.centerRight
              : Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: (dataGridCell.columnName == ColumnHeaders.headerNameEdit)
              ? const Icon(FontAwesomeIcons.penToSquare)
              : Text(
                  dataGridCell.value.toString(),
                  overflow: TextOverflow.visible,
                ));
    }).toList());
  }
}
