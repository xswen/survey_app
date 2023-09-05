import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../constants/margins_padding.dart';
import '../../../../database/database.dart';
import '../../../../widgets/box_increment.dart';
import '../../../../widgets/builders/decay_class_select_builder.dart';
import '../../../../widgets/hide_info_checkbox.dart';
import '../../../../widgets/popups/popup_continue.dart';
import '../../../../widgets/popups/popup_dismiss.dart';
import '../../../../widgets/popups/popups.dart';
import '../../../../widgets/text/text_header_separator.dart';

/// Widget for small woody debris input
class WoodyDebrisSmallPieceBuilder extends StatefulWidget {
  const WoodyDebrisSmallPieceBuilder(
      {Key? key, required this.wdSm, required this.complete})
      : super(key: key);

  final WoodyDebrisSmallData wdSm;
  final bool complete;

  @override
  State<WoodyDebrisSmallPieceBuilder> createState() =>
      _WoodyDebrisSmallPieceBuilderState();
}

class _WoodyDebrisSmallPieceBuilderState
    extends State<WoodyDebrisSmallPieceBuilder> {
  late WoodyDebrisSmallData wdSm;
  final PopupDismiss completeWarningPopup =
      Popups.generateCompleteErrorPopup("Transect");

  @override
  void initState() {
    wdSm = widget.wdSm;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);

    void updateWdSm(WoodyDebrisSmallCompanion entry) {
      (db.update(db.woodyDebrisSmall)..where((t) => t.id.equals(wdSm.id)))
          .write(entry);
      db.woodyDebrisTablesDao
          .getWdSmall(wdSm.wdHeaderId)
          .then((value) => setState(() => wdSm = value!));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: kPaddingV,
        ),
        const TextHeaderSeparator(
          title: "Small Woody Debris",
          sideWidget: SizedBox(),
        ),
        const SizedBox(
          height: kPaddingV,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
          child: Column(
            children: [
              HideInfoCheckbox(
                title: "Average decay class is assigned to all pieces of small "
                    "woody debris along each transect.",
                checkTitle: "Mark decay class as missing",
                checkValue: wdSm.swdDecayClass == -1,
                onChange: (b) {
                  if (widget.complete) {
                    Popups.show(context, completeWarningPopup);
                  } else {
                    b!
                        ? Popups.show(
                            context,
                            PopupContinue(
                              "Warning: Setting decay class as Missing",
                              contentText:
                                  "Are you sure you want to set decay class to missing?",
                              rightBtnOnPressed: () {
                                updateWdSm(const WoodyDebrisSmallCompanion(
                                    swdDecayClass: d.Value(-1)));
                                context.pop();
                              },
                            ))
                        : updateWdSm(const WoodyDebrisSmallCompanion(
                            swdDecayClass: d.Value(null)));
                  }
                },
                child: DecayClassSelectBuilder(
                  onChangedFn: (s) {
                    // changeMade = true;
                    // updateWdhCompanion(
                    //     wdh.copyWith(swdDecayClass: d.Value(int.parse(s!))));
                  },
                  selectedItem: wdSm.swdDecayClass == null
                      ? "Select Decay Class"
                      : wdSm.swdDecayClass.toString(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: kPaddingV * 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BoxIncrement(
              title: "Class 1",
              subtitle: "1.1 - 3.0cm",
              boxVal: wdSm.swdTallyS.toString(),
              minusOnPress: () {
                widget.complete
                    ? Popups.show(context, completeWarningPopup)
                    : (wdSm.swdTallyS > 0
                        ? updateWdSm(WoodyDebrisSmallCompanion(
                            swdTallyS: d.Value(wdSm.swdTallyS - 1)))
                        : null);
              },
              addOnPress: () => widget.complete
                  ? Popups.show(context, completeWarningPopup)
                  : updateWdSm(WoodyDebrisSmallCompanion(
                      swdTallyS: d.Value(wdSm.swdTallyS + 1))),
            ),
            BoxIncrement(
              title: "Class 2",
              subtitle: "3.1 - 5.0cm",
              boxVal: wdSm.swdTallyM.toString(),
              minusOnPress: () {
                widget.complete
                    ? Popups.show(context, completeWarningPopup)
                    : wdSm.swdTallyM > 0
                        ? updateWdSm(WoodyDebrisSmallCompanion(
                            swdTallyM: d.Value(wdSm.swdTallyM - 1)))
                        : null;
              },
              addOnPress: () => widget.complete
                  ? Popups.show(context, completeWarningPopup)
                  : updateWdSm(WoodyDebrisSmallCompanion(
                      swdTallyM: d.Value(wdSm.swdTallyM + 1))),
            ),
            BoxIncrement(
              title: "Class 3",
              subtitle: "5.1 - 7.5cm",
              boxVal: wdSm.swdTallyL.toString(),
              minusOnPress: () {
                widget.complete
                    ? Popups.show(context, completeWarningPopup)
                    : (wdSm.swdTallyL > 0
                        ? updateWdSm(WoodyDebrisSmallCompanion(
                            swdTallyL: d.Value(wdSm.swdTallyL - 1)))
                        : null);
              },
              addOnPress: () => widget.complete
                  ? Popups.show(context, completeWarningPopup)
                  : updateWdSm(WoodyDebrisSmallCompanion(
                      swdTallyL: d.Value(wdSm.swdTallyL - 1))),
            ),
          ],
        ),
      ],
    );
  }
}
