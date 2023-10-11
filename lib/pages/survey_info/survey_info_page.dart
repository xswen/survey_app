import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/routes/router_routes_main.dart';
import 'package:survey_app/wrappers/survey_card.dart';

import '../../providers/change_notifiers.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';

class SurveyInfoPage extends StatefulWidget {
  static const String routeName = "surveyInfo";
  final GoRouterState goRouterState;
  const SurveyInfoPage({super.key, required this.goRouterState});

  @override
  State<SurveyInfoPage> createState() => _SurveyInfoPage();
}

class _SurveyInfoPage extends State<SurveyInfoPage> {
  final Database db = Database.instance;
  final String title = "Survey Info";
  late int surveyId;

  @override
  void initState() {
    // TODO: implement initState
    surveyId = int.parse(
        widget.goRouterState!.pathParameters[RouteParams.surveyIdKey]!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    Future<SurveyHeader> futureSurvey =
        db.surveyInfoTablesDao.getSurvey(surveyId);
    Future<List<SurveyCard>> cards = db.getCards(surveyId);

    // final PopupDismiss completeWarningPopup =
    //     Popups.generateCompleteErrorPopup(context, title);
    // final PopupDismiss surveyCompleteWarningPopup =
    //     Popups.generatePreviousMarkedCompleteErrorPopup(context, "Survey");

    return Scaffold(
      appBar: OurAppBar(
        "$title",
        backFn: () {
          (db.update(db.surveyHeaders)..where((t) => t.id.equals(surveyId)))
              .write(SurveyHeadersCompanion(complete: d.Value(true)))
              .then((value) {
            Provider.of<UpdateNotifierSurveyInfo>(context, listen: false)
                .triggerRebuild();
            context.pop();
          });
        },
      ),
      floatingActionButton: FloatingCompleteButton(
        title: "",
        complete: false,
        onPressed: () {},
      ),
      body: Center(
        child: Text("Hi"),
      ),
    );
  }
}
