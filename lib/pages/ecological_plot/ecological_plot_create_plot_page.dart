import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';

import '../../providers/ecological_plot_providers.dart';
import '../../widgets/dropdowns/drop_down_async_list.dart';
import 'ecological_plot_header_page.dart';

class EcologicalPlotCreatePlotPage extends ConsumerStatefulWidget {
  static const String routeName = "ecologicalPlotCreatePlot";
  final GoRouterState state;
  const EcologicalPlotCreatePlotPage(this.state, {super.key});

  @override
  EcologicalPlotCreatePlotPageState createState() =>
      EcologicalPlotCreatePlotPageState();
}

class EcologicalPlotCreatePlotPageState
    extends ConsumerState<EcologicalPlotCreatePlotPage> {
  late final int ecpSId;

  EcpHeaderCompanion ecpHCompanion = const EcpHeaderCompanion();

  @override
  void initState() {
    ecpSId = PathParamValue.getEcpSummaryId(widget.state);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: const OurAppBar("Create Plot"),
      endDrawer: DrawerMenu(
        onLocaleChange: () {},
      ),
      body: Column(
        children: [
          DropDownAsyncList(
            title: "Plot type",
            searchable: true,
            onChangedFn: (s) => db.referenceTablesDao
                .getEcpPlotTypeCode(s!)
                .then((code) => setState(() => ecpHCompanion =
                    ecpHCompanion.copyWith(plotType: d.Value(code)))),
            asyncItems: (s) => db.referenceTablesDao.getEcpPlotTypeNameList(),
            selectedItem: "Please select plot type",
          ),
          Padding(
            padding: const EdgeInsets.only(top: kPaddingV * 2),
            child: ElevatedButton(
              onPressed: () async {
                db.ecologicalPlotTablesDao
                    .addHeader(ecpHCompanion)
                    .then((headerId) async {
                  context
                      .pushNamed(EcologicalPlotHeaderPage.routeName,
                          pathParameters: PathParamGenerator.ecpHeader(
                              widget.state, headerId.toString()))
                      .then((value) {
                    ref.refresh(ecpTransListProvider(headerId));
                    ref.refresh(ecpDataProvider(headerId));
                  });
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              child: const Text("Continue"),
            ),
          ),
        ],
      ),
    );
  }
}
