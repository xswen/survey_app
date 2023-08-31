import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/constants/constant_values.dart';

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
  SurveyInfoPage({super.key, required this.surveyHeader, required this.cards});
  final String title = "Survey Info Page";

  SurveyHeader surveyHeader;
  List<Map<String, dynamic>> cards;

  @override
  State<SurveyInfoPage> createState() => _SurveyInfoPageState();
}

class _SurveyInfoPageState extends State<SurveyInfoPage> {
  late SurveyHeader survey;
  late List<Map<String, dynamic>> cards;
  late List<Card> tileCards;

  @override
  void initState() {
    survey = widget.surveyHeader;
    cards = widget.cards;
    tileCards = _generateTileCards(widget.cards);
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
            Text(_checkAllComplete() ? "Complete" : "No"),
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

  bool _checkAllComplete() {
    for (int i = 0; i < cards.length; i++) {
      if (cards[i][kCardData] == null || !cards[i][kCardData].complete) {
        return false;
      }
    }
    return true;
  }

  List<Card> _generateTileCards(List<Map<String, dynamic>> cards) {
    List<Card> tileCards = [];

    String generateSubtitle(dynamic? data) {
      if (data == null) {
        return "Not started";
      } else if (data?.complete) {
        return "Complete";
      } else {
        return "In Progress";
      }
    }

    Color generateColour(dynamic? data) {
      if (data == null) {
        return Colors.blueGrey;
      } else if (data?.complete) {
        return Colors.grey;
      } else {
        return Colors.blue;
      }
    }

    for (int i = 0; i < cards.length; i++) {
      String name = cards[i][kCardTitleName];
      dynamic data = cards[i][kCardData];

      tileCards.add(Card(
        color: generateColour(data),
        child: ListTile(
          title: Text(
            name,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(generateSubtitle(data)),
          onTap: () {
            _getNav(name, data);
          },
        ),
      ));
    }

    return tileCards;
  }

  void _getNav(String cardName, dynamic? data) async {
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
              tileCards = _generateTileCards(value);
            }));
        break;
      case KCardNames.surfaceSubstrate:
        Popups.showDismiss(context, "Placeholder");
    }
  }
}
