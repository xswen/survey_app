import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/providers/ecological_plot_providers.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../widgets/tables/table_data_grid_source_builder.dart';
import '../../wrappers/column_header_object.dart';

class ColNames {
  ColNames();
  ColumnHeaders id = ColumnHeaders(ColumnHeaders.headerNameId, visible: false);
  ColumnHeaders layerId = ColumnHeaders("Layer Id");
  ColumnHeaders genus = ColumnHeaders("Genus");
  ColumnHeaders species = ColumnHeaders("Species");
  ColumnHeaders variety = ColumnHeaders("Variety");
  ColumnHeaders speciesPct = ColumnHeaders("Species %");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

  static String empty = "-";

  List<ColumnHeaders> getColHeadersList() =>
      [layerId, genus, species, variety, speciesPct, edit];
}

class EcologicalPlotHeaderPage extends ConsumerStatefulWidget {
  static const String routeName = "ecologicalPlotHeader";
  final GoRouterState state;
  const EcologicalPlotHeaderPage(this.state, {super.key});

  @override
  EcologicalPlotHeaderPageState createState() =>
      EcologicalPlotHeaderPageState();
}

class EcologicalPlotHeaderPageState
    extends ConsumerState<EcologicalPlotHeaderPage> {
  final String title = "Ecological Plot";
  late final PopupDismiss popupPageComplete =
      Popups.generateCompleteErrorPopup(title);
  final PopupDismiss popupSurveyComplete =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  late bool parentComplete = false;
  late EcpHeaderCompanion ecpH = const EcpHeaderCompanion();

  late final int surveyId;
  late final int ecpId;
  late final int ecpHId;

  final ColNames columnData = ColNames();

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    ecpId = PathParamValue.getEcpSummaryId(widget.state);
    ecpHId = PathParamValue.getEcpHeaderId(widget.state);

    _loadData();
    super.initState();
  }

  void _loadData() async {
    final ecp =
        await Database.instance.ecologicalPlotTablesDao.getSummary(ecpId);
    final value =
        await Database.instance.ecologicalPlotTablesDao.getHeaderFromId(ecpHId);

    if (mounted) {
      setState(() {
        parentComplete = ecp.complete;
        ecpH = value.toCompanion(true);
      });
    }
  }

  List<DataGridRow> generateDataGridRows(List<EcpSpeciesData> speciesList) {
    return speciesList
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: columnData.id.name, value: dataGridRow.id),
              DataGridCell<String>(
                  columnName: columnData.layerId.name,
                  value: dataGridRow.layerId),
              DataGridCell<String>(
                  columnName: columnData.genus.name, value: dataGridRow.genus),
              DataGridCell<String>(
                  columnName: columnData.species.name,
                  value: dataGridRow.species),
              DataGridCell<String>(
                  columnName: columnData.variety.name,
                  value: dataGridRow.variety),
              DataGridCell<double>(
                  columnName: columnData.speciesPct.name,
                  value: dataGridRow.speciesPct),
              DataGridCell<EcpSpeciesData>(
                  columnName: columnData.edit.name, value: dataGridRow),
            ]))
        .toList();
  }

  DataGridSourceBuilder getSourceBuilder(List<EcpSpeciesData> speciesList) {
    DataGridSourceBuilder source =
        DataGridSourceBuilder(dataGridRows: generateDataGridRows(speciesList));
    source.sortedColumns.add(SortColumnDetails(
        name: columnData.id.toString(),
        sortDirection: DataGridSortDirection.ascending));
    source.sort();

    return source;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    final AsyncValue<List<EcpSpeciesData>> speciesList =
        ref.watch(ecpSpeciesListProvider(ecpHId));

    return db.companionValueToStr(ecpH.id).isEmpty
        ? Scaffold(
            appBar: OurAppBar(
              "$title: Transect ${db.companionValueToStr(ecpH.ecpNum)}",
            ),
            body: const Center(child: kLoadingWidget))
        : Scaffold(
            appBar: OurAppBar(
              "$title: Transect ${db.companionValueToStr(ecpH.ecpNum)}",
              onLocaleChange: () {},
              backFn: () {
                ref.refresh(ecpTransListProvider(ecpId));
                context.pop();
              },
            ),
            floatingActionButton: FloatingCompleteButton(
              title: "Surface Substrate",
              complete: db.companionValueToStr(ecpH.complete).isEmpty
                  ? false
                  : ecpH.complete.value,
              onPressed: () => null, //markComplete(),
            ),
            endDrawer: DrawerMenu(onLocaleChange: () {}),
            body: Text(ecpH.toString()),
          );
  }
}
