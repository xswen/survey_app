import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../constants/constant_values.dart';
import '../../constants/margins_padding.dart';
import '../../database/database.dart';
import '../../formatters/thousands_formatter.dart';
import '../../global.dart';
import '../../routes/route_names.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/buttons/icon_nav_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_default.dart';
import '../../widgets/tables/table_creation_builder.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../widgets/text/text_header_separator.dart';

class _ColNames {
  static String id = kColHeaderMapKeyId;
  static String pitCode = "Soil Pit Code";
  static String type = "Type";
  static String depth = "Depth to Soil Feature";
  static String comments = "Comments";
  static String edit = kColHeaderMapKeyEdit;

  static List<Map<String, Object>> colHeadersList = [
    {kColHeaderMapKeyName: pitCode, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: type, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: depth, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: comments, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: edit, kColHeaderMapKeySort: false},
  ];
}

List<Map<String, dynamic>> tmpDepths = [
  {
    _ColNames.id: 1,
    _ColNames.pitCode: "MP1",
    _ColNames.type: "organic",
    _ColNames.depth: "10"
  },
  {
    _ColNames.id: 2,
    _ColNames.pitCode: "MP2",
    _ColNames.type: "mineral",
    _ColNames.depth: "10"
  },
];

class SoilPitSummaryPage extends StatefulWidget {
  const SoilPitSummaryPage({Key? key}) : super(key: key);

  @override
  State<SoilPitSummaryPage> createState() => _SoilPitSummaryPageState();
}

class _SoilPitSummaryPageState extends State<SoilPitSummaryPage> with Global {
  final _db = Get.find<Database>();
  //bool summaryComplete = Get.arguments["summaryComplete"];

  late DataGridSourceBuilder soilDepthSource = DataGridSourceBuilder(
      dataGridRows: generateDataGridRows(tmpDepths: tmpDepths));

  List<DataGridRow> generateDataGridRows(
      {required List<Map<String, dynamic>> tmpDepths}) {
    return tmpDepths
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: _ColNames.id, value: dataGridRow[_ColNames.id]),
              DataGridCell<String>(
                  columnName: _ColNames.pitCode,
                  value: dataGridRow[_ColNames.pitCode]),
              DataGridCell<String>(
                  columnName: _ColNames.type,
                  value: dataGridRow[_ColNames.type]),
              DataGridCell<String>(
                  columnName: _ColNames.depth,
                  value: dataGridRow[_ColNames.depth]),
              DataGridCell<String>(
                  columnName: _ColNames.comments, value: "To be added"),
              DataGridCell<String?>(columnName: _ColNames.edit, value: null),
            ]))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OurAppBar("Soil Pit"),
      floatingActionButton: FloatingCompleteButton(
        title: "Soil Pit",
        complete: false,
        onPressed: () {},
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
          child: Column(
            children: [
              IconNavButton(
                  icon: const Icon(FontAwesomeIcons.info),
                  label: "Site Info",
                  onPressed: () {
                    Get.toNamed(Routes.soilPitSiteInfo);
                  }),
              IconNavButton(
                  icon: const Icon(FontAwesomeIcons.pencil),
                  label: "Soil Pit Attributes",
                  onPressed: () {
                    Get.toNamed(Routes.soilPitAttributes);
                  }),
              const SizedBox(
                height: kPaddingH,
              ),
              TextHeaderSeparator(
                title: "Soil Pit Depth",
                sideWidget: Padding(
                  padding: const EdgeInsets.only(left: kPaddingH),
                  child: ElevatedButton(
                      onPressed: () async {
                        Get.dialog(SimpleDialog(
                          title: const Text("Create New: "),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPaddingH),
                              child: DropDownDefault(
                                  title: "Soil Pit Code",
                                  onChangedFn: (String? s) {},
                                  itemsList: [],
                                  selectedItem: "Please select Soil Pit Code"),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPaddingH),
                              child: DropDownDefault(
                                  title: "Type",
                                  onChangedFn: (String? s) {},
                                  itemsList: ["Organic", "Mineral"],
                                  selectedItem: "Please select Soil Type"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: kPaddingH,
                                  left: kPaddingH,
                                  top: kPaddingV * 2),
                              child: DataInput(
                                title: "Depth to Soil Feature",
                                boxLabel: "Reported to the nearest 0.1cm",
                                prefixIcon: FontAwesomeIcons.ruler,
                                suffixVal: "cm",
                                inputType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                startingStr: "",
                                errorMsg: "",
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(5),
                                  ThousandsFormatter(
                                      allowFraction: true, decimalPlaces: 1)
                                ],
                                onSubmit: (String s) {},
                                generalPadding: const EdgeInsets.all(0),
                                textBoxPadding: const EdgeInsets.all(0),
                              ),
                            ),
                            SimpleDialogOption(
                              onPressed: () => Get.back(),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [Text("Cancel"), Text("Save")],
                              ),
                            ),
                          ],
                        ));
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
      ),
    );
  }
}
