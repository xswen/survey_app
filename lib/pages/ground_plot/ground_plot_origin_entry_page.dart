import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/ground_plot/ground_plot_origin_page.dart';
import 'package:survey_app/providers/ground_plot_providers.dart';
import 'package:survey_app/widgets/data_input/data_input.dart';

import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/reference_name_select_builder.dart';
import '../../widgets/buttons/save_entry_button.dart';
import '../../widgets/checkbox/hide_info_checkbox.dart';
import '../../widgets/popups/popup_errors_found_list.dart';
import '../delete_page.dart';

class GroundPlotOriginEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotOriginEntry";
  final GoRouterState state;

  const GroundPlotOriginEntryPage(this.state, {super.key});

  @override
  GroundPlotOriginEntryPageState createState() =>
      GroundPlotOriginEntryPageState();
}

class GroundPlotOriginEntryPageState
    extends ConsumerState<GroundPlotOriginEntryPage> {
  final String title = "Tree Cover Origin Entry";
  late final int summaryId;
  late GpOriginCompanion entry;

  @override
  void initState() {
    summaryId = PathParamValue.getGpSummaryId(widget.state);
    entry = widget.state.extra as GpOriginCompanion;

    super.initState();
  }

  List<String>? _errorCheck() {
    Database db = ref.read(databaseProvider);
    List<String> results = [];

    if (entry.vegOrig == const d.Value.absent()) {
      results.add("Vegetation Cover Origin");
    }
    if (entry.regenType == const d.Value.absent()) {
      results.add("Type of Regeneration");
    }
    if (_errorRegenYr(db.companionValueToStr(entry.regenYr)) != null) {
      results.add("Regeneration year Year");
    }

    return results.isNotEmpty ? results : null;
  }

  String? _errorRegenYr(String? text) {
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

  void updateEntry(GpOriginCompanion newEntry) =>
      setState(() => entry = newEntry);

  void addOrUpdateGpDist(void Function() fn) => ref
      .read(databaseProvider)
      .siteInfoTablesDao
      .addOrUpdateGpOrigin(entry)
      .then((value) => fn());

  void returnToTablePage() {
    ref.refresh(gpOriginListProvider(summaryId));
    context.goNamed(GroundPlotOriginPage.routeName,
        pathParameters: widget.state.pathParameters);
  }

  void createNewEntry() => context.pushReplacementNamed(
        GroundPlotOriginEntryPage.routeName,
        pathParameters: widget.state.pathParameters,
        extra: GpOriginCompanion(gpSummaryId: d.Value(summaryId)),
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
              title: "Vegetation cover origin",
              defaultSelectedValue: "Please select cover",
              name: db.referenceTablesDao.getGpOriginVegCoverName(
                  db.companionValueToStr(entry.vegOrig)),
              asyncListFn: db.referenceTablesDao.getGpOriginVegCoverList,
              onChange: (s) => db.referenceTablesDao
                  .getGpOriginVegCoverCode(s)
                  .then((value) {
                updateEntry(entry.copyWith(vegOrig: d.Value(value)));
              }),
              enabled: true,
            ),
            ReferenceNameSelectBuilder(
              title: "Type of regeneration",
              defaultSelectedValue: "Please select type",
              name: db.referenceTablesDao.getGpOriginRegenTypeName(
                  db.companionValueToStr(entry.regenType)),
              asyncListFn: db.referenceTablesDao.getGpOriginRegenTypeList,
              onChange: (s) => db.referenceTablesDao
                  .getGpOriginRegenTypeCode(s)
                  .then((value) {
                updateEntry(entry.copyWith(regenType: d.Value(value)));
              }),
              enabled: true,
            ),
            HideInfoCheckbox(
              title: "Regeneration Year",
              titleWidget: "Unreported",
              checkValue: db.companionValueToStr(entry.regenYr) == "-1",
              onChange: (b) {
                b!
                    ? updateEntry(entry.copyWith(regenYr: const d.Value(-1)))
                    : updateEntry(
                        entry.copyWith(regenYr: const d.Value.absent()));
              },
              child: DataInput(
                paddingGeneral: EdgeInsets.zero,
                paddingTextbox: EdgeInsets.zero,
                prefixIcon: FontAwesomeIcons.calendar,
                suffixVal: "year",
                inputType:
                    const TextInputType.numberWithOptions(decimal: false),
                startingStr: db.companionValueToStr(entry.regenYr),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                  ThousandsFormatter(
                      allowFraction: false, allowNegative: false),
                ],
                onSubmit: (s) {
                  int? val = int.tryParse(s);
                  if (val != null) {
                    setState(
                        () => entry = entry.copyWith(regenYr: d.Value(val)));
                  }
                },
                onValidate: _errorRegenYr,
              ),
            ),
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
                          "Tree Cover Origin Entry: $entry",
                      DeletePage.keyDeleteFn: () {
                        (db.delete(db.gpOrigin)
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
