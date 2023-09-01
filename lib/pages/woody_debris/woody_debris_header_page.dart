import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/database.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/popups/popups.dart';

class WoodyDebrisHeaderPage extends StatefulWidget {
  const WoodyDebrisHeaderPage(
      {Key? key, required this.wdh, required this.summaryComplete})
      : super(key: key);

  final WoodyDebrisHeaderData wdh;
  final bool summaryComplete;

  static const String keyWdHeader = "wdHeader";
  static const String keySummaryComplete = "summaryComplete";

  @override
  State<WoodyDebrisHeaderPage> createState() => _WoodyDebrisHeaderPageState();
}

class _WoodyDebrisHeaderPageState extends State<WoodyDebrisHeaderPage> {
  String get title => "Transect";

  late WoodyDebrisHeaderData wdh;
  late bool summaryComplete;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);
    final CupertinoAlertDialog completeWarningPopup =
        Popups.generateCompleteErrorPopup(context, title);
    final CupertinoAlertDialog surveyCompleteWarningPopup =
        Popups.generatePreviousMarkedCompleteErrorPopup(
            context, "Woody Debris");

    return Scaffold(
      appBar: const OurAppBar(""),
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
