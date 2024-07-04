import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_treatment_page.dart';
import 'package:survey_app/providers/ground_plot_providers.dart';
import 'package:survey_app/widgets/checkbox/hide_info_checkbox.dart';

import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/reference_name_select_builder.dart';
import '../../widgets/buttons/save_entry_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/popups/popup_errors_found_list.dart';
import '../delete_page.dart';

class GroundPlotTreatmentEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotTreatmentEntry";
  final GoRouterState state;

  const GroundPlotTreatmentEntryPage(this.state, {super.key});

  @override
  GroundPlotTreatmentEntryPageState createState() =>
      GroundPlotTreatmentEntryPageState();
}

class GroundPlotTreatmentEntryPageState
    extends ConsumerState<GroundPlotTreatmentEntryPage> {
  final String title = "Treatment Entry";
  late final int summaryId;
  late GpTreatmentCompanion entry;

  @override
  void initState() {
    summaryId = PathParamValue.getGpSummaryId(widget.state);
    entry = widget.state.extra as GpTreatmentCompanion;

    super.initState();
  }

  List<String>? _errorCheck() {
    Database db = ref.read(databaseProvider);
    List<String> results = [];

    if (entry.treatType == const d.Value.absent()) {
      results.add("Treatment type");
    }
    if (_errorTreatmentYr(db.companionValueToStr(entry.treatYr)) != null) {
      results.add("Treatment Year");
    }
    if (_errorTreatPct(db.companionValueToStr(entry.treatPct)) != null) {
      results.add("Disturbance Percent");
    }

    return results.isNotEmpty ? results : null;
  }

  String? _errorTreatmentYr(String? text) {
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

    if (yearInt <= 1800 || yearInt >= currentYear) {
      return "Year is out of range";
    }

    return null;
  }

  String? _errorTreatPct(String? text) {
    if (text == null || text.isEmpty) {
      return "Can't be empty";
    }

    if (text != '-1' &&
        text != "-9" &&
        (int.tryParse(text) == null ||
            int.parse(text) < 0 ||
            int.parse(text) > 100)) {
      return "Percent out of range";
    }

    return null;
  }

  void updateEntry(GpTreatmentCompanion newEntry) =>
      setState(() => entry = newEntry);

  void addOrUpdateGpDist(void Function() fn) => ref
      .read(databaseProvider)
      .siteInfoTablesDao
      .addOrUpdateGpTreatment(entry)
      .then((value) => fn());

  void returnToTablePage() {
    ref.refresh(gpTreatmentListProvider(summaryId));
    context.goNamed(GroundPlotTreatmentPage.routeName,
        pathParameters: widget.state.pathParameters);
  }

  void createNewEntry() => context.pushReplacementNamed(
        GroundPlotTreatmentEntryPage.routeName,
        pathParameters: widget.state.pathParameters,
        extra: GpTreatmentCompanion(gpSummaryId: d.Value(summaryId)),
      );

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: OurAppBar(
        title,
        backFn: returnToTablePage,
      ),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      bottomNavigationBar:
          ElevatedButton(child: const Text("Save"), onPressed: () {}),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
        child: ListView(
          children: [
            ReferenceNameSelectBuilder(
              title: "Treatment type",
              defaultSelectedValue: "Please select type",
              name: db.referenceTablesDao.getGpTreatmentTypeName(
                  db.companionValueToStr(entry.treatType)),
              asyncListFn: db.referenceTablesDao.getGpTreatmentTypeList,
              onChange: (s) =>
                  db.referenceTablesDao.getGpTreatmentTypeCode(s).then((value) {
                updateEntry(entry.copyWith(treatType: d.Value(value)));
                if (value == "NO") {
                  updateEntry(entry.copyWith(
                    treatYr: const d.Value(-9),
                    treatPct: const d.Value(-9),
                  ));
                }
              }),
              enabled: true,
            ),
            Visibility(
                visible: db.companionValueToStr(entry.treatType) != "NO",
                child: Column(
                  children: [
                    HideInfoCheckbox(
                      title: "Treatment Year",
                      titleWidget: "Unreported",
                      checkValue: db.companionValueToStr(entry.treatYr) == "-1",
                      onChange: (b) {
                        b!
                            ? updateEntry(
                                entry.copyWith(treatYr: const d.Value(-1)))
                            : updateEntry(entry.copyWith(
                                treatYr: const d.Value.absent()));
                      },
                      child: DataInput(
                        paddingGeneral: EdgeInsets.zero,
                        paddingTextbox: EdgeInsets.zero,
                        prefixIcon: FontAwesomeIcons.calendar,
                        suffixVal: "year",
                        inputType: const TextInputType.numberWithOptions(
                            decimal: false),
                        startingStr: db.companionValueToStr(entry.treatYr),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                          ThousandsFormatter(
                              allowFraction: false, allowNegative: false),
                        ],
                        onSubmit: (s) {
                          int? val = int.tryParse(s);
                          if (val != null) {
                            setState(() =>
                                entry = entry.copyWith(treatYr: d.Value(val)));
                          }
                        },
                        onValidate: _errorTreatmentYr,
                      ),
                    ),
                    HideInfoCheckbox(
                      title: "Treatment Extent",
                      titleWidget: "Unreported",
                      checkValue:
                          db.companionValueToStr(entry.treatPct) == "-1",
                      onChange: (b) {
                        b!
                            ? updateEntry(
                                entry.copyWith(treatPct: const d.Value(-1)))
                            : updateEntry(entry.copyWith(
                                treatPct: const d.Value.absent()));
                      },
                      child: DataInput(
                        paddingGeneral: EdgeInsets.zero,
                        paddingTextbox: EdgeInsets.zero,
                        prefixIcon: FontAwesomeIcons.tachographDigital,
                        suffixVal: "%",
                        inputType: const TextInputType.numberWithOptions(
                            decimal: false),
                        startingStr: db.companionValueToStr(entry.treatYr),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(3),
                          ThousandsFormatter(
                              allowFraction: false, allowNegative: false),
                        ],
                        onSubmit: (s) {
                          int? val = int.tryParse(s);
                          if (val != null) {
                            setState(() =>
                                entry = entry.copyWith(treatPct: d.Value(val)));
                          }
                        },
                        onValidate: _errorTreatPct,
                      ),
                    ),
                  ],
                )),
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
                        (db.delete(db.gpTreatment)
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
