import 'package:drift/drift.dart' as d;
import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants/margins_padding.dart';
import '../../database/database.dart';
import '../../formatters/format_date.dart';
import '../../routes/route_names.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/text/text_line_label.dart';
import '../../widgets/titled_border.dart';

class SurveyInfoPage extends StatefulWidget {
  SurveyInfoPage({super.key, required this.surveyHeader});
  final String title = "Survey Info Page";

  SurveyHeader surveyHeader;

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
      appBar: OurAppBar(widget.title),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: const Text(
                    "Field Cards",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      WoodyDebrisSummaryData? wdSummary = await (db
                              .select(db.woodyDebrisSummary)
                            ..where((tbl) => tbl.surveyId.equals(survey.id)))
                          .getSingleOrNull();

                      wdSummary ??
                          db.woodyDebrisTablesDao.addWdSummary(
                              WoodyDebrisSummaryCompanion(
                                  surveyId: d.Value(survey.id),
                                  measDate: d.Value(survey.measDate)));

                      WoodyDebrisSummaryData wd =
                          await db.woodyDebrisTablesDao.getWdSummary(survey.id);
                      List<WoodyDebrisHeaderData> transList = await db
                          .woodyDebrisTablesDao
                          .getWdHeadersFromWdsId(wd.id);
                      Get.toNamed(Routes.woodyDebris,
                          arguments: [wd, transList]);
                    },
                    child: const Text("Woody Debris")),
                ElevatedButton(
                    onPressed: () async {
                      SurfaceSubstrateSummaryData? ssH = await db
                          .surfaceSubstrateTablesDao
                          .getSsSummary(survey.id);

                      if (ssH == null) {
                        db.surfaceSubstrateTablesDao
                            .addSsSummary(SurfaceSubstrateSummaryCompanion(
                          surveyId: d.Value(survey.id),
                          measDate: d.Value(survey.measDate),
                        ));

                        ssH = await db.surfaceSubstrateTablesDao
                            .getSsSummary(survey.id);
                      }

                      if (ssH != null) {
                        List<SurfaceSubstrateHeaderData> transList = await db
                            .surfaceSubstrateTablesDao
                            .getSsHeaderWithSshId(ssH.id);
                        Get.toNamed(Routes.surfaceSubstrate,
                            arguments: [ssH, transList]);
                      } else {
                        printError(
                            info:
                                "Surface substrate was not added for ${survey.toString()}");
                      }
                    },
                    child: const Text("Surface Substrate")),
                ElevatedButton(
                    //ECP
                    onPressed: () async {
                      EcpSummaryData? ecpS = await db.ecologicalPlotTablesDao
                          .getSummaryWithSurveyId(survey.id);

                      if (ecpS == null) {
                        db.ecologicalPlotTablesDao
                            .addSummary(EcpSummaryCompanion(
                          surveyId: d.Value(survey.id),
                          measDate: d.Value(survey.measDate),
                        ));

                        ecpS = await db.ecologicalPlotTablesDao
                            .getSummaryWithSurveyId(survey.id);
                      }

                      if (ecpS != null) {
                        List<EcpHeaderData> ecpList = await db
                            .ecologicalPlotTablesDao
                            .getHeaderWithEcpSummryId(ecpS.id);

                        Get.toNamed(Routes.ecologicalPlot,
                            arguments: [ecpS, ecpList]);
                      } else {
                        printError(
                            info: "ECP was not added for ${survey.toString()}");
                      }
                    },
                    child: const Text("Ecological Plot")),
                ElevatedButton(
                    //ECP
                    onPressed: () async {
                      //TODO: get data and send it over
                      Get.toNamed(Routes.siteInfo);
                    },
                    child: const Text("Site Info")),
                ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.soilPit);
                    },
                    child: const Text("Soil Pit")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DriftDbViewer(db)));
                    },
                    child: const Text("Large Tree Plot")),
              ],
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
}
