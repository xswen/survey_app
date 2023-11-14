import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/builders/ecp_layer_select_builder.dart';

class EcologicalPlotSpeciesPage extends ConsumerStatefulWidget {
  static const String routeName = "ecologicalPlotSpecies";
  final GoRouterState state;
  const EcologicalPlotSpeciesPage(this.state, {super.key});

  @override
  EcologicalPlotSpeciesPageState createState() =>
      EcologicalPlotSpeciesPageState();
}

class EcologicalPlotSpeciesPageState
    extends ConsumerState<EcologicalPlotSpeciesPage> {
  final String title = "Ecological Plot Layer";
  late final int ecpHId;
  late bool moreInfo;
  late EcpSpeciesCompanion species;

  @override
  void initState() {
    ecpHId = PathParamValue.getEcpHeaderId(widget.state);
    species = widget.state.extra as EcpSpeciesCompanion;
    moreInfo = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
        appBar: OurAppBar(
          "$title: Species number ${db.companionValueToStr(species.speciesNum)}",
        ),
        endDrawer: DrawerMenu(onLocaleChange: () {}),
        body: Padding(
          padding: const EdgeInsets.all(kPaddingH),
          child: Center(
            child: ListView(
              children: [
                EcpLayerSelectBuilder(
                    title: "Layer Id",
                    updateLayerId: (s) => setState(() => species =
                        species.copyWith(layerId: d.Value(s ?? "Error"))),
                    layerCode: db.companionValueToStr(species.layerId))
              ],
            ),
          ),
        ));
  }
}
