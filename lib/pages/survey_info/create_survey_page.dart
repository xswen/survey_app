import 'package:drift/drift.dart' as d;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants/margins_padding.dart';
import '../../constants/text_designs.dart';
import '../../database/database.dart';
import '../../formatters/thousands_formatter.dart';
import '../../global.dart';
import '../../l10n/locale_keys.g.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/date_select.dart';
import '../../widgets/dropdowns/drop_down_async_list.dart';

class CreateSurvey extends StatefulWidget {
  const CreateSurvey({Key? key}) : super(key: key);

  @override
  State<CreateSurvey> createState() => _CreateSurveyState();
}

class _CreateSurveyState extends State<CreateSurvey> with Global {
  final _controller = TextEditingController();
  static const int _kDataMissing = -1;
  SurveyHeadersCompanion surveyHeader =
      SurveyHeadersCompanion(measDate: d.Value(DateTime.now()));
  String? provinceName;
  String? nfiPlot;
  String lastMeas = "";
  bool jurisdictionSelected = false;
  bool plotSelected = false;
  @override
  void initState() {
    _controller.text = Global.dbCompanionValueToStr(surveyHeader.measNum);
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
    final db = Provider.of<Database>(context);
    return Scaffold(
      appBar: const OurAppBar(LocaleKeys.createSurveyTitle),
      body: Column(
        children: [
          CalendarSelect(
              date: surveyHeader.measDate.value,
              label: LocaleKeys.enterMeasDate,
              setStateFn: (DateTime date) => setState(() => surveyHeader =
                  surveyHeader.copyWith(measDate: d.Value(date)))),
          Container(
            margin: const EdgeInsets.fromLTRB(
                kPaddingH, 0, kPaddingH, kPaddingV / 2),
            child: Column(
              children: [
                DropDownAsyncList(
                    searchable: true,
                    title: LocaleKeys.jurisdiction,
                    onChangedFn: (s) async {
                      if (s == null) {
                        return;
                      }

                      String code = await db.referenceTablesDao
                          .getJurisdictionCode(context.locale, s);
                      jurisdictionSelected = true;

                      if (surveyHeader.province == const d.Value.absent() ||
                          code != surveyHeader.province.value) {
                        surveyHeader = surveyHeader.copyWith(
                            province: d.Value(code),
                            nfiPlot: const d.Value(_kDataMissing),
                            measNum: const d.Value(_kDataMissing));
                        provinceName = s;
                        nfiPlot = LocaleKeys.pleaseSelectPlot;
                        lastMeas = "";
                        _controller.text = "";
                        plotSelected = false;
                        setState(() {});
                      }
                    },
                    selectedItem:
                        provinceName ?? "Please select a jurisdiction",
                    asyncItems: (s) => db.referenceTablesDao
                        .getJurisdictionNames(context.locale)),
                AbsorbPointer(
                  absorbing: !jurisdictionSelected,
                  child: DropDownAsyncList(
                    title: LocaleKeys.plotNum,
                    onChangedFn: (s) => setState(() {
                      _handlePlot(s);
                      setState(() {});
                    }),
                    selectedItem: tr(nfiPlot ?? ""),
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
                                          ? surveyHeader =
                                              surveyHeader.copyWith(
                                                  measNum:
                                                      d.Value(int.parse(s)))
                                          : surveyHeader =
                                              surveyHeader.copyWith(
                                                  measNum: const d.Value(
                                                      _kDataMissing));
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
                  // Get.dialog(PopupDismiss(
                  //     title: "Error",
                  //     contentText:
                  //         "Errors were found in the following places:\n $result"));
                } else {
                  // final db = Get.find<Database>();
                  // debugPrint(
                  //     "Survey being created for ${surveyHeader.nfiPlot.toString()}");
                  // int id = await db.into(db.surveyHeaders).insert(surveyHeader);
                  // Get.offNamed(Routes.surveyInfoPage,
                  //     arguments: (await db.surveyInfoTablesDao.getSurvey(id)));
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

  void _handlePlot(String? plot) async {
    print(plot);
    if (plot == null) {
      return;
    }

    surveyHeader = surveyHeader.copyWith(nfiPlot: d.Value(int.parse(plot)));
    nfiPlot = plot;
    lastMeas = (await Database()
            .referenceTablesDao
            .getLastMeasDate(int.parse(nfiPlot!)))
        .toString();
    surveyHeader = surveyHeader.copyWith(measNum: const d.Value(_kDataMissing));
    plotSelected = true;
    _controller.text = "";
  }

  Future<List<String>> _getPlotNums() async {
    final db = Database();

    if (surveyHeader.province == const d.Value.absent()) {
      return [""];
    }

    final List<int> nums =
        await db.referenceTablesDao.getPlotNums(surveyHeader.province.value);
    return nums.map((e) => e.toString()).toList();
  }

  //Error handlers
  String? _checkSurveyHeader() {
    String result = "";
    if (surveyHeader.province == d.Value.absent() ||
        surveyHeader.province.value.isEmpty) {
      result += "Missing Jurisdiction Info";
    }
    if (surveyHeader.nfiPlot == d.Value.absent() ||
        surveyHeader.nfiPlot.value == _kDataMissing) {
      result += "\n Missing Plot Number";
    }
    if (surveyHeader.measNum == d.Value.absent() ||
        surveyHeader.measNum.value == _kDataMissing) {
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
    if (lastMeas == _kDataMissing.toString()) {
      return null;
    }
    if (int.parse(text) < int.parse(lastMeas)) {
      return "Invalid meas number. Last recorded measurement number was $lastMeas";
    }
    return null;
  }
}
