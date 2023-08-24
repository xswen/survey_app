import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../formatters/thousands_formatter.dart';
import '../../database/database.dart';
import '../../global.dart';
import '../../routes/route_names.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_default.dart';
import '../../widgets/popups/popup_content_format.dart';
import '../../widgets/popups/popup_continue.dart';
import '../../widgets/popups/popup_dismiss_dep.dart';

class EcologicalPlotSpeciesPage extends StatefulWidget {
  const EcologicalPlotSpeciesPage({Key? key}) : super(key: key);

  @override
  State<EcologicalPlotSpeciesPage> createState() =>
      _EcologicalPlotSpeciesPageState();
}

class _EcologicalPlotSpeciesPageState extends State<EcologicalPlotSpeciesPage>
    with Global {
  final _db = Get.find<Database>();

  //DOESN'T NEED TO BE DISPOSED. Will be done by DataInput class
  late final TextEditingController percentInputController;

  EcpSpeciesCompanion _ecpSpecies = Get.arguments["ecpSpecies"];

  static const List<String> _layerId = [
    "A: Tree Layer",
    "B1: Tall Shrub",
    "B2: Short Shrub",
    "C: Herb Layer",
    "D: Byroid Layer"
  ];
  static const List<String> _genus = [
    "Decayed Wood",
    "Organic",
    "Bedrock",
    "Buried Wood"
  ];

  @override
  void initState() {
    super.initState();
    percentInputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar("ECP Species",
          backFn: () => Get.until(
              (route) => Get.currentRoute == Routes.ecologicalPlotHeader)),
      body: Column(
        children: [
          DropDownDefault(
            title: 'Layer Id',
            onChangedFn: (s) {
              if (Global.dbCompanionValueToStr(_ecpSpecies.layerId).isEmpty ||
                  s != Global.dbCompanionValueToStr(_ecpSpecies.layerId)) {
                setState(() {
                  _ecpSpecies = _ecpSpecies.copyWith(layerId: d.Value(s!));
                });
              }
            },
            itemsList: _layerId, //_substrateTypes,
            selectedItem: Global.dbCompanionValueToStr(_ecpSpecies.layerId),
          ),
          DropDownDefault(
            title: 'Genus',
            onChangedFn: (s) {
              if (Global.dbCompanionValueToStr(_ecpSpecies.genus).isEmpty ||
                  s != Global.dbCompanionValueToStr(_ecpSpecies.genus)) {
                setState(() {
                  _ecpSpecies = _ecpSpecies.copyWith(genus: d.Value(s!));
                });
              }
            },
            itemsList: _genus,
            selectedItem: Global.dbCompanionValueToStr(_ecpSpecies.genus),
          ),
          DropDownDefault(
            title: 'Species',
            onChangedFn: (s) {
              if (Global.dbCompanionValueToStr(_ecpSpecies.species).isEmpty ||
                  s != Global.dbCompanionValueToStr(_ecpSpecies.species)) {
                setState(() {
                  _ecpSpecies = _ecpSpecies.copyWith(species: d.Value(s!));
                });
              }
            },
            itemsList: ["tmp", "temp"],
            selectedItem: Global.dbCompanionValueToStr(_ecpSpecies.species),
          ),
          DropDownDefault(
            title: 'Variety',
            onChangedFn: (s) {
              s == "N/A"
                  ? _ecpSpecies =
                      _ecpSpecies.copyWith(variety: const d.Value(null))
                  : _ecpSpecies = _ecpSpecies.copyWith(variety: d.Value(s!));
            },
            itemsList: ["N/A", "Unknown"],
            selectedItem: Global.dbCompanionValueToStr(_ecpSpecies.variety),
          ),
          DataInput(
            controller: percentInputController,
            title: "Percent Coverage for each ecological species in the plot",
            boxLabel: "Report to the nearest 0.001\u00B0",
            prefixIcon: FontAwesomeIcons.angleLeft,
            suffixVal: "\u00B0",
            inputType: const TextInputType.numberWithOptions(decimal: false),
            errorMsg: _errorSpeciesPct(
                Global.dbCompanionValueToStr(_ecpSpecies.speciesPct)),
            inputFormatters: [
              LengthLimitingTextInputFormatter(6),
              ThousandsFormatter(allowFraction: true, decimalPlaces: 3),
            ],
            onSubmit: (String s) {
              double? val = double.tryParse(s);
              val != null
                  ? setState(() => _ecpSpecies =
                      _ecpSpecies.copyWith(speciesPct: d.Value(val)))
                  : null;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    EcpSpeciesCompanion? newStation = await _createStation();
                    List<EcpSpeciesData> test = await _db
                        .ecologicalPlotTablesDao
                        .getSpeciesList(_ecpSpecies.ecpHeaderId.value);
                    if (newStation != null) {
                      Map<String, dynamic> args = {
                        "ecpSpecies": newStation,
                        "firstEntry": false
                      };
                      setState(() {
                        percentInputController.clear();
                        _ecpSpecies = newStation;
                      });
                    }
                  },
                  child: const Text("Save and Add New Species")),
              ElevatedButton(
                  onPressed: () async {
                    EcpSpeciesCompanion? newStation = await _createStation();
                    List<EcpSpeciesData> test = await _db
                        .ecologicalPlotTablesDao
                        .getSpeciesList(_ecpSpecies.ecpHeaderId.value);
                    if (newStation != null) {
                      Get.until((route) =>
                          Get.currentRoute == Routes.ecologicalPlotHeader);
                    }
                  },
                  child: const Text("Save and Return")),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    Get.dialog(PopupContinue(
                        title: "Warning: Deletion",
                        content:
                            "You are about to delete a species. This cannot be undone. Are you sure you want to delete?",
                        rightBtnOnPressed: () {
                          if (Global.dbCompanionValueToStr(_ecpSpecies.id) !=
                              "") {
                            _db.ecologicalPlotTablesDao
                                .deleteSpecies(_ecpSpecies.id.value);
                          }
                          Get.until((route) =>
                              Get.currentRoute == Routes.ecologicalPlotHeader);
                        }));
                  },
                  child: const Text("Delete Species")),
            ],
          )
        ],
      ),
    );
  }

  String? _errorSpeciesPct(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    }
    if (0.001 > double.parse(text) || double.parse(text) > 100) {
      return "Input out of range. Must be between 0.001 to 100 inclusive";
    }
    return null;
  }

  String? _errorCheck() {
    String result = "";
    if (_ecpSpecies.layerId == const d.Value.absent()) {
      result += "Missing layer id\n";
    }
    if (_ecpSpecies.genus == const d.Value.absent()) {
      result += "Missing genus\n";
    }
    if (_ecpSpecies.species == const d.Value.absent()) {
      result += "Missing species\n";
    }
    if (_ecpSpecies.speciesPct == const d.Value.absent()) {
      result += "Missing species percentage\n";
    }
    return result.isEmpty ? null : result;
  }

  Future<EcpSpeciesCompanion?> _createStation() async {
    String? result = _errorCheck();

    if (result == null) {
      _db.ecologicalPlotTablesDao.addOrUpdateSpecies(_ecpSpecies);
      int nextSpeciesNum = await _db.ecologicalPlotTablesDao
          .getNextSpeciesNum(_ecpSpecies.ecpHeaderId.value);

      return EcpSpeciesCompanion(
          ecpHeaderId: _ecpSpecies.ecpHeaderId,
          speciesNum: d.Value(nextSpeciesNum));
    }
    Get.dialog(PopupDismissDep(
      title: "Error were found in the following places",
      contentWidget: PopupContentFormat(
        titles: const [""],
        details: [result],
      ),
    ));

    return null;
  }
}
