import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';

class SoilPitFeatureEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "soilPitFeatureEntry";
  final GoRouterState state;
  const SoilPitFeatureEntryPage(this.state, {super.key});

  @override
  SoilPitFeatureEntryPageState createState() => SoilPitFeatureEntryPageState();
}

class SoilPitFeatureEntryPageState
    extends ConsumerState<SoilPitFeatureEntryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    d.Value.absent();
    return const Placeholder();
  }
}
