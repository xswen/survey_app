import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../constants/constant_values.dart';
import '../../constants/margins_padding.dart';
import '../../routes/route_names.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/tables/table_creation_builder.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../widgets/text/text_header_separator.dart';

class _ColNames {
  static String id = kColHeaderMapKeyId;
  static String horNum = "Horizon Number";
  static String type = "Type";
  static String horDes = "Horizon Designation";
  static String horUpperDepth = "Horizon Upper Depth";
  static String horThickness = "Horizon Thickness";
  static String soilColour = "Soil Colour";
  static String soilTexture = "Soil Texture";
  static String percentGravel = "Percent Gravel";
  static String percentCobbles = "Percent Cobbles";
  static String percentStones = "Percent Stones";
  static String edit = kColHeaderMapKeyEdit; // ALWAYS INCLUDE THIS LINE!

  static List<Map<String, Object>> colHeadersList = [
    {kColHeaderMapKeyName: horNum, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: type, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: horDes, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: horUpperDepth, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: horThickness, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: soilColour, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: soilTexture, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: percentGravel, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: percentCobbles, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: percentStones, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: edit, kColHeaderMapKeySort: false},
  ];

  static List<DataGridRow> generateDataGridRows(
      {required List<Map<String, dynamic>> tmpDepths}) {
    return tmpDepths
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: _ColNames.id, value: dataGridRow[_ColNames.id]),
              DataGridCell<String>(
                  columnName: _ColNames.horNum,
                  value: dataGridRow[_ColNames.horNum]),
              DataGridCell<String>(
                  columnName: _ColNames.type,
                  value: dataGridRow[_ColNames.type]),
              DataGridCell<String>(
                  columnName: _ColNames.horDes,
                  value: dataGridRow[_ColNames.horDes]),
              DataGridCell<String>(
                  columnName: _ColNames.horUpperDepth,
                  value: dataGridRow[_ColNames.horUpperDepth]),
              DataGridCell<String>(
                  columnName: _ColNames.horThickness,
                  value: dataGridRow[_ColNames.horThickness]),
              DataGridCell<String>(
                  columnName: _ColNames.soilColour,
                  value: dataGridRow[_ColNames.soilColour]),
              DataGridCell<String>(
                  columnName: _ColNames.soilTexture,
                  value: dataGridRow[_ColNames.soilTexture]),
              DataGridCell<String>(
                  columnName: _ColNames.percentGravel,
                  value: dataGridRow[_ColNames.percentGravel]),
              DataGridCell<String>(
                  columnName: _ColNames.percentCobbles,
                  value: dataGridRow[_ColNames.percentCobbles]),
              DataGridCell<String>(
                  columnName: _ColNames.percentStones,
                  value: dataGridRow[_ColNames.percentStones]),
              DataGridCell<String?>(columnName: _ColNames.edit, value: null),
            ]))
        .toList();
  }
}

List<Map<String, dynamic>> tempDepth = [
  {
    _ColNames.id: 1,
    _ColNames.horNum: "Horizon 1",
    _ColNames.type: "Mineral",
    _ColNames.horDes: "",
    _ColNames.horUpperDepth: "",
    _ColNames.horThickness: "",
    _ColNames.soilColour: "Brown",
    _ColNames.soilTexture: "Sandy",
    _ColNames.percentGravel: "20",
    _ColNames.percentCobbles: "5",
    _ColNames.percentStones: "10",
  },
  {
    _ColNames.id: 2,
    _ColNames.horNum: "Horizon 2",
    _ColNames.type: "Mineral",
    _ColNames.horDes: "",
    _ColNames.horUpperDepth: "",
    _ColNames.horThickness: "",
    _ColNames.soilColour: "Red",
    _ColNames.soilTexture: "Clay",
    _ColNames.percentGravel: "15",
    _ColNames.percentCobbles: "3",
    _ColNames.percentStones: "8",
  },
  {
    _ColNames.id: 3,
    _ColNames.horNum: "Horizon 3",
    _ColNames.type: "Mineral + Organic",
    _ColNames.horDes: "3",
    _ColNames.horUpperDepth: "20",
    _ColNames.horThickness: "10",
    _ColNames.soilColour: "",
    _ColNames.soilTexture: "",
    _ColNames.percentGravel: "",
    _ColNames.percentCobbles: "",
    _ColNames.percentStones: "",
  },
  {
    _ColNames.id: 4,
    _ColNames.horNum: "Horizon 4",
    _ColNames.type: "Mineral",
    _ColNames.horDes: "",
    _ColNames.horUpperDepth: "",
    _ColNames.horThickness: "",
    _ColNames.soilColour: "Yellow",
    _ColNames.soilTexture: "Silt",
    _ColNames.percentGravel: "5",
    _ColNames.percentCobbles: "1",
    _ColNames.percentStones: "2",
  },
];

class SoilPitAttributesPage extends StatefulWidget {
  const SoilPitAttributesPage({Key? key}) : super(key: key);

  @override
  State<SoilPitAttributesPage> createState() => _SoilPitAttributesPageState();
}

class _SoilPitAttributesPageState extends State<SoilPitAttributesPage> {
  DataGridSourceBuilder soilDepthSource = DataGridSourceBuilder(
      dataGridRows: _ColNames.generateDataGridRows(tmpDepths: tempDepth));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OurAppBar("Soil Pit Attributes"),
      floatingActionButton: FloatingCompleteButton(
        title: "",
        complete: false,
        onPressed: () {},
      ),
      body: Center(
        child: Column(
          children: [
            TextHeaderSeparator(
              title: "Soil Pit Attributes",
              sideWidget: Padding(
                padding: const EdgeInsets.only(left: kPaddingH),
                child: ElevatedButton(
                    onPressed: () async {
                      var tmp =
                          await Get.toNamed(Routes.soilPitAttributesInput);
                    },
                    style: ButtonStyle(
                        backgroundColor: false
                            ? MaterialStateProperty.all<Color>(Colors.grey)
                            : null),
                    child: const Text("Add Piece")),
              ),
            ),
            Expanded(
              child: TableCreationBuilder(
                source: soilDepthSource,
                colNames: _ColNames.colHeadersList,
                onCellTap: (DataGridCellDetails details) {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
