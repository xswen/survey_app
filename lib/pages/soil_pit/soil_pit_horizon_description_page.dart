import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/soil_pit/soil_pit_horizon_description_entry_page.dart';
import 'package:survey_app/providers/soil_pit_providers.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../widgets/buttons/custom_button_styles.dart';
import '../../widgets/tables/table_creation_builder.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../wrappers/column_header_object.dart';

class ColNames {
  ColNames();
  ColumnHeaders id = ColumnHeaders(ColumnHeaders.headerNameId, visible: false);
  ColumnHeaders pitCode = ColumnHeaders("Pit Code");
  ColumnHeaders horNum = ColumnHeaders("Horizon Number");
  ColumnHeaders horizon = ColumnHeaders("Horizon");
  ColumnHeaders horFeature = ColumnHeaders("Horizon Upper Depth Field");
  ColumnHeaders horThickness = ColumnHeaders("Horizon Thickness");
  ColumnHeaders colour = ColumnHeaders("Colour");
  ColumnHeaders texture = ColumnHeaders("Texture");
  ColumnHeaders gravel = ColumnHeaders("% Gravel");
  ColumnHeaders cobble = ColumnHeaders("% Cobbles");
  ColumnHeaders stone = ColumnHeaders("% Stone");
  ColumnHeaders comments = ColumnHeaders("Comment - to be added");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

  String empty = "-";

  List<ColumnHeaders> getColHeadersList() => [
        pitCode,
        horNum,
        horizon,
        horFeature,
        horThickness,
        colour,
        texture,
        gravel,
        cobble,
        stone,
        comments,
        edit
      ];
}

class SoilPitHorizonDescriptionPage extends ConsumerStatefulWidget {
  static const String routeName = "soilPitHorizonDescription";
  final GoRouterState state;
  const SoilPitHorizonDescriptionPage(this.state, {super.key});

  @override
  SoilPitHorizonDescriptionPageState createState() =>
      SoilPitHorizonDescriptionPageState();
}

class SoilPitHorizonDescriptionPageState
    extends ConsumerState<SoilPitHorizonDescriptionPage> {
  final String title = "Soil Pit Horizon Description";
  late final PopupDismiss completeWarningPopup;
  final PopupDismiss surveyCompleteWarningPopup =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  late bool parentComplete = false;

  late final int spId;

  ColNames columnData = ColNames();

  @override
  void initState() {
    spId = PathParamValue.getSoilPitSummary(widget.state);
    completeWarningPopup = Popups.generateCompleteErrorPopup(title);
    _loadData();
    super.initState();
  }

  void _loadData() async {
    final parent = await Database.instance.soilPitTablesDao.getSummary(spId);

    if (mounted) {
      setState(() {
        parentComplete = parent.complete;
      });
    }
  }

  List<DataGridRow> generateDataGridRows(
      List<SoilPitHorizonDescriptionData> data) {
    return data
        .map<DataGridRow>((dataRow) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: columnData.pitCode.name,
                  value: dataRow.soilPitCodeField),
              DataGridCell<int>(
                  columnName: columnData.horNum.name,
                  value: dataRow.horizonNum),
              DataGridCell<String>(
                  columnName: columnData.horizon.name, value: dataRow.horizon),
              DataGridCell<double>(
                  columnName: columnData.horFeature.name,
                  value: dataRow.horizonUpper),
              DataGridCell<double>(
                  columnName: columnData.horThickness.name,
                  value: dataRow.thickness),
              DataGridCell<String>(
                  columnName: columnData.colour.name, value: dataRow.color),
              DataGridCell<String>(
                  columnName: columnData.texture.name, value: dataRow.texture),
              DataGridCell<int>(
                  columnName: columnData.gravel.name, value: dataRow.cfGrav),
              DataGridCell<int>(
                  columnName: columnData.cobble.name, value: dataRow.cfCobb),
              DataGridCell<int>(
                  columnName: columnData.stone.name, value: dataRow.cfStone),
              DataGridCell<String>(
                  columnName: columnData.comments.name,
                  value: "functionality to be added"),
              kEditColumnDataGridCell,
            ]))
        .toList();
  }

  DataGridSourceBuilder getSourceBuilder(
      List<SoilPitHorizonDescriptionData> data) {
    DataGridSourceBuilder dataSource =
        DataGridSourceBuilder(dataGridRows: generateDataGridRows(data));
    dataSource.sortedColumns.add(SortColumnDetails(
        name: columnData.id.name,
        sortDirection: DataGridSortDirection.ascending));
    dataSource.sort();

    return dataSource;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    final AsyncValue<List<SoilPitHorizonDescriptionData>> horizonList =
        ref.watch(soilHorizonListProvider(spId));
    d.Value.absent();
    return Scaffold(
      appBar: OurAppBar(
        title,
        onLocaleChange: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Horizon",
                    style: TextStyle(fontSize: kTextTitleSize),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: kPaddingH),
                    child: ElevatedButton(
                        onPressed: () async => parentComplete
                            ? Popups.show(context, completeWarningPopup)
                            : context.pushNamed(
                                SoilPitHorizonDescriptionEntryPage.routeName,
                                pathParameters:
                                    PathParamGenerator.soilPitSummary(
                                        widget.state, spId.toString()),
                                extra: SoilPitHorizonDescriptionCompanion(
                                    soilPitSummaryId: d.Value(spId))),
                        style: CustomButtonStyles.inactiveButton(
                            isActive: !parentComplete),
                        child: const Text("Add feature")),
                  ),
                ],
              ),
            ),
            Expanded(
                child: horizonList.when(
              data: (dataList) {
                DataGridSourceBuilder source = getSourceBuilder(dataList);

                return Center(
                  child: TableCreationBuilder(
                    source: source,
                    columnWidthMode: ColumnWidthMode.lastColumnFill,
                    colNames: columnData.getColHeadersList(),
                    onCellTap: (DataGridCellTapDetails details) async {
                      // Assuming the "edit" column index is 2
                      if (details.column.columnName == columnData.edit.name &&
                          details.rowColumnIndex.rowIndex != 0) {
                        if (parentComplete) {
                          Popups.show(context, surveyCompleteWarningPopup);
                        } else {
                          int id = source
                              .dataGridRows[details.rowColumnIndex.rowIndex - 1]
                              .getCells()[0]
                              .value;
                          db.soilPitTablesDao.getFeature(id).then((value) =>
                              context.pushNamed(
                                  SoilPitHorizonDescriptionEntryPage.routeName,
                                  pathParameters:
                                      PathParamGenerator.soilPitSummary(
                                          widget.state, spId.toString()),
                                  extra: value.toCompanion(true)));
                        }
                      }
                    },
                  ),
                );
              },
              error: (err, stack) => Text("Error: $err"),
              loading: () => const Center(child: CircularProgressIndicator()),
            )),
          ],
        ),
      ),
    );
  }
}
