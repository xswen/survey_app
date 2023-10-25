import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/surface_substrate/surface_substrate_station_info_page.dart';
import 'package:survey_app/providers/surface_substrate_providers.dart';
import 'package:survey_app/widgets/popups/popup_errors_found_list.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/set_transect_num_builder.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/tables/table_creation_builder.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../wrappers/column_header_object.dart';

class ColNames {
  ColNames();
  ColumnHeaders id = ColumnHeaders(ColumnHeaders.headerNameId, visible: false);
  ColumnHeaders stationNum = ColumnHeaders("Station Num");
  ColumnHeaders type = ColumnHeaders("Type");
  ColumnHeaders depth = ColumnHeaders("Depth");
  ColumnHeaders depthLimit = ColumnHeaders("Depth Limit");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

  static String empty = "-";

  List<ColumnHeaders> getColHeadersList() =>
      [stationNum, type, depth, depthLimit, edit];
}

class SurfaceSubstrateHeaderPage extends ConsumerStatefulWidget {
  static const String routeName = "surfaceHeader";
  final GoRouterState state;
  const SurfaceSubstrateHeaderPage(this.state, {super.key});

  @override
  SurfaceSubstrateHeaderPageState createState() =>
      SurfaceSubstrateHeaderPageState();
}

class SurfaceSubstrateHeaderPageState
    extends ConsumerState<SurfaceSubstrateHeaderPage> {
  final String title = "Surface Substrate";
  late final PopupDismiss popupPageComplete =
      Popups.generateCompleteErrorPopup(title);
  final PopupDismiss popupSurveyComplete =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  late bool parentComplete = false;
  late SurfaceSubstrateHeaderCompanion ssh =
      const SurfaceSubstrateHeaderCompanion();

  late final int surveyId;
  late final int ssId;
  late final int sshId;

  final ColNames columnData = ColNames();

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    ssId = PathParamValue.getSsSummaryId(widget.state);
    sshId = PathParamValue.getSsHeaderId(widget.state);

    _loadData();
    super.initState();
  }

  void _loadData() async {
    final ss = await Database.instance.surfaceSubstrateTablesDao
        .getSsSummary(surveyId);
    final value = await Database.instance.surfaceSubstrateTablesDao
        .getSsHeaderFromId(sshId);

    if (mounted) {
      // Only proceed if the widget is still in the tree
      setState(() {
        parentComplete = ss.complete;
        ssh = value.toCompanion(true);
      });
    }
  }

  List<DataGridRow> generateDataGridRows(
          List<SurfaceSubstrateTallyData> stations) =>
      stations
          .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
                DataGridCell<int>(
                    columnName: columnData.id.name, value: dataGridRow.id),
                DataGridCell<int>(
                    columnName: columnData.stationNum.name,
                    value: dataGridRow.stationNum),
                DataGridCell<String>(
                    columnName: columnData.type.name,
                    value: dataGridRow.substrateType),
                DataGridCell<String>(
                    columnName: columnData.depth.name,
                    value: dataGridRow.depth?.toString() ?? ""),
                DataGridCell<String>(
                    columnName: columnData.depthLimit.name,
                    value: dataGridRow.depthLimit?.toString() ?? ""),
                DataGridCell<SurfaceSubstrateTallyData>(
                    columnName: columnData.edit.name, value: dataGridRow),
              ]))
          .toList();

  DataGridSourceBuilder getSourceBuilder(
      List<SurfaceSubstrateTallyData> stations) {
    DataGridSourceBuilder source =
        DataGridSourceBuilder(dataGridRows: generateDataGridRows(stations));
    source.sortedColumns.add(SortColumnDetails(
        name: columnData.stationNum.toString(),
        sortDirection: DataGridSortDirection.ascending));
    source.sort();

    return source;
  }

  void updateSshCompanion(SurfaceSubstrateHeaderCompanion newSshC) =>
      setState(() => ssh = newSshC);

  void updateSshData(SurfaceSubstrateHeaderCompanion sshC) {
    final db = ref.read(databaseProvider);
    (db.update(db.surfaceSubstrateHeader)..where((t) => t.id.equals(sshId)))
        .write(sshC)
        .then((value) => setState(() => ssh = sshC));
  }

  List<String>? errorCheck() {
    final db = ref.read(databaseProvider);
    List<String> results = [];
    errorNomTransLen(db.companionValueToStr(ssh.nomTransLen)) != null
        ? results.add("Nominal Transect Length")
        : null;
    errorTransAzim(db.companionValueToStr(ssh.transAzimuth)) != null
        ? results.add("Transect Azimuth")
        : null;
    return results.isEmpty ? null : results;
  }

  //measured length of the sample transect (m). 10.0 to 150.0
  String? errorNomTransLen(String? text) {
    if (text?.isEmpty ?? true) {
      return "Can't be empty";
    } else if (10.0 > double.parse(text!) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 10.0 to 150.0 inclusive.";
    }
    return null;
  }

  //Transect azimuth (degrees) 0 to 360
  String? errorTransAzim(String? text) {
    if (text?.isEmpty ?? true) {
      return "Can't be empty";
    } else if (0 > int.parse(text!) || int.parse(text) > 360) {
      return "Input out of range. Must be between 0 to 360 inclusive.";
    }
    return null;
  }

  void markComplete() async {
    final db = Database.instance;
    print(ssh);
    if (parentComplete) {
      Popups.show(context, popupSurveyComplete);
    } else if (ssh.complete.value) {
      updateSshData(ssh.copyWith(complete: const d.Value(false)));
    } else {
      List<String>? errors = errorCheck();
      errors == null
          ? updateSshData(ssh.copyWith(complete: const d.Value(true)))
          : Popups.show(context, PopupErrorsFoundList(errors: errors));
    }
  }

  void createNewSsTallyCompanion() => ref
      .read(databaseProvider)
      .surfaceSubstrateTablesDao
      .getNextStationNum(sshId)
      .then((stationNum) => context.pushNamed(
          SurfaceSubstrateStationInfoPage.routeName,
          pathParameters: PathParamGenerator.ssStationInfo(
              widget.state, stationNum.toString()),
          extra: SurfaceSubstrateTallyCompanion(
              ssHeaderId: d.Value(sshId),
              stationNum: d.Value(stationNum),
              //Assume null until stated otherwise
              depth: const d.Value(null))));

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    final AsyncValue<List<SurfaceSubstrateTallyData>> tallyDataList =
        ref.watch(ssTallyDataListProvider(sshId));

    return db.companionValueToStr(ssh.id).isEmpty
        ? Scaffold(
            appBar: OurAppBar(
              "$title: Transect ${db.companionValueToStr(ssh.transNum)}",
            ),
            body: const Center(child: kLoadingWidget))
        : Scaffold(
            appBar: OurAppBar(
              "$title: Transect ${db.companionValueToStr(ssh.transNum)}",
              onLocaleChange: () {},
              backFn: () {
                ref.refresh(ssTransListProvider(ssId));
                context.pop();
              },
            ),
            floatingActionButton: FloatingCompleteButton(
              title: "Surface Substrate",
              complete: db.companionValueToStr(ssh.complete).isEmpty
                  ? false
                  : ssh.complete.value,
              onPressed: () => markComplete(),
            ),
            endDrawer: DrawerMenu(onLocaleChange: () {}),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
              child: Column(children: [
                SetTransectNumBuilder(
                  getUsedTransNums: db.surfaceSubstrateTablesDao
                      .getUsedTransNums(ssh.ssId.value),
                  startingTransNum: db.companionValueToStr(ssh.transNum),
                  selectedItem: db.companionValueToStr(ssh.transNum).isEmpty
                      ? "Please select transect number"
                      : db.companionValueToStr(ssh.transNum),
                  transList: kTransectNumsList,
                  updateTransNum: (int transNum) =>
                      updateSshData(ssh.copyWith(transNum: d.Value(transNum))),
                  onBeforePopup: (s) async {
                    if (ssh.complete.value) {
                      Popups.show(context, popupPageComplete);
                      return false;
                    }
                    return true;
                  },
                ),
                DataInput(
                  readOnly: ssh.complete.value,
                  title: "The measured length of the sample transect.",
                  boxLabel: "Report to the nearest 0.1cm",
                  prefixIcon: FontAwesomeIcons.ruler,
                  suffixVal: "cm",
                  startingStr: db.companionValueToStr(ssh.nomTransLen),
                  //database allows marking as absent, however this should be flagged
                  //on check for marking complete
                  onValidate: (s) => errorNomTransLen(s) == "Can't be empty"
                      ? null
                      : errorNomTransLen(s),
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(5),
                    ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
                  ],
                  onSubmit: (String s) {
                    s.isEmpty
                        ? updateSshData(
                            ssh.copyWith(nomTransLen: const d.Value(null)))
                        : errorNomTransLen(s) == null
                            ? updateSshData(ssh.copyWith(
                                nomTransLen: d.Value(double.parse(s))))
                            : ssh = ssh.copyWith(
                                nomTransLen: d.Value(double.parse(s)));
                  },
                ),
                DataInput(
                  readOnly: ssh.complete.value,
                  title: "Transect azimuth.",
                  boxLabel: "Report in degrees",
                  prefixIcon: FontAwesomeIcons.angleLeft,
                  suffixVal: "\u00B0",
                  startingStr: db.companionValueToStr(ssh.transAzimuth),
                  //database allows marking as absent, however this should be flagged
                  //on check for marking complete
                  onValidate: (s) => errorTransAzim(s) == "Can't be empty"
                      ? null
                      : errorTransAzim(s),
                  inputType:
                      const TextInputType.numberWithOptions(decimal: false),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                    ThousandsFormatter(allowFraction: false),
                  ],
                  onSubmit: (String s) {
                    s.isEmpty
                        ? updateSshData(
                            ssh.copyWith(transAzimuth: const d.Value(null)))
                        : errorTransAzim(s) == null
                            ? updateSshData(ssh.copyWith(
                                transAzimuth: d.Value(int.parse(s))))
                            : ssh = ssh.copyWith(
                                transAzimuth: d.Value(int.parse(s)));
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kPaddingH / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Coarse Woody Debris",
                        style: TextStyle(fontSize: kTextTitleSize),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: kPaddingH),
                        child: ElevatedButton(
                            onPressed: () async => ssh.complete.value
                                ? Popups.show(context, popupPageComplete)
                                : createNewSsTallyCompanion(),
                            style: ButtonStyle(
                                backgroundColor: ssh.complete.value
                                    ? MaterialStateProperty.all<Color>(
                                        Colors.grey)
                                    : null),
                            child: const Text("Add station")),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: tallyDataList.when(
                      data: (tallyDataList) {
                        DataGridSourceBuilder source =
                            getSourceBuilder(tallyDataList);
                        return Center(
                          child: TableCreationBuilder(
                            source: source,
                            columnWidthMode: ColumnWidthMode.lastColumnFill,
                            colNames: columnData.getColHeadersList(),
                            onCellTap: (DataGridCellTapDetails details) async {
                              // Assuming the "edit" column index is 2
                              if (details.column.columnName ==
                                      columnData.edit.name &&
                                  details.rowColumnIndex.rowIndex != 0) {
                                if (ssh.complete.value || parentComplete) {
                                  Popups.show(context, popupPageComplete);
                                } else {
                                  int pId = source.dataGridRows[
                                          details.rowColumnIndex.rowIndex - 1]
                                      .getCells()[0]
                                      .value;
                                }
                              }
                            },
                          ),
                        );
                      },
                      error: (err, stack) => Text("Error: $err"),
                      loading: () =>
                          const Center(child: CircularProgressIndicator())),
                ),
              ]),
            ),
          );
  }
}
