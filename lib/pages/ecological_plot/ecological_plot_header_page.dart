import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../constants/constant_values.dart';
import '../../constants/margins_padding.dart';
import '../../constants/text_designs.dart';
import '../../database/database.dart';
import '../../formatters/thousands_formatter.dart';
import '../../global.dart';
import '../../routes/route_names.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/popups/popup_content_format.dart';
import '../../widgets/popups/popup_dismiss.dart';
import '../../widgets/tables/table_creation_builder.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';

class _ColNames {
  static String id = kColHeaderMapKeyId;
  static String layerId = "Layer Id";
  static String genus = "Genus";
  static String species = "Species";
  static String variety = "Variety";
  static String speciesPct = "Species %";
  static String comments = "Comments";
  static String edit = kColHeaderMapKeyEdit;

  static List<Map<String, Object>> colHeadersList = [
    {kColHeaderMapKeyName: layerId, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: genus, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: species, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: variety, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: speciesPct, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: comments, kColHeaderMapKeySort: true},
    {kColHeaderMapKeyName: edit, kColHeaderMapKeySort: false},
  ];
}

class EcologicalPlotHeaderPage extends StatefulWidget {
  const EcologicalPlotHeaderPage({Key? key}) : super(key: key);

  @override
  State<EcologicalPlotHeaderPage> createState() =>
      _EcologicalPlotHeaderPageState();
}

class _EcologicalPlotHeaderPageState extends State<EcologicalPlotHeaderPage>
    with Global {
  final _db = Get.find<Database>();
  bool summaryComplete = Get.arguments["summaryComplete"];

  EcpHeaderCompanion ecpH = Get.arguments["ecpH"];

  late DataGridSourceBuilder largePieceDataSource =
      DataGridSourceBuilder(dataGridRows: []);

  late String _layers;

  final PopupDismiss _completeWarningPopup =
      Global.generateCompleteErrorPopup("Plot");

  final PopupDismiss _prevPageCompleteWarning =
      Global.generatePreviousMarkedCompleteErrorPopup("Ecological Plot");

  @override
  void initState() {
    _getLayers();
    updateSpecies();
    super.initState();
  }

  List<DataGridRow> generateDataGridRows(
      {required List<EcpSpeciesData> speciesList}) {
    return speciesList
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: _ColNames.id, value: dataGridRow.id),
              DataGridCell<String>(
                  columnName: _ColNames.layerId, value: dataGridRow.layerId),
              DataGridCell<String>(
                  columnName: _ColNames.genus, value: dataGridRow.genus),
              DataGridCell<String>(
                  columnName: _ColNames.species, value: dataGridRow.species),
              DataGridCell<String>(
                  columnName: _ColNames.variety, value: dataGridRow.variety),
              DataGridCell<double>(
                  columnName: _ColNames.speciesPct,
                  value: dataGridRow.speciesPct),
              DataGridCell<String>(
                  columnName: _ColNames.comments, value: "To be added"),
              DataGridCell<String?>(columnName: _ColNames.edit, value: null),
            ]))
        .toList();
  }

  void updateSpecies() {
    _db.ecologicalPlotTablesDao
        .getSpeciesList(ecpH.id.value)
        .then((value) => setState(() {
              largePieceDataSource = DataGridSourceBuilder(
                  dataGridRows: generateDataGridRows(speciesList: value));
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar(
          "Ecological Plot #${Global.dbCompanionValueToStr(ecpH.ecpNum)}"),
      floatingActionButton: FloatingCompleteButton(
        title: "Ecological Plot",
        complete: ecpH.complete.value,
        onPressed: () {
          if (summaryComplete) {
            Get.dialog(_prevPageCompleteWarning);
          } else {
            String? errorMsg = _errorCheck();
            if (ecpH.complete.value || errorMsg == null) {
              ecpH = ecpH.copyWith(complete: d.Value(!ecpH.complete.value));
              _updateEcpHeader(ecpH);
              setState(() {});
            } else {
              Get.dialog(PopupDismiss(
                title: "Error were found in the following places",
                contentWidget: PopupContentFormat(
                  titles: const [""],
                  details: [errorMsg],
                ),
              ));
            }
          }
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
          child: Column(
            children: <Widget>[
              DataInput(
                readOnly: ecpH.complete.value,
                title: "The nominal area of the ecological Sample Plot",
                boxLabel: "Report to Dec 5.4 in hectares",
                prefixIcon: FontAwesomeIcons.ruler,
                suffixVal: "ha",
                inputType: const TextInputType.numberWithOptions(decimal: true),
                startingStr: Global.dbCompanionValueToStr(ecpH.nomPlotSize),
                errorMsg: _errorNomPlotSize(
                    Global.dbCompanionValueToStr(ecpH.nomPlotSize)),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(8),
                  ThousandsFormatter(allowFraction: true, decimalPlaces: 6),
                ],
                onTap: () {
                  if (summaryComplete) {
                    Get.dialog(_prevPageCompleteWarning);
                  } else if (ecpH.complete.value) {
                    Get.dialog(_completeWarningPopup);
                  }
                },
                onSubmit: (String s) {
                  double.tryParse(s) != null
                      ? ecpH =
                          ecpH.copyWith(nomPlotSize: d.Value(double.parse(s)))
                      : ecpH =
                          ecpH.copyWith(nomPlotSize: const d.Value.absent());
                  _errorNomPlotSize(s) == null && double.tryParse(s) != null
                      ? _updateEcpHeader(EcpHeaderCompanion(
                          nomPlotSize: d.Value(double.parse(s))))
                      : null;
                  setState(() {});
                },
              ),
              DataInput(
                  readOnly: ecpH.complete.value,
                  title: "The measured area of the ecological sample plot",
                  boxLabel: "Report to Dec 5.4 in hectares",
                  prefixIcon: FontAwesomeIcons.ruler,
                  suffixVal: "ha",
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  startingStr: Global.dbCompanionValueToStr(ecpH.measPlotSize),
                  errorMsg: _errorMeasPlotSize(
                      Global.dbCompanionValueToStr(ecpH.measPlotSize)),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(8),
                    ThousandsFormatter(allowFraction: true, decimalPlaces: 6),
                  ],
                  onTap: () {
                    if (summaryComplete) {
                      Get.dialog(_prevPageCompleteWarning);
                    } else if (ecpH.complete.value) {
                      Get.dialog(_completeWarningPopup);
                    }
                  },
                  onSubmit: (String s) {
                    double.tryParse(s) != null
                        ? ecpH = ecpH.copyWith(
                            measPlotSize: d.Value(double.parse(s)))
                        : ecpH =
                            ecpH.copyWith(measPlotSize: const d.Value.absent());
                    _errorMeasPlotSize(s) == null && double.tryParse(s) != null
                        ? _updateEcpHeader(EcpHeaderCompanion(
                            measPlotSize: d.Value(double.parse(s))))
                        : null;
                    setState(() {});
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Layers",
                    style: kTitleStyle,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (summaryComplete) {
                          Get.dialog(_prevPageCompleteWarning);
                        } else if (ecpH.complete.value) {
                          Get.dialog(_completeWarningPopup);
                        } else {
                          EcpSpeciesCompanion ecpSpecies = EcpSpeciesCompanion(
                              ecpHeaderId: ecpH.id,
                              speciesNum: d.Value(await _db
                                  .ecologicalPlotTablesDao
                                  .getNextSpeciesNum(ecpH.id.value)));
                          var temp = await Get.toNamed(
                              Routes.ecologicalPlotSpecies,
                              arguments: {
                                "ecpSpecies": ecpSpecies,
                              });
                          updateSpecies();
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: ecpH.complete.value
                              ? MaterialStateProperty.all<Color>(Colors.grey)
                              : null),
                      child: const Text("Add Layer")),
                ],
              ),
              Row(
                children: [Text(_layers)],
              ),
              Expanded(
                child: TableCreationBuilder(
                  source: largePieceDataSource,
                  colNames: _ColNames.colHeadersList,
                  onCellTap: (DataGridCellTapDetails details) async {
                    // Assuming the "edit" column index is 2
                    if (details.column.columnName == _ColNames.edit &&
                        details.rowColumnIndex.rowIndex != 0) {
                      if (ecpH.complete.value) {
                        Get.dialog(_completeWarningPopup);
                      } else {
                        int pId = largePieceDataSource
                            .dataGridRows[details.rowColumnIndex.rowIndex - 1]
                            .getCells()[0]
                            .value;

                        var temp = await Get.toNamed(
                            Routes.ecologicalPlotSpecies,
                            arguments: {
                              "ecpSpecies": (await _db.ecologicalPlotTablesDao
                                      .getSpeciesFromId(pId))
                                  .toCompanion(true),
                              "firstEntry": true
                            });
                        updateSpecies();
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //TODO: Add ability to show which layer types currently exist
  void _getLayers() {
    String tmp = "";
    _db.ecologicalPlotTablesDao
        .getLayers(ecpH.id.value)
        .then((value) => setState(() => tmp = value.toString()));
    _layers = tmp;
  }

  Future<void> _updateEcpHeader(EcpHeaderCompanion entry) async {
    (_db.update(_db.ecpHeader)..where((t) => t.id.equals(ecpH.id.value)))
        .write(entry);
  }

  //Error checks
  String? _errorCheck() {
    String result = "";
    _errorMeasPlotSize(Global.dbCompanionValueToStr(ecpH.measPlotSize)) != null
        ? result += "Measured Area of Plot \n"
        : null;
    _errorNomPlotSize(Global.dbCompanionValueToStr(ecpH.nomPlotSize)) != null
        ? result += "Nominal Area of Plot \n"
        : null;

    return result.isEmpty ? null : result;
  }

  //Todo: Check requirements
  String? _errorMeasPlotSize(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (0.000025 > double.parse(text) || double.parse(text) > 1.0) {
      return "Input out of range. Must be between 0.000025 to 1.0 inclusive.";
    }
    return null;
  }

  String? _errorNomPlotSize(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (0.000025 > double.parse(text) || double.parse(text) > 1.0) {
      return "Input out of range. Must be between 0.000025 to 1.0 inclusive.";
    }
    return null;
  }
}
