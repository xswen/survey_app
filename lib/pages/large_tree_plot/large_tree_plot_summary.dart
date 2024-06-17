import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_site_tree_info_age_list_page.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_tree_info_list_page.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_tree_removed_list_page.dart';
import 'package:survey_app/providers/large_tree_plot_providers.dart';
import 'package:survey_app/widgets/builders/reference_name_select_builder.dart';
import 'package:survey_app/widgets/checkbox/hide_info_checkbox.dart';
import 'package:survey_app/widgets/disable_widget.dart';
import 'package:survey_app/widgets/popups/popup_errors_found_list.dart';

import '../../formatters/thousands_formatter.dart';
import '../../providers/survey_info_providers.dart';
import '../../widgets/buttons/icon_nav_button.dart';
import '../../widgets/buttons/mark_complete_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/date_select.dart';

class LargeTreePlotSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "largeTreePlotSummary";
  final GoRouterState state;

  const LargeTreePlotSummaryPage(this.state, {super.key});

  @override
  LargeTreePlotSummaryPageState createState() =>
      LargeTreePlotSummaryPageState();
}

class LargeTreePlotSummaryPageState
    extends ConsumerState<LargeTreePlotSummaryPage> {
  final String title = "Large Tree Plot";
  late final PopupDismiss completeWarningPopup;
  final PopupDismiss surveyCompleteWarningPopup =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  late bool parentComplete = false;

  late final int surveyId;
  late final int ltpId;

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    ltpId = PathParamValue.getLtpSummaryId(widget.state);

    completeWarningPopup = Popups.generateCompleteErrorPopup(title);

    _loadData();

    super.initState();
  }

  void _loadData() async {
    final survey =
        await Database.instance.surveyInfoTablesDao.getSurvey(surveyId);

    if (mounted) {
      setState(() {
        parentComplete = survey.complete;
      });
    }
  }

  void updateSummary(LtpSummaryCompanion entry) {
    final db = ref.read(databaseProvider);
    (db.update(db.ltpSummary)..where((t) => t.id.equals(ltpId)))
        .write(entry)
        .then((value) => ref.refresh(ltpDataProvider(ltpId)));
  }

  List<String>? errorCheck(LtpSummaryData data) {
    final db = ref.read(databaseProvider);
    List<String> results = [];

    data.plotType ?? results.add("Plot number");

    _errorNom(data.nomPlotSize?.toString()) != null
        ? results.add("Nominal Area of Plot")
        : null;
    _errorMeas(data.measPlotSize?.toString()) != null
        ? results.add("Measured Area of Plot")
        : null;

    return results.isEmpty ? null : results;
  }

  String? _errorNom(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (value == "-1.0") {
      return null;
    } else if (double.parse(value) < 0.03 || double.parse(value) > 0.1) {
      return "Dbh must be between 0.03 and 0.1ha";
    }
    return null;
  }

  String? _errorMeas(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (double.parse(value) < 0.0075 || double.parse(value) > 0.1000) {
      return "Dbh must be between 0.0075 and 0.1000ha";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    AsyncValue<LtpSummaryData> ltpData = ref.watch(ltpDataProvider(ltpId));

    return ltpData.when(
        error: (err, stack) => Text("Error: $err"),
        loading: () => DefaultPageLoadingScaffold(title: title),
        data: (ltpSummary) {
          void markComplete() {
            if (parentComplete) {
              Popups.show(context, surveyCompleteWarningPopup);
              return;
            }

            if (ltpSummary.complete) {
              updateSummary(
                  const LtpSummaryCompanion(complete: d.Value(false)));
            } else {
              List<String>? results = errorCheck(ltpSummary);

              results == null
                  ? updateSummary(
                      const LtpSummaryCompanion(complete: d.Value(true)))
                  : Popups.show(context, PopupErrorsFoundList(errors: results));
            }
          }

          return Scaffold(
            appBar: OurAppBar(
              "Large Tree Plot",
              backFn: () {
                ref.refresh(updateSurveyCardProvider(surveyId));
                context.pop();
              },
            ),
            bottomNavigationBar: MarkCompleteButton(
                title: "Large Tree Plot",
                complete: ltpSummary.complete,
                onPressed: () {
                  markComplete();
                }),
            endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
                child: ListView(
                  children: [
                    CalendarSelect(
                      date: ltpSummary.measDate,
                      label: "Enter Measurement Date",
                      readOnly: ltpSummary.complete,
                      onDateSelected: (DateTime date) async => updateSummary(
                        LtpSummaryCompanion(measDate: d.Value(date)),
                      ),
                    ),
                    ReferenceNameSelectBuilder(
                      name: db.referenceTablesDao
                          .getLtpPlotTypeName(ltpSummary.plotType ?? ""),
                      asyncListFn: db.referenceTablesDao.getLtpPlotTypeList,
                      enabled: !ltpSummary.complete,
                      onChange: (s) => db.referenceTablesDao
                          .getLtpPlotTypeCode(s)
                          .then(
                            (value) => updateSummary(
                                LtpSummaryCompanion(plotType: d.Value(value))),
                          ),
                    ),
                    DisableWidget(
                      disabled: ltpSummary.complete,
                      child: HideInfoCheckbox(
                        checkValue: ltpSummary.nomPlotSize == -1,
                        title: "Nominal plot size",
                        titleWidget: "Missing",
                        onChange: (onChange) {
                          onChange == true
                              ? updateSummary(const LtpSummaryCompanion(
                                  nomPlotSize: d.Value(-1)))
                              : updateSummary(const LtpSummaryCompanion(
                                  nomPlotSize: d.Value(null)));
                        },
                        child: DataInput(
                          boxLabel: "Report to the nearest 0.0001 ha",
                          prefixIcon: FontAwesomeIcons.rulerCombined,
                          suffixVal: "ha",
                          inputType: const TextInputType.numberWithOptions(
                              decimal: true),
                          startingStr: ltpSummary.nomPlotSize?.toString() ?? "",
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                            ThousandsFormatter(
                                allowFraction: true,
                                decimalPlaces: 6,
                                maxDigitsBeforeDecimal: 1),
                          ],
                          paddingGeneral: const EdgeInsets.only(top: 0),
                          onSubmit: (s) {
                            s.isEmpty
                                ? updateSummary(const LtpSummaryCompanion(
                                    nomPlotSize: d.Value(null)))
                                : _errorNom(s) == null
                                    ? updateSummary(LtpSummaryCompanion(
                                        nomPlotSize: d.Value(double.parse(s))))
                                    : updateSummary(const LtpSummaryCompanion(
                                        nomPlotSize: d.Value(null)));
                          },
                          onValidate: _errorNom,
                        ),
                      ),
                    ),
                    DisableWidget(
                      disabled: ltpSummary.complete,
                      child: DataInput(
                        title: "Measured plot Size",
                        boxLabel: "Report to the nearest 0.0001ha",
                        prefixIcon: FontAwesomeIcons.chartArea,
                        suffixVal: "ha",
                        inputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        startingStr: ltpSummary.measPlotSize?.toString() ?? "",
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(6),
                          ThousandsFormatter(
                              allowFraction: true,
                              decimalPlaces: 6,
                              maxDigitsBeforeDecimal: 1),
                        ],
                        onSubmit: (s) {
                          s.isEmpty
                              ? updateSummary(const LtpSummaryCompanion(
                                  measPlotSize: d.Value(null)))
                              : _errorNom(s) == null
                                  ? updateSummary(LtpSummaryCompanion(
                                      measPlotSize: d.Value(double.parse(s))))
                                  : updateSummary(const LtpSummaryCompanion(
                                      measPlotSize: d.Value(null)));
                        },
                        onValidate: _errorMeas,
                      ),
                    ),
                    const SizedBox(height: kPaddingV),
                    IconNavButton(
                      icon: const Icon(FontAwesomeIcons.tree),
                      space: kPaddingIcon,
                      label: "Tree Information",
                      onPressed: () {
                        context.pushNamed(
                            LargeTreePlotTreeInfoListPage.routeName,
                            pathParameters: PathParamGenerator.ltpInfoList(
                                widget.state, ltpId.toString()));
                      },
                      padding: const EdgeInsets.symmetric(vertical: kPaddingV),
                    ),
                    IconNavButton(
                      icon: const Icon(FontAwesomeIcons.xmark),
                      space: kPaddingIcon,
                      label: "Removed Trees",
                      onPressed: () {
                        context.pushNamed(
                            LargeTreePlotTreeRemovedListPage.routeName,
                            pathParameters: PathParamGenerator.ltpRemovedList(
                                widget.state, ltpId.toString()));
                      },
                      padding: const EdgeInsets.symmetric(vertical: kPaddingV),
                    ),
                    IconNavButton(
                      icon: const Icon(FontAwesomeIcons.info),
                      space: kPaddingIcon,
                      label: "Site Tree and Age Information",
                      onPressed: () {
                        context.pushNamed(
                            LargeTreePlotSiteTreeInfoAgeListPage.routeName,
                            pathParameters: PathParamGenerator.ltpInfoAgeList(
                                widget.state, ltpId.toString()));
                      },
                      padding: const EdgeInsets.symmetric(vertical: kPaddingV),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
