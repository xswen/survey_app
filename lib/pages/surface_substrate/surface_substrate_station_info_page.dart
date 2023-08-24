import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../database/database.dart';
import '../../formatters/thousands_formatter.dart';
import '../../global.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_default.dart';
import '../../widgets/popups/popup_content_format.dart';
import '../../widgets/popups/popup_dismiss_dep.dart';

class SurfaceSubstrateStationInfoPage extends StatefulWidget {
  const SurfaceSubstrateStationInfoPage({Key? key}) : super(key: key);

  @override
  State<SurfaceSubstrateStationInfoPage> createState() =>
      _SurfaceSubstrateStationInfoPageState();
}

class _SurfaceSubstrateStationInfoPageState
    extends State<SurfaceSubstrateStationInfoPage> with Global {
  final _db = Get.find<Database>();
  static const List<String> _substrateTypes = [
    "Decayed Wood",
    "Organic",
    "Bedrock",
    "Buried Wood"
  ];
  static const Set<String> _substrateTypesDepth = {"Organic", "Buried Wood"};
  static const List<String> _depthMeasuredTo = ["Mineral Soil", "Sound Wood"];
  late bool moreInfo;
  SurfaceSubstrateTallyCompanion station = Get.arguments;

  @override
  void initState() {
    moreInfo = _substrateTypesDepth
        .contains(Global.dbCompanionValueToStr(station.substrateType));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar(
          "Surface Substrate Survey Station #${Global.dbCompanionValueToStr(station.stationNum)}"),
      body: Column(
        children: [
          DropDownDefault(
            title: 'Substrate Type',
            onChangedFn: (s) {
              if (Global.dbCompanionValueToStr(station.substrateType).isEmpty ||
                  s != Global.dbCompanionValueToStr(station.substrateType)) {
                setState(() {
                  moreInfo = _substrateTypesDepth.contains(s);
                  moreInfo
                      ? station = station.copyWith(
                          substrateType: d.Value(s!),
                          depth: const d.Value.absent(),
                          depthLimit: const d.Value.absent())
                      : station = station.copyWith(
                          substrateType: d.Value(s!),
                          depth: const d.Value(null),
                          depthLimit: const d.Value(null));
                });
              }
            },
            itemsList: _substrateTypes,
            selectedItem: Global.dbCompanionValueToStr(station.substrateType),
          ),
          Visibility(
              visible: moreInfo,
              child: Column(
                children: [
                  DataInput(
                      title: "Substrate Depth",
                      boxLabel: "Report to the nearest 1m",
                      prefixIcon: FontAwesomeIcons.ruler,
                      suffixVal: "m",
                      inputType:
                          const TextInputType.numberWithOptions(decimal: false),
                      startingStr: Global.dbCompanionValueToStr(station.depth),
                      errorMsg: _errorSubstrateDepth(
                          Global.dbCompanionValueToStr(station.depth)),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3),
                        ThousandsFormatter(allowFraction: false),
                      ],
                      onSubmit: (String s) {
                        int? val = int.tryParse(s);
                        val != null
                            ? station = station.copyWith(depth: d.Value(val))
                            : null;
                        setState(() {});
                      }),
                  DropDownDefault(
                    title: 'Substrate Depth Measured To',
                    onChangedFn: (s) {
                      if (Global.dbCompanionValueToStr(station.depthLimit)
                              .isEmpty ||
                          s !=
                              Global.dbCompanionValueToStr(
                                  station.depthLimit)) {
                        setState(() {
                          station = station.copyWith(depthLimit: d.Value(s!));
                        });
                      }
                    },
                    itemsList: _depthMeasuredTo,
                    //TODO: Double check this
                    selectedItem:
                        Global.dbCompanionValueToStr(station.depthLimit),
                  ),
                ],
              )),
          const Text("Holder for field notes"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    SurfaceSubstrateTallyCompanion? newStation =
                        await _createStation();
                    if (newStation != null) {
                      setState(() {
                        station = newStation;
                        moreInfo = false;
                      });
                    }
                  },
                  child: const Text("Save and Add New Station")),
              ElevatedButton(
                  onPressed: () async {
                    if ((await _createStation()) != null) {
                      Get.back();
                    }
                  },
                  child: const Text("Save and Return")),
            ],
          )
        ],
      ),
    );
  }

  Future<SurfaceSubstrateTallyCompanion?> _createStation() async {
    String? result = _errorCheck();

    if (result == null) {
      _db.surfaceSubstrateTablesDao.addOrUpdateSsTally(station);
      int nextStationNum = await _db.surfaceSubstrateTablesDao
          .getNextStationNum(station.ssDataId.value);
      return SurfaceSubstrateTallyCompanion(
          ssDataId: station.ssDataId, stationNum: d.Value(nextStationNum));
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

  String? _errorCheck() {
    String result = "";
    if (station.substrateType == const d.Value.absent()) {
      result += "Missing substrate type \n";
    }
    if (moreInfo && station.depth == const d.Value.absent()) {
      result += "Missing station depth \n";
    }
    if (moreInfo && station.depthLimit == const d.Value.absent()) {
      result += "Missing depth measured to";
    }

    return result.isEmpty ? null : result;
  }

  String? _errorSubstrateDepth(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    }
    if (0 > int.parse(text) || int.parse(text) > 999) {
      return "Input out of range. Must be between 0 to 360 inclusive";
    }

    return null;
  }
}
