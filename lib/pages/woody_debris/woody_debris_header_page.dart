import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/widgets/popups/popup_continue.dart';

import '../../constants/margins_padding.dart';
import '../../database/database.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/buttons/icon_nav_button.dart';
import '../../widgets/popups/popup_dismiss.dart';
import '../../widgets/popups/popups.dart';

class WoodyDebrisHeaderPage extends StatefulWidget {
  static const String keyWdHeader = "wdHeader";
  static const String keySummaryComplete = "summaryComplete";

  const WoodyDebrisHeaderPage(
      {Key? key, required this.wdh, required this.summaryComplete})
      : super(key: key);

  final WoodyDebrisHeaderData wdh;
  final bool summaryComplete;

  @override
  State<WoodyDebrisHeaderPage> createState() => _WoodyDebrisHeaderPageState();
}

class _WoodyDebrisHeaderPageState extends State<WoodyDebrisHeaderPage> {
  String get title => "Woody Debris Transect";

  late WoodyDebrisHeaderData wdh;
  late bool summaryComplete;

  @override
  void initState() {
    wdh = widget.wdh;
    summaryComplete = widget.summaryComplete;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);
    final PopupDismiss completeWarningPopup =
        Popups.generateCompleteErrorPopup(context, title);
    final PopupDismiss surveyCompleteWarningPopup =
        Popups.generatePreviousMarkedCompleteErrorPopup(
            context, "Woody Debris");

    return Scaffold(
      appBar: OurAppBar("Woody Debris: Transect ${wdh.transNum}"),
      floatingActionButton: FloatingCompleteButton(
        title: title,
        complete: wdh.complete,
        onPressed: () {
          if (summaryComplete) {
            Popups.show(context, surveyCompleteWarningPopup);
          } else {
            db.woodyDebrisTablesDao.getWdSmall(wdh.id).then((value) {
              Popups.show(context, PopupContinue("Test", "text"));
              // Popups.showDismiss(context, "Error",
              //     contentWidget: PopupContentFormat(
              //       titles: ["hi"],
              //       details: ["lol"],
              //     ));
            });
          }
        },
      ),
      body: Center(
        child: Column(
          children: [
            IconNavButton(
              icon: const Icon(FontAwesomeIcons.ruler),
              space: kPaddingIcon,
              label: "Piece Measurements",
              onPressed: () async {
                //TODO: Add woodyDebrisSmall
                //  WoodyDebrisSmallData? wdSm = await _getOrCreateWdSmall();
                //
                //  wdSm == null
                //      ? printError(info: "Small Wd returned null")
                //      : Get.toNamed(Routes.woodyDebrisPieceMain, arguments: {
                //    "wdSmall": (wdSm),
                //    "transNum": wdh.transNum,
                //    "transectComplete": wdh.complete,
                //  });
              },
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV, horizontal: kPaddingH),
            ),
            IconNavButton(
              icon: const Icon(FontAwesomeIcons.penToSquare),
              space: kPaddingIcon,
              label: "Edit Transect",
              onPressed: () {
                //TODO: Add Deletion
                //_deleteTransect(context);
              },
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV, horizontal: kPaddingH),
            ),
            IconNavButton(
              icon: const Icon(FontAwesomeIcons.trash),
              space: kPaddingIcon,
              label: "Delete Transect",
              onPressed: () {
                //TODO: Add Deletion
                //_deleteTransect(context);
              },
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV, horizontal: kPaddingH),
            ),
          ],
        ),
      ),
    );
  }
}
