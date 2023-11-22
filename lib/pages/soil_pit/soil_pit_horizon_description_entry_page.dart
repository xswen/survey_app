import 'package:survey_app/barrels/page_imports_barrel.dart';

class SoilPitHorizonDescriptionEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "soilPitHorizonDescriptionEntry";
  final GoRouterState state;
  const SoilPitHorizonDescriptionEntryPage(this.state, {super.key});

  @override
  SoilPitHorizonDescriptionEntryPageState createState() =>
      SoilPitHorizonDescriptionEntryPageState();
}

class SoilPitHorizonDescriptionEntryPageState
    extends ConsumerState<SoilPitHorizonDescriptionEntryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
