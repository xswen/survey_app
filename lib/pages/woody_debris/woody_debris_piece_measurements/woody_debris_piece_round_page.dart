import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_app/database/database.dart';

import '../../../widgets/app_bar.dart';
import '../../../widgets/buttons/floating_complete_button.dart';
import '../../../widgets/popups/popup_dismiss.dart';
import '../../../widgets/popups/popups.dart';

class WoodyDebrisPieceRoundPage extends StatefulWidget {
  static const String routeName = "woodyDebrisPieceRound";
  const WoodyDebrisPieceRoundPage({Key? key, required this.piece})
      : super(key: key);

  final WoodyDebrisRoundCompanion piece;
  @override
  State<WoodyDebrisPieceRoundPage> createState() =>
      _WoodyDebrisPieceRoundPageState();
}

class _WoodyDebrisPieceRoundPageState extends State<WoodyDebrisPieceRoundPage> {
  final Database db = Database.instance;

  final String title = "tmp";
  final controller = TextEditingController();
  final int kDataMissing = -1;

  late WoodyDebrisRoundCompanion piece;
  late String genusCode;
  late String speciesName;
  //static final ErrorWoodyDebrisPiece _error = ErrorWoodyDebrisPiece();
  @override
  void initState() {
    piece = widget.piece;
    genusCode = db.companionValueToStr(piece.genus);
    speciesName = db.companionValueToStr(piece.species);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    final PopupDismiss completeWarningPopup =
        Popups.generateCompleteErrorPopup(title);
    final PopupDismiss surveyCompleteWarningPopup =
        Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

    return Scaffold(
      appBar: OurAppBar("$title"),
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
