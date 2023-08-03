import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../constants/constant_values.dart';

class TableCreationBuilder extends StatelessWidget {
  final DataGridSource source;
  final void Function(DataGridCellTapDetails)? onCellTap;
  final List<Map<String, Object>> colNames;
  final bool allowSort;
  const TableCreationBuilder(
      {super.key,
      required this.source,
      required this.colNames,
      required this.onCellTap,
      this.allowSort = true});

  List<GridColumn> getCols() {
    return colNames
        .map<GridColumn>(
          (value) => GridColumn(
              columnName: value[kColHeaderMapKeyName] as String,
              label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    value[kColHeaderMapKeyName] as String,
                    overflow: TextOverflow.visible,
                  )),
              allowSorting: value[kColHeaderMapKeySort] as bool),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: source,
      allowSorting: allowSort,
      columnWidthMode: ColumnWidthMode.fill,
      columns: getCols(),
      onCellTap: onCellTap,
    );
  }
}
