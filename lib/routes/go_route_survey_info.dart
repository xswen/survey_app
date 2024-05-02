import 'package:go_router/go_router.dart';
import 'package:survey_app/pages/survey_info/survey_info_header_info/survey_info_summary_page.dart';

GoRoute goRouteSurveyInfo = GoRoute(
    name: SurveyInfoSummaryPage.routeName,
    path: "survey-summary",
    builder: (context, state) => SurveyInfoSummaryPage(state),
    routes: const []);
