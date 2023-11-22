import 'package:survey_app/barrels/page_imports_barrel.dart';

class SoilPitDepthEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "soilPitDepthEntry";
  final GoRouterState state;
  const SoilPitDepthEntryPage(this.state, {super.key});

  @override
  SoilPitDepthEntryPageState createState() => SoilPitDepthEntryPageState();
}

class SoilPitDepthEntryPageState extends ConsumerState<SoilPitDepthEntryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
