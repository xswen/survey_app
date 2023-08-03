import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/margins_padding.dart';
import '../../database/database.dart';
import '../../formatters/format_date.dart';
import '../../routes/route_names.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/text/text_line_label.dart';

class SurveyInfoSelect extends StatefulWidget {
  const SurveyInfoSelect({super.key, required this.title});

  final String title;

  @override
  State<SurveyInfoSelect> createState() => _SurveyInfoSelectState();
}

class _SurveyInfoSelectState extends State<SurveyInfoSelect> {
  final _db = Get.find<Database>();
  List<SurveyHeader> surveys = Get.arguments;
  int idx = 0;

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar(widget.title),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var temp = await Get.toNamed(Routes.surveyInfoCreate);
          setState(() {
            _db.surveyInfoTablesDao.allSurveys
                .then((value) => setState(() => surveys = value));
          });
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: surveys.length,
        itemBuilder: (BuildContext cxt, int index) {
          return _createSurveyButton(index);
        },
      ),
    );
  }

  Widget _createSurveyButton(int index) {
    SurveyHeader survey = surveys[index];

    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: kPaddingH, vertical: kPaddingV / 2),
      child: ElevatedButton(
          onPressed: () async {
            Get.toNamed(Routes.surveyInfoPage,
                arguments:
                    (await _db.surveyInfoTablesDao.getSurvey(survey.id)));
            setState(() {
              _db.surveyInfoTablesDao.allSurveys
                  .then((value) => setState(() => surveys = value));
            });
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
