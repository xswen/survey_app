import 'package:go_router/go_router.dart';
import 'package:survey_app/routes/path_parameters/path_param_keys.dart';

import '../pages/soil_pit/soil_pit_summary_table.dart';

GoRoute goRouteSoilPit = GoRoute(
    name: SoilPitSummaryPage.routeName,
    path: "soil_pit/:${PathParamsKeys.soilPitSummaryId}",
    builder: (context, state) => SoilPitSummaryPage(state),
    routes: []);
