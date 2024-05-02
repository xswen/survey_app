import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_site_tree_info_age_list_page.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_tree_info_list_page.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_tree_removed_list_page.dart';
import 'package:survey_app/widgets/builders/reference_name_select_builder.dart';

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
  late final int surveyId;
  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    super.initState();
  }

  String? _errorNom(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
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
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: OurAppBar(
        "Large Tree Plot",
        backFn: () {
          ref.refresh(updateSurveyCardProvider(surveyId));
          context.pop();
        },
      ),
      bottomNavigationBar: MarkCompleteButton(
          title: "Large Tree Plot", complete: false, onPressed: () {}),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
          child: ListView(
            children: [
              CalendarSelect(
                date: DateTime.now(),
                label: "Enter Measurement Date",
                readOnly: false,
                onDateSelected: (DateTime date) async => (),
              ),
              ReferenceNameSelectBuilder(
                name: db.referenceTablesDao.getLtpPlotTypeName(""),
                asyncListFn: db.referenceTablesDao.getLtpPlotTypeList,
                enabled: true,
                onChange: (s) => db.referenceTablesDao
                    .getLtpPlotTypeCode(s)
                    .then((value) => null),
              ),
              DataInput(
                title: "Nominal plot Size",
                boxLabel: "Report to the nearest 0.0001 ha",
                prefixIcon: FontAwesomeIcons.rulerCombined,
                suffixVal: "ha",
                inputType: const TextInputType.numberWithOptions(decimal: true),
                startingStr: "",
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                  ThousandsFormatter(
                      allowFraction: true,
                      decimalPlaces: 6,
                      maxDigitsBeforeDecimal: 1),
                ],
                paddingGeneral: const EdgeInsets.only(top: 0),
                onSubmit: (s) {},
                onValidate: _errorNom,
              ),
              DataInput(
                title: "Measured plot Size",
                boxLabel: "Report to the nearest 0.0001ha",
                prefixIcon: FontAwesomeIcons.chartArea,
                suffixVal: "ha",
                inputType: const TextInputType.numberWithOptions(decimal: true),
                startingStr: "",
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                  ThousandsFormatter(
                      allowFraction: true,
                      decimalPlaces: 6,
                      maxDigitsBeforeDecimal: 1),
                ],
                paddingGeneral: const EdgeInsets.only(top: 0),
                onSubmit: (s) {},
                onValidate: _errorMeas,
              ),
              ReferenceNameSelectBuilder(
                title: "Plot split",
                name: db.referenceTablesDao.getLtpPlotSplitName(""),
                asyncListFn: db.referenceTablesDao.getLtpPlotSplitList,
                enabled: true,
                onChange: (s) => db.referenceTablesDao
                    .getLtpPlotSplitCode(s)
                    .then((value) => null),
              ),
              const SizedBox(height: kPaddingV),
              IconNavButton(
                icon: const Icon(FontAwesomeIcons.tree),
                space: kPaddingIcon,
                label: "Tree Information",
                onPressed: () {
                  context.pushNamed(LargeTreePlotTreeInfoListPage.routeName,
                      pathParameters: widget.state.pathParameters);
                },
                padding: const EdgeInsets.symmetric(vertical: kPaddingV),
              ),
              IconNavButton(
                icon: const Icon(FontAwesomeIcons.xmark),
                space: kPaddingIcon,
                label: "Removed Trees",
                onPressed: () {
                  context.pushNamed(LargeTreePlotTreeRemovedListPage.routeName,
                      pathParameters: widget.state.pathParameters);
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
                      pathParameters: widget.state.pathParameters);
                },
                padding: const EdgeInsets.symmetric(vertical: kPaddingV),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
