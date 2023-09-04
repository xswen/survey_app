import 'package:drift/drift.dart' as d;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/constants/text_designs.dart';
import 'package:survey_app/l10n/locale_keys.g.dart';

import '../../constants/margins_padding.dart';
import '../../database/database.dart';
import '../../formatters/format_date.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/text/text_line_label.dart';
import '../../widgets/tile_cards/tile_card_dashboard.dart';
import 'create_survey_page.dart';
import 'survey_info_page.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = "dashboard";
  const DashboardPage({super.key, required this.title, required this.surveys});

  final String title;
  final List<SurveyHeader> surveys;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int idx = 0;
  late List<SurveyHeader> surveys;

  @override
  void initState() {
    surveys = widget.surveys;
    super.initState();
  }

  @override
  Scaffold build(BuildContext context) {
    final db = Provider.of<Database>(context);

    void updateDashboard() {
      db.surveyInfoTablesDao.allSurveys
          .then((value) => setState(() => surveys = value));
    }

    Widget createSurveyButton(Database db, int index) {
      SurveyHeader survey = (surveys)[index];

      return Container(
        margin: const EdgeInsets.symmetric(
            horizontal: kPaddingH, vertical: kPaddingV / 2),
        child: ElevatedButton(
            onPressed: () async {
              context.pushNamed(
                SurveyInfoPage.routeName,
                extra: {
                  SurveyInfoPage.keySurvey:
                      await db.surveyInfoTablesDao.getSurvey(survey.id),
                  SurveyInfoPage.keyCards: await db.getCards(survey.id),
                  SurveyInfoPage.keyUpdateDash: updateDashboard
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kPaddingH, vertical: kPaddingV),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextLineLabelTop(
                            value: Text(survey.province),
                            label: const Text("Jurisdiction")),
                        TextLineLabelTop(
                            value: Text(survey.nfiPlot.toString()),
                            label: const Text("Plot Number")),
                        TextLineLabelTop(
                            value: Text(survey.measNum.toString()),
                            label: const Text("Meas. Number")),
                      ]),
                  kDividerV,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextLineLabelTop(
                            value: Text(FormatDate.toStr(survey.measDate)),
                            label: const Text("Meas. Date"))
                      ])
                ],
              ),
            )),
      );
    }

    return Scaffold(
      appBar: const OurAppBar(LocaleKeys.dashboardTitle),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(
            CreateSurveyPage.routeName,
            extra: {
              CreateSurveyPage.keySurvey: SurveyHeadersCompanion(
                  measNum: const d.Value(-1),
                  measDate: d.Value(DateTime.now())),
              CreateSurveyPage.keyUpdateDash: updateDashboard
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: surveys.isEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 0.0, horizontal: kPaddingH),
              child: Center(
                child: const Text(
                  LocaleKeys.dashboardNoSurveys,
                  style: TextStyle(fontSize: kTextHeaderSize),
                ).tr(),
              ),
            )
          : ListView.builder(
              itemCount: (surveys).length,
              itemBuilder: (BuildContext cxt, int index) {
                SurveyHeader survey = surveys[index];
                return TitleCardDashboard(
                  surveyHeader: survey,
                  onTap: () async {
                    context.pushNamed(
                      SurveyInfoPage.routeName,
                      extra: {
                        SurveyInfoPage.keySurvey:
                            await db.surveyInfoTablesDao.getSurvey(survey.id),
                        SurveyInfoPage.keyCards: await db.getCards(survey.id),
                        SurveyInfoPage.keyUpdateDash: updateDashboard
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
