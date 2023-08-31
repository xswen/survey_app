import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/constants/constant_values.dart';
import 'package:survey_app/enums/enums.dart';
import 'package:survey_app/widgets/selection_tile_card.dart';

import '../../constants/card_names.dart';
import '../../constants/margins_padding.dart';
import '../../database/database.dart';
import '../../formatters/format_date.dart';
import '../../routes/route_names.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/popups/popups.dart';
import '../../widgets/text/text_line_label.dart';
import '../../widgets/titled_border.dart';

class SurveyInfoPage extends StatefulWidget {
  const SurveyInfoPage(
      {super.key, required this.surveyHeader, required this.cards});
  final String title = "Survey Info Page";

  final SurveyHeader surveyHeader;
  final List<Map<String, dynamic>> cards;

  @override
  State<SurveyInfoPage> createState() => _SurveyInfoPageState();
}

class _SurveyInfoPageState extends State<SurveyInfoPage> {
  late SurveyHeader survey;
  late List<Map<String, dynamic>> cards;
  late List<SelectionTileCard> tileCards;

  @override
  void initState() {
    survey = widget.surveyHeader;
    cards = widget.cards;
    tileCards = generateTileCards(widget.cards);
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
            Text(checkAllComplete() ? "Complete" : "No"),
            Expanded(
              child: ListView(
                children: tileCards,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool checkAllComplete() {
    for (int i = 0; i < cards.length; i++) {
      if (cards[i][kCardData] == null || !cards[i][kCardData].complete) {
        return false;
      }
    }
    return true;
  }

  List<SelectionTileCard> generateTileCards(List<Map<String, dynamic>> cards) {
    List<SelectionTileCard> tileCards = [];

    SurveyStatus getStatus(dynamic data) {
      if (data == null) {
        return SurveyStatus.notStarted;
      } else if (data?.complete) {
        return SurveyStatus.complete;
      } else {
        return SurveyStatus.inProgress;
      }
    }

    for (int i = 0; i < cards.length; i++) {
      String name = cards[i][kCardTitleName];
      dynamic data = cards[i][kCardData];

      tileCards.add(SelectionTileCard(
          title: name,
          status: getStatus(data),
          onPressed: () => getNav(name, data)));
    }

    return tileCards;
  }

  void getNav(String cardName, dynamic data) async {
    final Database db = Database.instance;

    switch (cardName) {
      case KCardNames.woodyDebris:
        var tmp = await context.pushNamed(
          Routes.woodyDebris,
          extra: data == null
              ?
              //Insert empty wdSummaryCompanion
              {
                  "wdSummaryData": await db.woodyDebrisTablesDao
                      .addAndReturnDefaultWdSummary(survey.id, survey.measDate),
                  "transList": <WoodyDebrisHeaderData>[]
                }
              : {
                  "wdSummaryData": data,
                  "transList": await db.woodyDebrisTablesDao
                      .getWdHeadersFromWdsId(data.id)
                },
        );

        db.getCards(widget.surveyHeader.id).then((value) => setState(() {
              cards = value;
              tileCards = generateTileCards(value);
            }));
        break;
      case KCardNames.surfaceSubstrate:
        Popups.showDismiss(context, "Placeholder");
    }
  }
}
