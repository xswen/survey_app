import 'package:flutter/material.dart';

class FrozenHeaderDataTable extends StatelessWidget {
  const FrozenHeaderDataTable({
    super.key,
    required this.columnNames,
    required this.extraColumns,
    required this.listRows,
  });

  final List<String> columnNames;
  final List<String> extraColumns;
  final List<DataRow> listRows;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          DataTable(
            headingRowColor:
                WidgetStateColor.resolveWith((states) => Colors.blue),
            rows: const [],
            columns: _generateColNames(),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                rows: listRows,
                columns: _generateColNames(),
                headingRowHeight: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DataColumn> _generateColNames() {
    List<String> tmp = columnNames + extraColumns;
    return List.generate(
        tmp.length,
        (index) => DataColumn(
                label: Center(
              child: Text(
                tmp[index],
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )));
  }
}
