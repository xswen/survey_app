import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/builders/ecp_plot_num_select_builder.dart';
import 'package:survey_app/widgets/builders/ecp_plot_type_select_builder.dart';
import 'package:survey_app/widgets/dropdowns/drop_down_default.dart';

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
    ecpHCompanion = ecpHCompanion.copyWith(ecpSummaryId: d.Value(ecpSId));
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
          EcpPlotTypeSelectBuilder(
              selectedItem: db.companionValueToStr(ecpHCompanion.plotType),
              updatePlotType: (code) => setState(() => ecpHCompanion =
                  ecpHCompanion.copyWith(
                      plotType: d.Value(code),
                      ecpNum: const d.Value.absent()))),
          EcpPlotNumSelectBuilder(ecpSId: ecpSId,
              plotType: db.companionValueToStr(ecpHCompanion.plotType),
              selectedEcpNum: db.companionValueToStr(ecpHCompanion.ecpNum),
              updateEcpNum: (ecpNum) => setState(() => ecpHCompanion =
                  ecpHCompanion.copyWith(ecpNum: d.Value(ecpNum)))),
          Padding(
            padding: const EdgeInsets.only(top: kPaddingV * 2),
            child: ElevatedButton(
              onPressed: () async {
                if (ecpHCompanion.plotType == const d.Value.absent() ||
                    ecpHCompanion.ecpNum == const d.Value.absent()) {
                  Popups.show(
                      context,
                      const PopupDismiss(
                        "Error: Missing plot type",
                        contentText:
                            "Please enter both plot type and plot number to continue",
                      ));
                } else {
                  db.ecologicalPlotTablesDao
                      .addHeader(ecpHCompanion)
                      .then((headerId) async {
                    context.pushReplacementNamed(
                        EcologicalPlotHeaderPage.routeName,
                        pathParameters: PathParamGenerator.ecpHeader(
                            widget.state, headerId.toString()));
                  });
                }
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
