import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../widgets/date_select.dart';

class PlotDataSource extends DataGridSource {
  final List<DataGridRow> _plotRows = [const DataGridRow(cells: [])];

  @override
  List<DataGridRow> get rows => _plotRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      // Text(row.getCells()[0].value.toString()),
      // Text(row.getCells()[1].value.toString()),
      // Text(row.getCells()[2].value.toString()),
    ]);
  }
}

class SmallTreePlotSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "smallTreePlotSummary";
  final GoRouterState state;
  const SmallTreePlotSummaryPage(this.state, {super.key});

  @override
  SmallTreePlotSummaryPageState createState() =>
      SmallTreePlotSummaryPageState();
}

class SmallTreePlotSummaryPageState
    extends ConsumerState<SmallTreePlotSummaryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: OurAppBar(
        "Small Tree Plot",
        backFn: () {
          //ref.refresh(updateSurveyCardProvider(surveyId));
          context.pop();
        },
      ),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
        child: Column(
          children: [
            CalendarSelect(
              date: DateTime.now(),
              label: "Enter Measurement Date",
              readOnly: false,
              setStateFn: (DateTime date) async => (),
            ),
            SfDataGrid(
              source: PlotDataSource(),
              columns: <GridColumn>[
                GridColumn(
                    columnName: 'smallTreeNumber',
                    label: const Text('small tree number')),
                GridColumn(
                    columnName: 'originalPlotArea',
                    label: const Text('original plot area')),
                GridColumn(columnName: 'genus', label: const Text('genus')),
                GridColumn(columnName: 'species', label: const Text('species')),
                GridColumn(columnName: 'variety', label: const Text('variety')),
                GridColumn(
                    columnName: 'treeStatus', label: const Text('tree status')),
                GridColumn(columnName: 'dbhCm', label: const Text('DBH (cm)')),
                GridColumn(
                    columnName: 'heightM', label: const Text('height (m)')),
                GridColumn(
                    columnName: 'mOrEHt', label: const Text('M or E Ht.')),
                GridColumn(
                    columnName: 'stemCondition',
                    label: const Text('Stem Condition')),
              ],
              columnWidthMode: ColumnWidthMode.fill,
            ),
          ],
        ),
      ),
    );
  }
}
