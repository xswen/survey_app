import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/builders/ecp_genus_select_builder.dart';
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
  late EcpSpeciesCompanion layer;

  @override
  void initState() {
    ecpHId = PathParamValue.getEcpHeaderId(widget.state);
    layer = widget.state.extra as EcpSpeciesCompanion;
    moreInfo = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
        appBar: OurAppBar(
          "$title: Species number ${db.companionValueToStr(layer.speciesNum)}",
        ),
        endDrawer: DrawerMenu(onLocaleChange: () {}),
        body: Padding(
          padding: const EdgeInsets.all(kPaddingH),
          child: Center(
            child: ListView(
              children: [
                Text(layer.toString()),
                EcpLayerSelectBuilder(
                    title: "Layer Id",
                    updateLayerId: (s) => setState(() =>
                        layer = layer.copyWith(layerId: d.Value(s ?? "Error"))),
                    layerCode: db.companionValueToStr(layer.layerId)),
                EcpGenusSelectBuilder(
                    title: "Genus",
                    updateGenus: (genus, species, variety) => setState(() =>
                        layer = layer.copyWith(
                            genus: genus, species: species, variety: variety)),
                    genus: db.companionValueToStr(layer.genus))
              ],
            ),
          ),
        ));
  }
}
