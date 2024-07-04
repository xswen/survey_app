import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../wrappers/column_header_object.dart';

class TableCreationBuilder extends StatelessWidget {
  final DataGridSource source;
  final void Function(DataGridCellTapDetails)? onCellTap;
  final List<ColumnHeaders> colNames;
  final bool allowSort;
  final ColumnWidthMode? columnWidthMode;

  const TableCreationBuilder(
      {super.key,
      required this.source,
      required this.colNames,
      required this.onCellTap,
      this.columnWidthMode,
      this.allowSort = true});

  List<GridColumn> getCols() {
    return colNames
        .map<GridColumn>(
          (value) => GridColumn(
              columnName: value.name,
              visible: value.visible,
              label: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    value.name,
                    overflow: TextOverflow.visible,
                    softWrap: true,
                  )),
              allowSorting: value.sort),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: source,
      allowSorting: allowSort,
      columnWidthMode: columnWidthMode ?? ColumnWidthMode.fill,
      columns: getCols(),
      onCellTap: onCellTap,
    );
  }
}
