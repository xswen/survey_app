import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/database/database.dart';

import '../../../widgets/app_bar.dart';
import '../../../widgets/buttons/floating_complete_button.dart';
import '../../../widgets/popups/popup_dismiss.dart';
import '../../../widgets/popups/popups.dart';

class WoodyDebrisHeaderPieceMain extends StatefulWidget {
  static const keyWdSmall = "wdSmall";
  static const keyTransNum = "transNum";
  static const keyTransComplete = "transectComplete";
  const WoodyDebrisHeaderPieceMain(
      {Key? key,
      required this.wdSmall,
      required this.transNum,
      required this.transComplete})
      : super(key: key);

  final WoodyDebrisSmallData wdSmall;
  final int transNum;
  final bool transComplete;
  @override
  State<WoodyDebrisHeaderPieceMain> createState() =>
      _WoodyDebrisHeaderPieceMainState();
}

class _WoodyDebrisHeaderPieceMainState
    extends State<WoodyDebrisHeaderPieceMain> {
  String get title => "tmp";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    final db = Provider.of<Database>(context);
    final PopupDismiss completeWarningPopup =
        Popups.generateCompleteErrorPopup(context, title);
    final PopupDismiss surveyCompleteWarningPopup =
        Popups.generatePreviousMarkedCompleteErrorPopup(context, "Survey");
    d.Value(1);
    return Scaffold(
      appBar: OurAppBar("$title"),
      floatingActionButton: FloatingCompleteButton(
        title: "",
        complete: false,
        onPressed: () {},
      ),
      body: Center(
        child: Text("hi"),
      ),
    );
  }
}
