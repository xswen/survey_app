import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/data_input/data_input.dart';
import 'package:survey_app/widgets/dropdowns/drop_down_default.dart';

class GroundPlotOriginEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotOriginEntry";
  final GoRouterState state;
  const GroundPlotOriginEntryPage(this.state, {super.key});

  @override
  GroundPlotOriginEntryPageState createState() =>
      GroundPlotOriginEntryPageState();
}

class GroundPlotOriginEntryPageState
    extends ConsumerState<GroundPlotOriginEntryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: const OurAppBar("Tree Cover Origin Entry"),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      bottomNavigationBar:
          ElevatedButton(child: Text("Save"), onPressed: () => null),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
        child: ListView(
          children: [
            DropDownDefault(
                title: "Vegetation cover origin",
                onChangedFn: (s) {},
                itemsList: ["SUCC", "HARV"],
                selectedItem: ""),
            DropDownDefault(
                title: "Type of regeneration",
                onChangedFn: (s) {},
                itemsList: ["NAT", "SUP"],
                selectedItem: ""),
            DataInput(
                title: "Year of regeneration",
                onSubmit: (s) {},
                onValidate: (s) {}),
          ],
        ),
      )),
    );
  }
}
