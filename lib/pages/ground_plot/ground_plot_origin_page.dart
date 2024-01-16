import 'package:survey_app/barrels/page_imports_barrel.dart';

class GroundPlotOriginPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotOrigin";
  final GoRouterState state;
  const GroundPlotOriginPage(this.state, {super.key});

  @override
  GroundPlotOriginPageState createState() => GroundPlotOriginPageState();
}

class GroundPlotOriginPageState extends ConsumerState<GroundPlotOriginPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: const OurAppBar("Title"),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
        child: ElevatedButton(
          child: const Text("tmp"),
          onPressed: () {},
        ),
      )),
    );
  }
}
