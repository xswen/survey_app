import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart';

void main() async {
  // Load the Excel file
  var bytes = File('path_to_your_excel_file.xlsx').readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);

  var enData = {};
  var frData = {};

  for (var table in excel.tables.keys) {
    for (var row in excel.tables[table]!.rows) {
      var key = row[0]?.value; // Key_value column
      var enTitle = row[1]?.value; // En_title column
      var frTitle = row[2]?.value; // Fr_title column

      if (key != null && enTitle != null) {
        enData[key] = enTitle;
      }

      if (key != null && frTitle != null) {
        frData[key] = frTitle;
      }
    }
  }

  // Convert data to JSON and write to files
  var enJson = jsonEncode(enData);
  var frJson = jsonEncode(frData);

  File('en-CA.json').writeAsStringSync(enJson);
  File('fr-CA.json').writeAsStringSync(frJson);

  print('JSON files generated successfully.');
}
