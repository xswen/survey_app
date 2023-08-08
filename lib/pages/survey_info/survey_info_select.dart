import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/l10n/locale_keys.g.dart';

import '../../constants/margins_padding.dart';
import '../../database/database.dart';
import '../../formatters/format_date.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/text/text_line_label.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key, required this.title, required this.surveys});

  final String title;
  List<SurveyHeader>? surveys;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final String title = LocaleKeys.dashboardTitle;
  int idx = 0;

  @override
  Scaffold build(BuildContext context) {
    final db = Provider.of<Database>(context);
    return Scaffold(
      appBar: OurAppBar(widget.title),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // var temp = await Get.toNamed(Routes.surveyInfoCreate);
          // setState(() {
          //   _db.surveyInfoTablesDao.allSurveys
          //       .then((value) => setState(() => surveys = value));
          // });
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
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
