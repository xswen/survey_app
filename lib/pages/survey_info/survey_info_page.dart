import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../constants/margins_padding.dart';
import '../../database/database.dart';
import '../../formatters/format_date.dart';
import '../../routes/route_names.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/text/text_line_label.dart';
import '../../widgets/titled_border.dart';

class SurveyInfoPage extends StatefulWidget {
  SurveyInfoPage({super.key, required this.surveyHeader, required this.cards});
  final String title = "Survey Info Page";

  SurveyHeader surveyHeader;
  List<Map<String, dynamic>> cards;

  @override
  State<SurveyInfoPage> createState() => _SurveyInfoPageState();
}

class _SurveyInfoPageState extends State<SurveyInfoPage> {
  late SurveyHeader survey;

  @override
  void initState() {
    survey = widget.surveyHeader;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);
    return Scaffold(
      appBar: OurAppBar(backFn: () async {
        context.goNamed(Routes.dashboard,
            extra: await db.surveyInfoTablesDao.allSurveys);
      }, widget.title),
      body: Center(
        child: Column(
          children: [
            //Header Data
            TitledBorder(
                title: "Header Data",
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextLineLabelTop(
                                value: Text(survey.province),
                                label: const Text("Jurisdiction")),
                            TextLineLabelTop(
                                value: Text(survey.nfiPlot.toString()),
                                label: const Text("Plot Number")),
                          ],
                        ),
                        kDividerV,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextLineLabelTop(
                                value: Text(survey.measNum.toString()),
                                label: const Text("Meas. Number")),
                            TextLineLabelTop(
                                value: Text(FormatDate.toStr(survey.measDate)),
                                label: const Text("Meas. Date")),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
            const Divider(
              thickness: 2,
            ),
            Expanded(
              child: ListView(
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<int> _createTransNumList(int numTransects) {
    List<int> result = [];

    for (int i = 0; i < numTransects; i++) {
      result.add(i + 1);
    }

    return result;
  }

  bool _checkAllComplete() {
    return true;
  }
}
