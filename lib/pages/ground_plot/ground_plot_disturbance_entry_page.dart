import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/formatters/no_comma_formatter.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_disturbance_page.dart';
import 'package:survey_app/providers/ground_plot_providers.dart';
import 'package:survey_app/widgets/checkbox/hide_info_checkbox.dart';
import 'package:survey_app/widgets/data_input/data_input.dart';

import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/reference_name_select_builder.dart';
import '../../widgets/buttons/save_entry_button.dart';
import '../../widgets/popups/popup_errors_found_list.dart';
import '../delete_page.dart';

class GroundPlotDisturbanceEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotDisturbanceEntry";
  final GoRouterState state;

  const GroundPlotDisturbanceEntryPage(this.state, {super.key});

  @override
  GroundPlotDisturbanceEntryPageState createState() =>
      GroundPlotDisturbanceEntryPageState();
}

class GroundPlotDisturbanceEntryPageState
    extends ConsumerState<GroundPlotDisturbanceEntryPage> {
  final String title = "Natural Disturbance Entry";
  late final int summaryId;
  late GpDisturbanceCompanion entry;

  @override
  void initState() {
    summaryId = PathParamValue.getGpSummaryId(widget.state);
    entry = widget.state.extra as GpDisturbanceCompanion;

    super.initState();
  }

  List<String>? _errorCheck() {
    Database db = ref.read(databaseProvider);
    List<String> results = [];

    if (entry.distAgent == const d.Value.absent()) {
      results.add("Disturbance Agent");
    }
    if (_errorDistYr(db.companionValueToStr(entry.distYr)) != null) {
      results.add("Disturbance Year");
    }
    if (_errorDistPct(db.companionValueToStr(entry.distPct)) != null) {
      results.add("Disturbance Percent");
    }
    if (_errorMortPct(db.companionValueToStr(entry.mortPct)) != null) {
      results.add("Mortality Percent");
    }
    if (entry.mortBasis == const d.Value.absent()) {
      results.add("Mortality Basis");
    }

    if (_errorAgentType(db.companionValueToStr(entry.agentType)) != null) {
      results.add("Specific disturbance Agent");
    }

    return results.isNotEmpty ? results : null;
  }

  String? _errorDistYr(String? text) {
    final currentYear = DateTime.now().year;

    if (text == null || text.isEmpty) {
      return "Can't be empty";
    }

    if (text == "-1" || text == "-9") {
      return null;
    }

    if (text.length != 4) {
      return "Year format is invalid";
    }

    int yearInt = int.parse(text);

    if (yearInt <= 1900 || yearInt >= currentYear) {
      return "Year is out of range";
    }

    return null;
  }

  String? _errorDistPct(String? text) {
    if (text == null || text.isEmpty) {
      return "Can't be empty";
    }

    if (text != '-1' &&
        (int.tryParse(text) == null ||
            int.parse(text) < 0 ||
            int.parse(text) > 100)) {
      return "Percent out of range";
    }

    return null;
  }

  String? _errorMortPct(String? text) {
    if (text == null || text.isEmpty) {
      return "Can't be empty";
    }

    if (text != '-1' &&
        (int.tryParse(text) == null ||
            int.parse(text) < 0 ||
            int.parse(text) > 100)) {
      return "Percent out of range";
    }

    return null;
  }

  String? _errorAgentType(String? text) {
    if (text == null) {
      return "Can't be null";
    }

    if (text.length > 200) {
      return "Text limit has been reached. There is a character limit of 200.";
    }

    return null;
  }

  void updateEntry(GpDisturbanceCompanion newEntry) =>
      setState(() => entry = newEntry);

  void addOrUpdateGpDist(void Function() fn) => ref
      .read(databaseProvider)
      .siteInfoTablesDao
      .addorUpdateGpDisturbance(entry)
      .then((value) => fn());

  void returnToTablePage() {
    ref.refresh(gpDistDataListProvider(summaryId));
    context.goNamed(GroundPlotDisturbancePage.routeName,
        pathParameters: widget.state.pathParameters);
  }

  void createNewEntry() => context.pushReplacementNamed(
        GroundPlotDisturbanceEntryPage.routeName,
        pathParameters: widget.state.pathParameters,
        extra: GpDisturbanceCompanion(gpSummaryId: d.Value(summaryId)),
      );

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    return Scaffold(
      appBar: OurAppBar(
        "Natural Disturbance Entry",
        backFn: returnToTablePage,
      ),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
        child: ListView(
          children: [
            ReferenceNameSelectBuilder(
              title: "Natural disturbance agent",
              defaultSelectedValue: "Please select agent",
              name: db.referenceTablesDao
                  .getGpDistAgentName(db.companionValueToStr(entry.distAgent)),
              asyncListFn: db.referenceTablesDao.getGpDistAgentList,
              onChange: (s) =>
                  db.referenceTablesDao.getGpDistAgentCode(s).then((value) {
                updateEntry(entry.copyWith(distAgent: d.Value(value)));
                if (value == "NONE") {
                  updateEntry(entry.copyWith(
                    distYr: const d.Value(-9),
                    distPct: const d.Value(0),
                    mortPct: const d.Value(0),
                    mortBasis: const d.Value("NA"),
                    agentType: const d.Value(""),
                  ));
                }
              }),
              enabled: true,
            ),
            Visibility(
                visible: db.companionValueToStr(entry.distAgent) != "NONE",
                child: Column(
                  children: [
                    HideInfoCheckbox(
                      title: "Disturbance Year",
                      titleWidget: "Unreported",
                      checkValue: db.companionValueToStr(entry.distYr) == "-1",
                      onChange: (b) {
                        b!
                            ? updateEntry(
                                entry.copyWith(distYr: const d.Value(-1)))
                            : updateEntry(
                                entry.copyWith(distYr: const d.Value.absent()));
                      },
                      child: DataInput(
                        paddingGeneral: EdgeInsets.zero,
                        paddingTextbox: EdgeInsets.zero,
                        prefixIcon: FontAwesomeIcons.calendar,
                        suffixVal: "year",
                        inputType: const TextInputType.numberWithOptions(
                            decimal: false),
                        startingStr: db.companionValueToStr(entry.distYr),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                          ThousandsFormatter(
                              allowFraction: false, allowNegative: false),
                        ],
                        onSubmit: (s) {
                          int? val = int.tryParse(s);
                          if (val != null) {
                            setState(() =>
                                entry = entry.copyWith(distYr: d.Value(val)));
                          }
                        },
                        onValidate: _errorDistYr,
                      ),
                    ),
                    HideInfoCheckbox(
                      title: "Extent of disturbance",
                      titleWidget: "Unreported",
                      checkValue: db.companionValueToStr(entry.distPct) == "-1",
                      onChange: (b) {
                        b!
                            ? updateEntry(
                                entry.copyWith(distPct: const d.Value(-1)))
                            : updateEntry(entry.copyWith(
                                distPct: const d.Value.absent()));
                      },
                      child: DataInput(
                        paddingGeneral: EdgeInsets.zero,
                        paddingTextbox: EdgeInsets.zero,
                        prefixIcon: FontAwesomeIcons.houseCrack,
                        suffixVal: "%",
                        inputType: const TextInputType.numberWithOptions(
                            decimal: false),
                        startingStr: db.companionValueToStr(entry.distPct),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(3),
                          ThousandsFormatter(
                              allowFraction: false, allowNegative: false),
                        ],
                        onSubmit: (s) {
                          int? val = int.tryParse(s);
                          if (val != null) {
                            setState(() =>
                                entry = entry.copyWith(distPct: d.Value(val)));
                          }
                        },
                        onValidate: _errorDistPct,
                      ),
                    ),
                    HideInfoCheckbox(
                      title: "Extent of tree mortality",
                      titleWidget: "Unreported",
                      checkValue: db.companionValueToStr(entry.mortPct) == "-1",
                      onChange: (b) {
                        b!
                            ? updateEntry(
                                entry.copyWith(mortPct: const d.Value(-1)))
                            : updateEntry(entry.copyWith(
                                mortPct: const d.Value.absent()));
                      },
                      child: DataInput(
                        paddingGeneral: EdgeInsets.zero,
                        paddingTextbox: EdgeInsets.zero,
                        prefixIcon: FontAwesomeIcons.skull,
                        suffixVal: "%",
                        inputType: const TextInputType.numberWithOptions(
                            decimal: false),
                        startingStr: db.companionValueToStr(entry.mortPct),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(3),
                          ThousandsFormatter(
                              allowFraction: false, allowNegative: false),
                        ],
                        onSubmit: (s) {
                          int? val = int.tryParse(s);
                          if (val != null) {
                            setState(() =>
                                entry = entry.copyWith(mortPct: d.Value(val)));
                          }
                        },
                        onValidate: _errorMortPct,
                      ),
                    ),
                    ReferenceNameSelectBuilder(
                      title: "Basis for mortality extent",
                      defaultSelectedValue: "Please select extent",
                      name: db.referenceTablesDao.getGpDistMortalityBasisName(
                          db.companionValueToStr(entry.mortBasis)),
                      asyncListFn:
                          db.referenceTablesDao.getGpDistMortalityBasisList,
                      onChange: (s) => db.referenceTablesDao
                          .getGpDistMortalityBasisCode(s)
                          .then((value) {
                        updateEntry(entry.copyWith(mortBasis: d.Value(value)));
                      }),
                      enabled: true,
                    ),
                    DataInput(
                      title: "Specific disturbance agent",
                      prefixIcon: FontAwesomeIcons.noteSticky,
                      startingStr: db.companionValueToStr(entry.agentType),
                      inputFormatters: [
                        NoCommaInputFormatter(),
                      ],
                      onSubmit: (s) {
                        setState(() =>
                            entry = entry.copyWith(agentType: d.Value(s)));
                      },
                      onValidate: _errorAgentType,
                    ),
                  ],
                )),
            const SizedBox(
              height: kPaddingV * 2,
            ),
            const Text("Comment Box. To do"),
            const SizedBox(height: kPaddingV * 2),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kPaddingV * 2),
              child: SaveEntryButton(
                saveRetFn: () {
                  List<String>? errors = _errorCheck();
                  if (errors != null) {
                    Popups.show(context, PopupErrorsFoundList(errors: errors));
                  } else {
                    addOrUpdateGpDist(returnToTablePage);
                  }
                },
                saveAndAddFn: () {
                  List<String>? errors = _errorCheck();
                  if (errors != null) {
                    Popups.show(context, PopupErrorsFoundList(errors: errors));
                  } else {
                    addOrUpdateGpDist(createNewEntry);
                  }
                },
                delVisible: entry.id != const d.Value.absent(),
                deleteFn: () => Popups.show(
                  context,
                  PopupContinue("Warning: Deleting Piece",
                      contentText: "You are about to delete this piece. "
                          "Are you sure you want to continue?",
                      rightBtnOnPressed: () {
                    //close popup
                    context.pop();
                    context.pushNamed(DeletePage.routeName, extra: {
                      DeletePage.keyObjectName:
                          "Natural Disturbance Entry: $entry",
                      DeletePage.keyDeleteFn: () {
                        (db.delete(db.gpDisturbance)
                              ..where((tbl) => tbl.id.equals(entry.id.value)))
                            .go()
                            .then((value) => returnToTablePage());
                      },
                    });
                  }),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
