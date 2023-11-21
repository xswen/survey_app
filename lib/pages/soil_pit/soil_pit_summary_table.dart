import 'package:survey_app/barrels/page_imports_barrel.dart';

import '../../providers/survey_info_providers.dart';

class SoilPitSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "soilPitSummary";
  final GoRouterState state;
  const SoilPitSummaryPage(this.state, {super.key});

  @override
  SoilPitSummaryPageState createState() => SoilPitSummaryPageState();
}

class SoilPitSummaryPageState extends ConsumerState<SoilPitSummaryPage> {
  final String title = "Soil Pit";
  late final PopupDismiss completeWarningPopup;
  final PopupDismiss surveyCompleteWarningPopup =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  late final int surveyId;
  late final int spId;

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    spId = PathParamValue.getSoilPitSummary(widget.state);
    completeWarningPopup = Popups.generateCompleteErrorPopup(title);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: OurAppBar(
        title,
        backFn: () {
          ref.refresh(updateSurveyCardProvider(surveyId));
          context.pop();
        },
      ),
    );
  }
}
