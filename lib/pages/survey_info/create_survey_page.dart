import 'dart:math';

import 'package:drift/drift.dart' as d;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_app/providers/providers.dart';
import 'package:survey_app/routes/path_parameters/path_param_generator.dart';
import 'package:survey_app/widgets/data_input/dep_data_input.dart';
import 'package:survey_app/widgets/drawer_menu.dart';
import 'package:survey_app/widgets/popups/popup_continue.dart';
import 'package:survey_app/widgets/popups/popup_dismiss.dart';

import '../../constants/margins_padding.dart';
import '../../database/database.dart';
import '../../formatters/thousands_formatter.dart';
import '../../global.dart';
import '../../l10n/locale_keys.g.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/date_select.dart';
import '../../widgets/dropdowns/drop_down_async_list.dart';
import '../../widgets/popups/popups.dart';
import 'survey_info_page.dart';

class CreateSurveyPage extends ConsumerStatefulWidget {
  static const String routeName = "createSurvey";
  static const String keySurvey = "survey";
  static const String keyUpdateDash = "updateDash";
  static const String keyLastMeasNum = "lastMeasNum";
  static const String keyProvinceName = "province";

  const CreateSurveyPage(
      {super.key,
      required this.surveyHeader,
      required this.province,
      required this.updateDashboard,
      this.lastMeasNum});
  final SurveyHeadersCompanion surveyHeader;
  final int? lastMeasNum;
  final String province;
  final void Function()? updateDashboard;

  @override
  CreateSurveyPageState createState() => CreateSurveyPageState();
}

class CreateSurveyPageState extends ConsumerState<CreateSurveyPage>
    with Global {
  final _controller = TextEditingController();
  static const int _kDataMissing = -1;
  late SurveyHeadersCompanion surveyHeader;
  late String provinceName;
  int? lastMeasNum;
  bool jurisdictionSelected = false;

  @override
  void initState() {
    provinceName = widget.province;
    surveyHeader = widget.surveyHeader;
    lastMeasNum = widget.lastMeasNum;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Scaffold build(BuildContext context) {
    final db = ref.read(databaseProvider);

    return Scaffold(
      appBar: OurAppBar(db.companionValueToStr(surveyHeader.province).isEmpty
          ? LocaleKeys.createSurveyTitle
          : "Edit Survey"),
      endDrawer: DrawerMenu(
        onLocaleChange: () {
          if (db.companionValueToStr(surveyHeader.province).isNotEmpty) {
            db.referenceTablesDao
                .getJurisdictionName(
                    surveyHeader.province.value, context.locale)
                .then((value) => setState(() {
                      provinceName = value;
                    }));
          }
        },
      ),
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
                      if (s == provinceName) return;

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
                        if (context.mounted) _controller.text = "";
                        setState(() {});
                      }
                    },
                    selectedItem:
                        db.companionValueToStr(surveyHeader.province).isEmpty
                            ? LocaleKeys.pleaseSelectJurisdiction.tr()
                            : provinceName,
                    asyncItems: (s) => db.referenceTablesDao
                        .getJurisdictionNames(context.locale)),
                DropDownAsyncList(
                  title: LocaleKeys.plotNum,
                  searchable: true,
                  onBeforePopup: (String? s) async {
                    if (db.companionValueToStr(surveyHeader.province).isEmpty) {
                      Popups.show(
                          context,
                          PopupDismiss(
                              LocaleKeys.pleaseSelectAJurisdictionFirst.tr()));
                      return false;
                    } else {
                      return true;
                    }
                  },
                  onChangedFn: (s) => setState(() {
                    _handlePlot(db, s);
                    setState(() {});
                  }),
                  selectedItem: db
                              .companionValueToStr(surveyHeader.province)
                              .isNotEmpty &&
                          (db
                                  .companionValueToStr(surveyHeader.nfiPlot)
                                  .isEmpty ||
                              surveyHeader.nfiPlot.value == -1)
                      ? LocaleKeys.pleaseSelectPlot.tr()
                      : db.companionValueToStr(surveyHeader.nfiPlot),
                  asyncItems: (s) => _getPlotNums(db),
                ),
                DepDataInput(
                  title: LocaleKeys.measurementNum.tr(),
                  controller: _controller,
                  startingStr: surveyHeader.measNum.value == _kDataMissing
                      ? ""
                      : db.companionValueToStr(surveyHeader.measNum),
                  onSubmit: (String s) {
                    int.tryParse(s) != null
                        ? setState(() => surveyHeader = surveyHeader.copyWith(
                            measNum: d.Value(int.parse(s))))
                        : setState(() => surveyHeader = surveyHeader.copyWith(
                            measNum: const d.Value(_kDataMissing)));
                  },
                  errorMsg: _handleMeasNumError(
                      surveyHeader.measNum.value.toString()),
                  inputType: const TextInputType.numberWithOptions(),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                    ThousandsFormatter()
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: kPaddingV * 2),
            child: ElevatedButton(
              onPressed: () async {
                String? result = _checkSurveyHeader();

                if (result == null) {
                  int? existingSurveyId = await db.surveyInfoTablesDao
                      .checkSurveyExists(surveyHeader);

                  //if survey is the same with no changes then exit
                  if (db.companionValueToStr(surveyHeader.id) ==
                      existingSurveyId.toString()) {
                    var tmp = await db
                        .into(db.surveyHeaders)
                        .insertOnConflictUpdate(surveyHeader);
                    if (context.mounted) {
                      context.pop();
                    }
                    return;
                  }
                  existingSurveyId == null
                      ? null
                      : result =
                          "A survey for NFI Plot #${surveyHeader.nfiPlot.value} "
                              "with measurement number ${surveyHeader.measNum.value} "
                              "already exists.";
                }

                if (result != null) {
                  if (context.mounted) {
                    Popups.show(
                        context, PopupDismiss("Error", contentText: result));
                  }
                } else if (lastMeasNum != null &&
                    lastMeasNum! >= surveyHeader.measNum.value) {
                  if (context.mounted) {
                    Popups.show(
                        context,
                        PopupContinue(
                          "Warning: Last Measurement Number Mismatch",
                          contentText:
                              "You are trying to input a measurement value of ${surveyHeader.measNum.value} "
                              "when the last measurement value on file is $lastMeasNum. "
                              "\n Would you like to proceed?",
                          rightBtnOnPressed: () async {
                            _goToSurvey(context, db);
                          },
                        ));
                  }
                } else {
                  debugPrint(
                      "Survey being created for ${surveyHeader.toString()}");
                  if (context.mounted) _goToSurvey(context, db);
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

  Future<void> _goToSurvey(BuildContext context, Database db) async {
    _insertOrUpdateSurvey(db).then((id) async => widget.updateDashboard == null
        ? context.pop()
        : context.goNamed(
            SurveyInfoPage.routeName,
            pathParameters: PathParamGenerator.surveyInfo(
                (await db.surveyInfoTablesDao.getSurvey(id)).id.toString()),
          ));
  }

  Future<int> _insertOrUpdateSurvey(Database db) async {
    //Remove the last recorded meas number if this entry was the lastMeasNum
    //if widget.updateDashboard == null then that means that this is an edit
    // and not a new one
    if (widget.updateDashboard == null &&
        widget.lastMeasNum == widget.surveyHeader.measNum.value) {
      var tmp = db.referenceTablesDao.updatePlot(PlotsCompanion(
          nfiPlot: widget.surveyHeader.nfiPlot,
          code: widget.surveyHeader.province,
          lastMeasNum: d.Value(await db.surveyInfoTablesDao
              .getSecondLargestMeasNum(surveyHeader.nfiPlot.value))));
    }

    int id =
        await db.into(db.surveyHeaders).insertOnConflictUpdate(surveyHeader);
    var val = await db.referenceTablesDao.updatePlot(PlotsCompanion(
        nfiPlot: surveyHeader.nfiPlot,
        code: surveyHeader.province,
        lastMeasNum:
            d.Value(max(surveyHeader.measNum.value, lastMeasNum ?? -1))));
    return id;
  }

  void _handlePlot(Database db, String? plot) async {
    if (plot == null) {
      return;
    }
    surveyHeader = surveyHeader.copyWith(nfiPlot: d.Value(int.parse(plot)));
    lastMeasNum = await db.referenceTablesDao.getLastMeasNum(int.parse(plot));
    surveyHeader = surveyHeader.copyWith(measNum: const d.Value(_kDataMissing));
    _controller.text = "";
    setState(() {});
  }

  Future<List<String>> _getPlotNums(Database db) async {
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
    if (surveyHeader.province == const d.Value.absent() ||
        surveyHeader.province.value.isEmpty) {
      result += "Missing Jurisdiction Info";
    }
    if (surveyHeader.nfiPlot == const d.Value.absent() ||
        surveyHeader.nfiPlot.value == _kDataMissing) {
      result += "\n Missing Plot Number";
    }
    if (surveyHeader.measNum == const d.Value.absent() ||
        surveyHeader.measNum.value == _kDataMissing) {
      result += "\n Missing Measurement Number";
    }

    return result.isNotEmpty ? result : null;
  }

  String? _handleMeasNumError(String? text) {
    if (text == null) {
      return null;
    }
    if (lastMeasNum == null) {
      return "Please choose plot number first";
    } else if (text.isEmpty || text == _kDataMissing.toString()) {
      return "Cannot be empty";
    }
    return null;
  }
}
