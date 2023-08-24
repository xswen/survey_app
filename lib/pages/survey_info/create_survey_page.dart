import 'dart:math';

import 'package:drift/drift.dart' as d;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/widgets/data_input/data_input.dart';

import '../../constants/margins_padding.dart';
import '../../database/database.dart';
import '../../global.dart';
import '../../l10n/locale_keys.g.dart';
import '../../routes/route_names.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/date_select.dart';
import '../../widgets/dropdowns/drop_down_async_list.dart';
import '../../widgets/popups/popups.dart';

class CreateSurvey extends StatefulWidget {
  CreateSurvey({super.key, required this.surveyHeader});
  SurveyHeadersCompanion surveyHeader;

  @override
  State<CreateSurvey> createState() => _CreateSurveyState();
}

class _CreateSurveyState extends State<CreateSurvey> with Global {
  final _controller = TextEditingController();
  static const int _kDataMissing = -1;
  String? provinceName;
  int? lastMeasNum;
  bool jurisdictionSelected = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Scaffold build(BuildContext context) {
    final db = Provider.of<Database>(context);

    return Scaffold(
      appBar: OurAppBar(
        LocaleKeys.createSurveyTitle,
        onLocaleChange: () => setState(() {}),
      ),
      body: Column(
        children: [
          CalendarSelect(
              date: widget.surveyHeader.measDate.value,
              label: LocaleKeys.enterMeasDate,
              setStateFn: (DateTime date) => setState(() =>
                  widget.surveyHeader =
                      widget.surveyHeader.copyWith(measDate: d.Value(date)))),
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

                      if (widget.surveyHeader.province ==
                              const d.Value.absent() ||
                          code != widget.surveyHeader.province.value) {
                        widget.surveyHeader = widget.surveyHeader.copyWith(
                            province: d.Value(code),
                            nfiPlot: const d.Value(_kDataMissing),
                            measNum: const d.Value(_kDataMissing));
                        provinceName = s;
                        if (context.mounted) _controller.text = "";
                        setState(() {});
                      }
                    },
                    selectedItem: provinceName ??
                        LocaleKeys.pleaseSelectJurisdiction.tr(),
                    asyncItems: (s) => db.referenceTablesDao
                        .getJurisdictionNames(context.locale)),
                DropDownAsyncList(
                  title: LocaleKeys.plotNum,
                  onBeforePopup: (String? s) async {
                    if (Global.dbCompanionValueToStr(
                            widget.surveyHeader.province)
                        .isEmpty) {
                      Popups.showDismiss(context,
                          LocaleKeys.pleaseSelectAJurisdictionFirst.tr());
                      return false;
                    } else {
                      return true;
                    }
                  },
                  onChangedFn: (s) => setState(() {
                    _handlePlot(db, s);
                    setState(() {});
                  }),
                  selectedItem:
                      Global.dbCompanionValueToStr(widget.surveyHeader.nfiPlot)
                                  .isEmpty ||
                              widget.surveyHeader.nfiPlot.value == -1
                          ? LocaleKeys.pleaseSelectPlot.tr()
                          : Global.dbCompanionValueToStr(
                              widget.surveyHeader.nfiPlot),
                  asyncItems: (s) => _getPlotNums(db),
                ),
                DataInput(
                    title: LocaleKeys.measurementNum.tr(),
                    inputType: const TextInputType.numberWithOptions(),
                    inputFormatters: [LengthLimitingTextInputFormatter(3)],
                    startingStr:
                        widget.surveyHeader.measNum.value == _kDataMissing
                            ? ""
                            : Global.dbCompanionValueToStr(
                                widget.surveyHeader.measNum),
                    readOnly: Global.dbCompanionValueToStr(
                            widget.surveyHeader.nfiPlot)
                        .isEmpty,
                    onTap: () => Global.dbCompanionValueToStr(
                                widget.surveyHeader.nfiPlot)
                            .isEmpty
                        ? Popups.showDismiss(
                            context, "Please select a plot number first")
                        : null,
                    controller: mounted ? _controller : null,
                    onSubmit: (String s) {
                      int.tryParse(s) != null
                          ? setState(() => widget.surveyHeader = widget
                              .surveyHeader
                              .copyWith(measNum: d.Value(int.parse(s))))
                          : setState(() => widget.surveyHeader = widget
                              .surveyHeader
                              .copyWith(measNum: const d.Value(_kDataMissing)));
                    },
                    errorMsg: _handleMeasNumError(
                        widget.surveyHeader.measNum.value.toString())),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: kPaddingV * 2),
            child: ElevatedButton(
              onPressed: () async {
                String? result = _checkSurveyHeader();

                if (result == null) {
                  bool exists = await db.surveyInfoTablesDao
                      .checkSurveyExists(widget.surveyHeader);
                  exists
                      ? result =
                          "A survey for NFI Plot #${widget.surveyHeader.nfiPlot.value} "
                              "with measurement number ${widget.surveyHeader.measNum.value} "
                              "already exists."
                      : null;
                }

                if (result != null) {
                  if (context.mounted) {
                    Popups.showDismiss(context, "Error", contentText: result);
                  }
                } else if (lastMeasNum != null &&
                    lastMeasNum! >= widget.surveyHeader.measNum.value) {
                  if (context.mounted) {
                    Popups.showContinue(
                      context,
                      "Warning: Last Measurement Number Mismatch",
                      "You are trying to input a measurement value of ${widget.surveyHeader.measNum.value} "
                          "when the last measurement value on file is $lastMeasNum. "
                          "\n Would you like to proceed?",
                      rightBtnOnPressed: () async {
                        int id = await _insertSurvey(db);
                        if (context.mounted) {
                          context.goNamed(Routes.dashboard,
                              extra: await db.surveyInfoTablesDao.allSurveys);
                        }
                      },
                    );
                  }
                } else {
                  debugPrint(
                      "Survey being created for ${widget.surveyHeader.toString()}");
                  int id = await _insertSurvey(db);
                  if (context.mounted) {
                    context.goNamed(Routes.dashboard,
                        extra: await db.surveyInfoTablesDao.allSurveys);
                  }
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

  Future<int> _insertSurvey(Database db) async {
    int id = await db.into(db.surveyHeaders).insert(widget.surveyHeader);
    var val = await db.referenceTablesDao.updatePlot(PlotsCompanion(
        nfiPlot: widget.surveyHeader.nfiPlot,
        code: widget.surveyHeader.province,
        lastMeasNum:
            d.Value(max(widget.surveyHeader.measNum.value, lastMeasNum!))));
    return id;
  }

  void _handlePlot(Database db, String? plot) async {
    if (plot == null) {
      return;
    }
    widget.surveyHeader =
        widget.surveyHeader.copyWith(nfiPlot: d.Value(int.parse(plot)));
    lastMeasNum =
        await db.referenceTablesDao.getLastMeasNum(int.parse(plot!)) ??
            _kDataMissing;
    widget.surveyHeader =
        widget.surveyHeader.copyWith(measNum: const d.Value(_kDataMissing));
    _controller.text = "";
    setState(() {});
  }

  Future<List<String>> _getPlotNums(Database db) async {
    if (widget.surveyHeader.province == const d.Value.absent()) {
      return [""];
    }

    final List<int> nums = await db.referenceTablesDao
        .getPlotNums(widget.surveyHeader.province.value);

    return nums.map((e) => e.toString()).toList();
  }

  //Error handlers
  String? _checkSurveyHeader() {
    String result = "";
    if (widget.surveyHeader.province == const d.Value.absent() ||
        widget.surveyHeader.province.value.isEmpty) {
      result += "Missing Jurisdiction Info";
    }
    if (widget.surveyHeader.nfiPlot == const d.Value.absent() ||
        widget.surveyHeader.nfiPlot.value == _kDataMissing) {
      result += "\n Missing Plot Number";
    }
    if (widget.surveyHeader.measNum == const d.Value.absent() ||
        widget.surveyHeader.measNum.value == _kDataMissing) {
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
