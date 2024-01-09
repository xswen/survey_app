import 'package:survey_app/barrels/page_imports_barrel.dart';

class SurveyInfoSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "surveyInfoSummary";
  final GoRouterState state;
  const SurveyInfoSummaryPage(this.state, {super.key});

  @override
  SurveyInfoSummaryPageState createState() => SurveyInfoSummaryPageState();
}

class SurveyInfoSummaryPageState extends ConsumerState<SurveyInfoSummaryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return const Placeholder();
  }
}
