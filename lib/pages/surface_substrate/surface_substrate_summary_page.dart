import 'package:survey_app/barrels/page_imports_barrel.dart';

class SurfaceSubstrateSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "surfaceSubstrateSummary";
  final GoRouterState state;
  const SurfaceSubstrateSummaryPage(this.state, {super.key});

  @override
  SurfaceSubstrateSummaryPageState createState() =>
      SurfaceSubstrateSummaryPageState();
}

class SurfaceSubstrateSummaryPageState
    extends ConsumerState<SurfaceSubstrateSummaryPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
