import 'dart:collection';

import 'package:drift/drift.dart' as d;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/constants/text_designs.dart';
import 'package:survey_app/l10n/locale_keys.g.dart';
import 'package:survey_app/widgets/drawer_menu.dart';

import '../../constants/margins_padding.dart';
import '../../database/database.dart';
import '../../enums/enums.dart';
import '../../widgets/app_bar.dart';
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
  HashSet<SurveyStatus> filters = HashSet<SurveyStatus>();

  @override
  void initState() {
    surveys = widget.surveys;
    super.initState();
  }

  @override
  Scaffold build(BuildContext context) {
    final db = Provider.of<Database>(context);

    void updateDashboard() {
      db.surveyInfoTablesDao
          .getSurveysFiltered(filters)
          .then((value) => setState(() => surveys = value));
    }

    //Add or remove filter based on select and set state after call on db
    // to update. Status set to null if "All" is selected
    void filterOnSelect(bool selected, SurveyStatus? status) async {
      if (selected) {
        status == null
            ? filters = HashSet<SurveyStatus>()
            : filters.add(status);
      } else {
        status == null
            ? filters = HashSet<SurveyStatus>.of({
                SurveyStatus.complete,
                SurveyStatus.inProgress,
              })
            : filters.remove(status);
      }

      surveys = await db.surveyInfoTablesDao.getSurveysFiltered(filters);
      setState(() {});
    }

    return Scaffold(
      appBar: const OurAppBar(LocaleKeys.dashboardTitle),
      endDrawer: DrawerMenu(
        onLocaleChange: () => setState(() {}),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Create New Survey"),
        icon: Icon(FontAwesomeIcons.circlePlus),
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
          : Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: kPaddingH,
                  children: [
                    FilterChip(
                      backgroundColor: Colors.tealAccent[200],
                      label: const Text("All"),
                      selected: filters.isEmpty,
                      onSelected: (selected) async =>
                          filterOnSelect(selected, null),
                      selectedColor: Colors.purpleAccent,
                    ),
                    FilterChip(
                      backgroundColor: Colors.tealAccent[200],
                      label: const Text("Completed"),
                      selected: filters.contains(SurveyStatus.complete),
                      onSelected: (selected) async =>
                          filterOnSelect(selected, SurveyStatus.complete),
                      selectedColor: Colors.purpleAccent,
                    ),
                    FilterChip(
                      backgroundColor: Colors.tealAccent[200],
                      label: const Text("In Progress"),
                      selected: filters.contains(SurveyStatus.inProgress),
                      onSelected: (selected) async =>
                          filterOnSelect(selected, SurveyStatus.inProgress),
                      selectedColor: Colors.purpleAccent,
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: (surveys).length,
                    itemBuilder: (BuildContext cxt, int index) {
                      SurveyHeader survey = surveys[index];
                      return TitleCardDashboard(
                        surveyHeader: survey,
                        onTap: () async {
                          context.pushNamed(
                            SurveyInfoPage.routeName,
                            extra: {
                              SurveyInfoPage.keySurvey: await db
                                  .surveyInfoTablesDao
                                  .getSurvey(survey.id),
                              SurveyInfoPage.keyCards:
                                  await db.getCards(survey.id),
                              SurveyInfoPage.keyUpdateDash: updateDashboard
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
