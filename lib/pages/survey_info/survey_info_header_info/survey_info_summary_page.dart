import 'package:drift/drift.dart' as d;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/data_input/data_input.dart';
import 'package:survey_app/widgets/popups/popup_errors_found_list.dart';

import '../../../formatters/thousands_formatter.dart';
import '../../../providers/survey_info_providers.dart';
import '../../../widgets/buttons/mark_complete_button.dart';
import '../../../widgets/date_select.dart';
import '../../../widgets/popups/popup_marked_complete.dart';
import '../../../widgets/text/text_header_separator.dart';

class SurveyInfoSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "surveyInfoSummary";
  final GoRouterState state;
  const SurveyInfoSummaryPage(this.state, {super.key});

  @override
  SurveyInfoSummaryPageState createState() => SurveyInfoSummaryPageState();
}

class SurveyInfoSummaryPageState extends ConsumerState<SurveyInfoSummaryPage> {
  final String title = "Survey Info Summary";
  late final int surveyId;
  late final PopupDismiss completeWarningPopup;

  late bool parentComplete = false;
  late SurveySummaryCompanion summary = const SurveySummaryCompanion();
  late List<String> photosList = [];
  late SurveyHeaderTreeCompanion tree = const SurveyHeaderTreeCompanion();
  late SurveyHeaderEcologicalCompanion eco =
      const SurveyHeaderEcologicalCompanion();
  late SurveyHeaderSoilCompanion soil = const SurveyHeaderSoilCompanion();

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    completeWarningPopup = Popups.generateCompleteErrorPopup(title);

    _loadData();
    super.initState();
  }

  void _loadData() async {
    Database db = Database.instance;

    final s = await db.surveyInfoTablesDao.getSummaryFromSurveyId(surveyId);
    final photos =
        await db.surveyInfoTablesDao.getListGroundPlotPhoto(surveyId);
    final treeTmp =
        await db.surveyInfoTablesDao.getTreeDataFromSurveyId(surveyId);
    final ecoTmp =
        await db.surveyInfoTablesDao.getEcologicalDataFromSurveyId(surveyId);
    final soilTmp =
        await db.surveyInfoTablesDao.getSoilDataFromSurveyId(surveyId);
    final parComplete =
        (await db.surveyInfoTablesDao.getSurvey(surveyId)).complete;

    if (mounted) {
      // Only proceed if the widget is still in the tree
      setState(() {
        summary = s.toCompanion(true);
        photosList = photos;
        tree = treeTmp.toCompanion(true);
        eco = ecoTmp.toCompanion(true);
        soil = soilTmp.toCompanion(true);
        parentComplete = parComplete;
      });
    }
  }

  void markComplete() {
    if (summary.complete.value) {
      parentComplete
          ? Popups.show(context, completeWarningPopup)
          : updateSummary(summary.copyWith(complete: const d.Value(false)));
    } else {
      List<String> results = [];
      results.addAll(errorCheckSummary());
      results.addAll(errorCheckTreeData());
      results.addAll(errorCheckEcoData());
      results.addAll(errorCheckSoilData());

      if (results.isEmpty) {
        updateSummary(summary.copyWith(complete: const d.Value(true)));
        Popups.show(context, PopupMarkedComplete(title: title));
      } else {
        Popups.show(context, PopupErrorsFoundList(errors: results));
      }
    }
  }

  List<String> errorCheckSummary() {
    Database db = Database.instance;
    List<String> results = [];

    if (db.companionValueToStr(summary.referenceTree).isEmpty ||
        ((summary.referenceTree.value ?? -1) < 6)) {
      results.add("Reference Tree");
    }
    if (db.companionValueToStr(summary.numberPhotos).isEmpty ||
        ((summary.numberPhotos.value ?? -1) < photosList.length)) {
      results.add("Photos");
    }

    return results;
  }

  List<String> errorCheckTreeData() {
    Database db = Database.instance;
    List<String> results = [];

    if (db.companionValueToStr(tree.fieldResponsibility).isEmpty) {
      results.add("Tree Data: Field responsibility");
    }
    if (db.companionValueToStr(tree.fieldCheckBy).isEmpty) {
      results.add("Tree Data: Field check by");
    }
    if (db.companionValueToStr(tree.officeCheckBy).isEmpty) {
      results.add("Tree Data: Office check by");
    }

    return results;
  }

  List<String> errorCheckEcoData() {
    Database db = Database.instance;
    List<String> results = [];

    if (db.companionValueToStr(eco.fieldResponsibility).isEmpty) {
      results.add("Ecological Data: Field responsibility");
    }
    if (db.companionValueToStr(eco.fieldCheckBy).isEmpty) {
      results.add("Ecological Data: Field check by");
    }
    if (db.companionValueToStr(eco.officeCheckBy).isEmpty) {
      results.add("Ecological Data: Office check by");
    }

    return results;
  }

  List<String> errorCheckSoilData() {
    Database db = Database.instance;
    List<String> results = [];

    if (db.companionValueToStr(soil.fieldResponsibility).isEmpty) {
      results.add("Soil Data: Field responsibility");
    }
    if (db.companionValueToStr(soil.fieldCheckBy).isEmpty) {
      results.add("Soil Data: Field check by");
    }
    if (db.companionValueToStr(soil.officeCheckBy).isEmpty) {
      results.add("Soil Data: Office check by");
    }

    return results;
  }

  void updateSummary(SurveySummaryCompanion newVal) {
    Database db = Database.instance;
    (db.update(db.surveySummary)
          ..where((tbl) => tbl.id.equals(newVal.id.value)))
        .write(newVal)
        .then((value) => setState(() => summary = newVal));
  }

  void updateTree(SurveyHeaderTreeCompanion newVal) {
    Database db = Database.instance;
    (db.update(db.surveyHeaderTree)
          ..where((tbl) => tbl.id.equals(newVal.id.value)))
        .write(newVal)
        .then((value) => setState(() => tree = newVal));
  }

  void updateEco(SurveyHeaderEcologicalCompanion newVal) {
    Database db = Database.instance;
    (db.update(db.surveyHeaderEcological)
          ..where((tbl) => tbl.id.equals(newVal.id.value)))
        .write(newVal)
        .then((value) => setState(() => eco = newVal));
  }

  void updateSoil(SurveyHeaderSoilCompanion newVal) {
    Database db = Database.instance;
    (db.update(db.surveyHeaderSoil)
          ..where((tbl) => tbl.id.equals(newVal.id.value)))
        .write(newVal)
        .then((value) => setState(() => soil = newVal));
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");

    String title = "Survey Info Summary";

    return db.companionValueToStr(summary.id).isEmpty
        ? DefaultPageLoadingScaffold(title: title)
        : Scaffold(
            appBar: OurAppBar(
              "Survey Info Summary",
              complete: summary.complete.value,
              backFn: () {
                ref.refresh(updateSurveyCardProvider(surveyId));
                context.pop();
              },
            ),
            endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
            bottomNavigationBar: MarkCompleteButton(
                title: title,
                complete: summary.complete.value,
                onPressed: () => markComplete()),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    kPaddingH, 0, kPaddingH, kPaddingV / 2),
                child: ListView(
                  children: [
                    AbsorbPointer(
                      absorbing: summary.complete.value,
                      child: Column(
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: kPaddingV * 2),
                            child: Column(
                              children: [
                                TextHeaderSeparator(title: "Crew"),
                                Text("TO IMPLEMENT"),
                              ],
                            ),
                          ), //Crew
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kPaddingV * 2),
                            child: Column(
                              children: [
                                const TextHeaderSeparator(
                                    title: "Reference Tree"),
                                DataInput(
                                    boxLabel: "Sample Tag Number",
                                    prefixIcon: FontAwesomeIcons.tag,
                                    inputType:
                                        const TextInputType.numberWithOptions(
                                            decimal: false),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(6),
                                      ThousandsFormatter(allowFraction: false)
                                    ],
                                    startingStr: db.companionValueToStr(
                                        summary.referenceTree),
                                    onSubmit: (s) {
                                      if (s.isNotEmpty && s.length == 6) {
                                        int? refNum = int.tryParse(s);
                                        refNum == null
                                            ? debugPrint(
                                                "Invalid integer for photo value")
                                            : updateSummary(summary.copyWith(
                                                referenceTree:
                                                    d.Value(refNum)));
                                      }
                                    },
                                    onValidate: (s) {
                                      if (s == null || s.isEmpty) {
                                        return "Please enter a value";
                                      } else if (s.length < 6) {
                                        return "Please enter a 6 digit value";
                                      }
                                      return null;
                                    }),
                              ],
                            ),
                          ), //Reference Tree
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kPaddingV * 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextHeaderSeparator(title: "Photos"),
                                DataInput(
                                    title: "Number of photos",
                                    prefixIcon: FontAwesomeIcons.photoFilm,
                                    inputType:
                                        const TextInputType.numberWithOptions(
                                            decimal: false),
                                    inputFormatters: [
                                      ThousandsFormatter(allowFraction: false)
                                    ],
                                    startingStr: db.companionValueToStr(
                                        summary.numberPhotos),
                                    onSubmit: (s) {
                                      if (s.isNotEmpty) {
                                        int? numPhotos = int.tryParse(s);
                                        numPhotos == null
                                            ? debugPrint(
                                                "Invalid integer for photo value")
                                            : updateSummary(summary.copyWith(
                                                numberPhotos:
                                                    d.Value(numPhotos)));
                                      }
                                    },
                                    onValidate: (s) {
                                      if (s == null || s.isEmpty) {
                                        return "Can't be empty";
                                      } else if ((int.tryParse(s) ?? -1) <
                                          photosList.length) {
                                        return "Number of photos and noted photos taken mismatch";
                                      }
                                      return null;
                                    }),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: kPaddingV),
                                  child: Text(
                                    "Ground Photos",
                                    style: kTitleStyle,
                                  ),
                                ),
                                DropdownSearch<String>.multiSelection(
                                  popupProps:
                                      const PopupPropsMultiSelection.dialog(
                                    showSelectedItems: true,
                                    showSearchBox: true,
                                    // disabledItemFn: widget.disabledItemFn,
                                    searchDelay: Duration(microseconds: 0),
                                  ),
                                  enabled: !summary.complete.value,
                                  //   onBeforePopupOpening: widget.onBeforePopup,
                                  onChanged: (photos) => db.surveyInfoTablesDao
                                      .updateGroundPhoto(surveyId, photos)
                                      .then((value) =>
                                          setState(() => photosList = photos)),
                                  items: const [
                                    "Plot Pin (Center)",
                                    "Transect 1 (0-15m)",
                                    "Transect 1 (15-30m)",
                                    "Transect 2 (0-15m)",
                                    "Transect 2 (15-30m)",
                                    "Horizontal",
                                    "Canopy",
                                    "Soil Profile",
                                    "Other1 (describe)",
                                    "Other2 (describe)",
                                    "Other3 (describe)",
                                    "Other4 (describe)"
                                  ],
                                  selectedItems: photosList,
                                  clearButtonProps:
                                      const ClearButtonProps(isVisible: true),
                                ),
                              ],
                            ),
                          ), //Photos
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kPaddingV * 2),
                            child: Column(
                              children: [
                                const TextHeaderSeparator(title: "Tree Data"),
                                DataInput(
                                  title: "Field Responsibility",
                                  prefixIcon: FontAwesomeIcons.person,
                                  startingStr: db.companionValueToStr(
                                      tree.fieldResponsibility),
                                  onSubmit: (s) => updateTree(tree.copyWith(
                                      fieldResponsibility: d.Value(s))),
                                  onValidate: (s) => s?.isEmpty ?? true
                                      ? "Please enter a value"
                                      : null,
                                ),
                                DataInput(
                                  title: "Field Checked By",
                                  prefixIcon:
                                      FontAwesomeIcons.personCircleCheck,
                                  startingStr:
                                      db.companionValueToStr(tree.fieldCheckBy),
                                  onSubmit: (s) => updateTree(
                                      tree.copyWith(fieldCheckBy: d.Value(s))),
                                  onValidate: (s) => s?.isEmpty ?? true
                                      ? "Please enter a value"
                                      : null,
                                ),
                                CalendarSelect(
                                  date: tree.fieldDate.value ?? DateTime.now(),
                                  label: "Enter Check Date",
                                  readOnly: summary.complete.value,
                                  readOnlyPopup: completeWarningPopup,
                                  onDateSelected: (DateTime date) async =>
                                      updateTree(tree.copyWith(
                                          fieldDate: d.Value(date))),
                                ),
                                DataInput(
                                  title: "Office Checked By",
                                  prefixIcon: FontAwesomeIcons.building,
                                  startingStr: db
                                      .companionValueToStr(tree.officeCheckBy),
                                  onSubmit: (s) => updateTree(
                                      tree.copyWith(officeCheckBy: d.Value(s))),
                                  onValidate: (s) => s?.isEmpty ?? true
                                      ? "Please enter a value"
                                      : null,
                                ),
                                CalendarSelect(
                                  date: tree.fieldDate.value ?? DateTime.now(),
                                  label: "Enter Check Date",
                                  readOnly: summary.complete.value,
                                  readOnlyPopup: completeWarningPopup,
                                  onDateSelected: (DateTime date) async =>
                                      updateTree(tree.copyWith(
                                          officeDate: d.Value(date))),
                                ),
                              ],
                            ),
                          ), //Tree Data
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kPaddingV * 2),
                            child: Column(
                              children: [
                                const TextHeaderSeparator(
                                    title: "Ecological Data"),
                                DataInput(
                                  title: "Field Responsibility",
                                  prefixIcon: FontAwesomeIcons.person,
                                  startingStr: db.companionValueToStr(
                                      eco.fieldResponsibility),
                                  onSubmit: (s) => updateEco(eco.copyWith(
                                      fieldResponsibility: d.Value(s))),
                                  onValidate: (s) => s?.isEmpty ?? true
                                      ? "Please enter a value"
                                      : null,
                                ),
                                DataInput(
                                  title: "Field Checked By",
                                  prefixIcon:
                                      FontAwesomeIcons.personCircleCheck,
                                  startingStr:
                                      db.companionValueToStr(eco.fieldCheckBy),
                                  onSubmit: (s) => updateEco(
                                      eco.copyWith(fieldCheckBy: d.Value(s))),
                                  onValidate: (s) => s?.isEmpty ?? true
                                      ? "Please enter a value"
                                      : null,
                                ),
                                CalendarSelect(
                                  date: eco.fieldDate.value ?? DateTime.now(),
                                  label: "Enter Check Date",
                                  readOnly: summary.complete.value,
                                  readOnlyPopup: completeWarningPopup,
                                  onDateSelected: (DateTime date) async =>
                                      updateEco(eco.copyWith(
                                          fieldDate: d.Value(date))),
                                ),
                                DataInput(
                                  title: "Office Checked By",
                                  prefixIcon: FontAwesomeIcons.building,
                                  startingStr:
                                      db.companionValueToStr(eco.officeCheckBy),
                                  onSubmit: (s) => updateEco(
                                      eco.copyWith(officeCheckBy: d.Value(s))),
                                  onValidate: (s) => s?.isEmpty ?? true
                                      ? "Please enter a value"
                                      : null,
                                ),
                                CalendarSelect(
                                  date: eco.fieldDate.value ?? DateTime.now(),
                                  label: "Enter Check Date",
                                  readOnly: summary.complete.value,
                                  readOnlyPopup: completeWarningPopup,
                                  onDateSelected: (DateTime date) async =>
                                      updateEco(eco.copyWith(
                                          officeDate: d.Value(date))),
                                ),
                              ],
                            ),
                          ), //Ecological Data
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kPaddingV * 2),
                            child: Column(
                              children: [
                                const TextHeaderSeparator(title: "Soil Data"),
                                DataInput(
                                  title: "Field Responsibility",
                                  prefixIcon: FontAwesomeIcons.person,
                                  startingStr: db.companionValueToStr(
                                      soil.fieldResponsibility),
                                  onSubmit: (s) => updateSoil(soil.copyWith(
                                      fieldResponsibility: d.Value(s))),
                                  onValidate: (s) => s?.isEmpty ?? true
                                      ? "Please enter a value"
                                      : null,
                                ),
                                DataInput(
                                  title: "Field Checked By",
                                  prefixIcon:
                                      FontAwesomeIcons.personCircleCheck,
                                  startingStr:
                                      db.companionValueToStr(soil.fieldCheckBy),
                                  onSubmit: (s) => updateSoil(
                                      soil.copyWith(fieldCheckBy: d.Value(s))),
                                  onValidate: (s) => s?.isEmpty ?? true
                                      ? "Please enter a value"
                                      : null,
                                ),
                                CalendarSelect(
                                  date: soil.fieldDate.value ?? DateTime.now(),
                                  label: "Enter Check Date",
                                  readOnly: summary.complete.value,
                                  readOnlyPopup: completeWarningPopup,
                                  onDateSelected: (DateTime date) async =>
                                      updateSoil(soil.copyWith(
                                          fieldDate: d.Value(date))),
                                ),
                                DataInput(
                                  title: "Office Checked By",
                                  prefixIcon: FontAwesomeIcons.building,
                                  startingStr: db
                                      .companionValueToStr(soil.officeCheckBy),
                                  onSubmit: (s) => updateSoil(
                                      soil.copyWith(officeCheckBy: d.Value(s))),
                                  onValidate: (s) => s?.isEmpty ?? true
                                      ? "Please enter a value"
                                      : null,
                                ),
                                CalendarSelect(
                                  date: soil.fieldDate.value ?? DateTime.now(),
                                  label: "Enter Check Date",
                                  readOnly: summary.complete.value,
                                  readOnlyPopup: completeWarningPopup,
                                  onDateSelected: (DateTime date) async =>
                                      updateSoil(soil.copyWith(
                                          officeDate: d.Value(date))),
                                ),
                              ],
                            ),
                          ), //Soil Data
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
