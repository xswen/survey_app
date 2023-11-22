import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/soil_pit/soil_pit_site_info_page.dart';
import 'package:survey_app/providers/soil_pit_providers.dart';
import 'package:survey_app/widgets/buttons/icon_nav_button.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../providers/survey_info_providers.dart';
import '../../widgets/date_select.dart';
import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../wrappers/column_header_object.dart';

class ColNames {
  ColNames();
  ColumnHeaders id = ColumnHeaders(ColumnHeaders.headerNameId, visible: false);
  ColumnHeaders pitCode = ColumnHeaders("Soil Pit Code");
  ColumnHeaders depthMin = ColumnHeaders("Depth to Mineral Samples");
  ColumnHeaders depthOrg = ColumnHeaders("Depth to Organic Samples");
  ColumnHeaders comments = ColumnHeaders("To be implemented");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

  String empty = "-";

  List<ColumnHeaders> getColHeadersList() =>
      [pitCode, depthMin, depthOrg, comments, edit];
}

class SoilPitSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "soilPitSummary";
  final GoRouterState state;
  const SoilPitSummaryPage(this.state, {super.key});

  @override
  SoilPitSummaryPageState createState() => SoilPitSummaryPageState();
}

class SoilPitSummaryPageState extends ConsumerState<SoilPitSummaryPage> {
  final String title = "Soil Pit";
  late final PopupDismiss completeWarningPopup;
  final PopupDismiss surveyCompleteWarningPopup =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  late final int surveyId;
  late final int spId;

  ColNames columnData = ColNames();

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    spId = PathParamValue.getSoilPitSummary(widget.state);
    completeWarningPopup = Popups.generateCompleteErrorPopup(title);

    super.initState();
  }

  List<DataGridRow> generateDataGridRows(List<SoilPitDepthData> data) => data
      .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
            DataGridCell<int>(
                columnName: columnData.id.name, value: dataGridRow.id),
            DataGridCell<String>(
                columnName: columnData.pitCode.name,
                value: dataGridRow.soilPitCodeComplete),
            DataGridCell<double>(
                columnName: columnData.depthMin.name,
                value: dataGridRow.depthMin),
            DataGridCell<double>(
                columnName: columnData.depthOrg.name,
                value: dataGridRow.depthOrg),
            kEditColumnDataGridCell,
          ]))
      .toList();

  DataGridSourceBuilder getSourceBuilder(List<SoilPitDepthData> data) {
    DataGridSourceBuilder soilDepthDataSource =
        DataGridSourceBuilder(dataGridRows: generateDataGridRows(data));
    soilDepthDataSource.sortedColumns.add(SortColumnDetails(
        name: columnData.id.name,
        sortDirection: DataGridSortDirection.ascending));
    soilDepthDataSource.sort();

    return soilDepthDataSource;
  }

  void navToSiteInfo() => ref
          .read(databaseProvider)
          .soilPitTablesDao
          .getSiteInfoFromSummaryId(spId)
          .then((value) {
        SoilSiteInfoCompanion data =
            SoilSiteInfoCompanion(soilPitSummaryId: d.Value(spId));
        if (value != null) {
          data = value.toCompanion(true);
        }
        context.pushNamed(SoilPitSiteInfoPage.routeName,
            pathParameters: PathParamGenerator.soilPitSummary(
                widget.state, spId.toString()),
            extra: data);
      });

  Future<void> updateSpSummary(SoilPitSummaryCompanion entry) async {
    final db = ref.read(databaseProvider);
    (db.update(db.soilPitSummary)..where((t) => t.id.equals(spId)))
        .write(entry);
    ref.refresh(soilSummaryDataProvider(spId));
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    AsyncValue<SoilPitSummaryData> spSummary =
        ref.watch(soilSummaryDataProvider(spId));

    return Scaffold(
      appBar: OurAppBar(
        title,
        backFn: () {
          ref.refresh(updateSurveyCardProvider(surveyId));
          context.pop();
        },
      ),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
          child: spSummary.when(
        error: (err, stack) => Text("Error: $err"),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (spSummary) => Column(
          children: [
            CalendarSelect(
              date: spSummary.measDate,
              label: "Enter Measurement Date",
              readOnly: spSummary.complete,
              readOnlyPopup: completeWarningPopup,
              setStateFn: (DateTime date) async => updateSpSummary(
                  SoilPitSummaryCompanion(measDate: d.Value(date))),
            ),
            IconNavButton(
              icon: const Icon(FontAwesomeIcons.file),
              space: kPaddingIcon,
              label: "Site Info",
              onPressed: () {
                navToSiteInfo();
              },
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV, horizontal: kPaddingH),
            ),
            IconNavButton(
              icon: const Icon(FontAwesomeIcons.ruler),
              space: kPaddingIcon,
              label: "Pit Depth",
              onPressed: () async {},
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV, horizontal: kPaddingH),
            ),
            IconNavButton(
              icon: const Icon(FontAwesomeIcons.objectGroup),
              space: kPaddingIcon,
              label: "Pit Feature",
              onPressed: () async {},
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV, horizontal: kPaddingH),
            ),
            IconNavButton(
              icon: const Icon(FontAwesomeIcons.mountain),
              space: kPaddingIcon,
              label: "Pit Horizon Description",
              onPressed: () async {},
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV, horizontal: kPaddingH),
            ),
          ],
        ),
      )),
    );
  }
}
