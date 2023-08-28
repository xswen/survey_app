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
import '../../routes/route_names.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/text/text_line_label.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key, required this.title, required this.surveys});

  final String title;
  List<SurveyHeader> surveys;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int idx = 0;
  @override
  Scaffold build(BuildContext context) {
    final db = Provider.of<Database>(context);
    return Scaffold(
      appBar: const OurAppBar(LocaleKeys.dashboardTitle),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var temp = await context.pushNamed(
            Routes.createSurvey,
            extra: SurveyHeadersCompanion(
                measNum: const d.Value(-1), measDate: d.Value(DateTime.now())),
          );
          setState(() {
            db.surveyInfoTablesDao.allSurveys
                .then((value) => setState(() => widget.surveys = value));
          });
        },
        child: const Icon(Icons.add),
      ),
      body: widget.surveys.isEmpty
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
              itemCount: (widget.surveys ?? []).length,
              itemBuilder: (BuildContext cxt, int index) {
                return _createSurveyButton(index);
              },
            ),
    );
  }

  Widget _createSurveyButton(int index) {
    SurveyHeader survey = (widget.surveys ?? [])[index];

    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: kPaddingH, vertical: kPaddingV / 2),
      child: ElevatedButton(
          onPressed: () async {
            // Get.toNamed(Routes.surveyInfoPage,
            //     arguments:
            //         (await _db.surveyInfoTablesDao.getSurvey(survey.id)));
            // setState(() {
            //   _db.surveyInfoTablesDao.allSurveys
            //       .then((value) => setState(() => surveys = value));
            // });
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
}
