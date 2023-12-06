import 'package:survey_app/barrels/page_imports_barrel.dart';

class SmallTreeSpeciesEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "smallTreeSpeciesEntry";
  final GoRouterState state;
  const SmallTreeSpeciesEntryPage(this.state, {super.key});

  @override
  SmallTreeSpeciesEntryPageState createState() =>
      SmallTreeSpeciesEntryPageState();
}

class SmallTreeSpeciesEntryPageState
    extends ConsumerState<SmallTreeSpeciesEntryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
