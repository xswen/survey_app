import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constants/margins_padding.dart';
import '../../constants/text_designs.dart';
import '../../database/database.dart';
import '../../formatters/thousands_formatter.dart';
import '../../global.dart';
import '../../routes/route_names.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/date_select.dart';
import '../../widgets/dropdowns/drop_down_async_list.dart';
import '../../widgets/popups/popup_dismiss.dart';

class SurveyInfoCreate extends StatefulWidget {
  const SurveyInfoCreate({Key? key}) : super(key: key);

  @override
  State<SurveyInfoCreate> createState() => _SurveyInfoCreateState();
}

class _SurveyInfoCreateState extends State<SurveyInfoCreate> with Global {
  final _controller = TextEditingController();
  static const int _DATAMISSING = -1;
  SurveyHeadersCompanion sh =
      SurveyHeadersCompanion(measDate: d.Value(DateTime.now()));
  String? provinceName;
  String? nfiPlot;
  String lastMeas = "";
  bool jurisdictionSelected = false;
  bool plotSelected = false;
  @override
  void initState() {
    _controller.text = Global.dbCompanionValueToStr(sh.measNum);
    super.initState();
  }

  // dispose it when the widget is unmounted
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: const OurAppBar("Create New Survey"),
      body: Column(
        children: [
          CalendarSelect(
              date: sh.measDate.value,
              label: "Enter Measurement Date",
              setStateFn: (DateTime date) =>
                  setState(() => sh = sh.copyWith(measDate: d.Value(date)))),
          Container(
            margin: const EdgeInsets.fromLTRB(
                kPaddingH, 0, kPaddingH, kPaddingV / 2),
            child: Column(
              children: [
                DropDownAsyncList(
                  title: "Jurisdiction",
                  onChangedFn: (s) => _handleJurisdiction(s),
                  selectedItem: provinceName ?? "Please select a jurisdiction",
                  asyncItems: (s) =>
                      Get.find<Database>().referenceTablesDao.jurisdictionNames,
                ),
                AbsorbPointer(
                  absorbing: !jurisdictionSelected,
                  child: DropDownAsyncList(
                    title: "Plot Number",
                    onChangedFn: (s) => setState(() {
                      _handlePlot(s);
                      setState(() {});
                    }),
                    selectedItem: nfiPlot ?? "",
                    asyncItems: (s) => _getPlotNums(),
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: _controller,
                    builder: (context, TextEditingValue value, __) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: kPaddingV * 2, bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Measurement Number",
                                style: kTitleStyle),
                            SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.only(top: kPaddingV),
                                child: TextField(
                                  controller: _controller,
                                  onChanged: (s) {
                                    setState(() {
                                      int.tryParse(s) != null
                                          ? sh = sh.copyWith(
                                              measNum: d.Value(int.parse(s)))
                                          : sh = sh.copyWith(
                                              measNum:
                                                  const d.Value(_DATAMISSING));
                                    });
                                  },
                                  readOnly: !plotSelected,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: false),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(3),
                                    ThousandsFormatter(
                                        allowFraction: true, decimalPlaces: 1),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: "",
                                    errorText: _handleMeasNumError(
                                        _controller.value.text, lastMeas),
                                    prefixIcon:
                                        const Icon(FontAwesomeIcons.ruler),
                                    suffixIconConstraints: const BoxConstraints(
                                        minWidth: 0, minHeight: 0),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 3, color: Colors.grey)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: kPaddingV * 2),
            child: ElevatedButton(
              onPressed: () async {
                String? result = _checkSurveyHeader();
                if (result != null) {
                  Get.dialog(PopupDismiss(
                      title: "Error",
                      contentText:
                          "Errors were found in the following places:\n $result"));
                } else {
                  final db = Get.find<Database>();
                  debugPrint(
                      "Survey being created for ${sh.nfiPlot.toString()}");
                  int id = await db.into(db.surveyHeaders).insert(sh);
                  Get.offNamed(Routes.surveyInfoPage,
                      arguments: (await db.surveyInfoTablesDao.getSurvey(id)));
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              child: const Text("Continue"),
            ),
          ),
        ],
      ),
    );
  }

  void _handleJurisdiction(String? jurisdiction) async {
    if (jurisdiction == null) {
      return;
    }

    String code = await Get.find<Database>()
        .referenceTablesDao
        .getJurisdictionCode(jurisdiction);
    jurisdictionSelected = true;
    if (sh.province == const d.Value.absent() || code != sh.province.value) {
      sh = sh.copyWith(
          province: d.Value(code),
          nfiPlot: const d.Value(_DATAMISSING),
          measNum: const d.Value(_DATAMISSING));
      provinceName = jurisdiction;
      nfiPlot = "Please select plot";
      lastMeas = "";
      _controller.text = "";
      plotSelected = false;
      setState(() {});
    }
  }

  void _handlePlot(String? plot) async {
    print(plot);
    if (plot == null) {
      return;
    }

    sh = sh.copyWith(nfiPlot: d.Value(int.parse(plot)));
    nfiPlot = plot;
    lastMeas = (await Get.find<Database>()
            .referenceTablesDao
            .getLastMeasDate(int.parse(nfiPlot!)))
        .toString();
    sh = sh.copyWith(measNum: const d.Value(_DATAMISSING));
    plotSelected = true;
    _controller.text = "";
  }

  Future<List<String>> _getPlotNums() async {
    final db = Get.find<Database>();

    if (sh.province == const d.Value.absent()) {
      return [""];
    }

    final List<int> nums =
        await db.referenceTablesDao.getPlotNums(sh.province.value);
    return nums.map((e) => e.toString()).toList();
  }

  //Error handlers
  String? _checkSurveyHeader() {
    String result = "";
    if (sh.province == d.Value.absent() || sh.province.value.isEmpty) {
      result += "Missing Jurisdiction Info";
    }
    if (sh.nfiPlot == d.Value.absent() || sh.nfiPlot.value == _DATAMISSING) {
      result += "\n Missing Plot Number";
    }
    if (sh.measNum == d.Value.absent() || sh.measNum.value == _DATAMISSING) {
      result += "\n Missing Plot Number";
    }

    return result.isNotEmpty ? result : null;
  }

  String? _handleMeasNumError(String text, String lastMeas) {
    if (lastMeas.isEmpty) {
      return "Please choose plot number first";
    }
    if (text.isEmpty) {
      return "Cannot be empty";
    }
    if (lastMeas == _DATAMISSING.toString()) {
      return null;
    }
    if (int.parse(text) < int.parse(lastMeas)) {
      return "Invalid meas number. Last recorded measurement number was $lastMeas";
    }
    return null;
  }
}
