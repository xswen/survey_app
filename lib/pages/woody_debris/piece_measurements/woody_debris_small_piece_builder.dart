import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/margins_padding.dart';
import '../../../database/database.dart';
import '../../../global.dart';
import '../../../widgets/box_increment.dart';
import '../../../widgets/builders/decay_class_select_builder.dart';
import '../../../widgets/popups/popup_continue.dart';
import '../../../widgets/popups/popup_dismiss.dart';
import '../../../widgets/text/text_header_separator.dart';

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
    extends State<WoodyDebrisSmallPieceBuilder> with Global {
  final _db = Get.find<Database>();
  late WoodyDebrisSmallData wdSm;

  final PopupDismiss completeWarningPopup =
      Global.generateCompleteErrorPopup("Transect");

  @override
  void initState() {
    wdSm = widget.wdSm;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              DecayClassSelectBuilder(
                title:
                    "Average decay class is assigned to all pieces of small woody debris along each transect.",
                checkValue: wdSm.swdDecayClass == -1,
                checkOnChange: (decayClassMissing) {
                  if (widget.complete) {
                    Get.dialog(completeWarningPopup);
                  } else if (decayClassMissing != null && decayClassMissing) {
                    Get.dialog(PopupContinue(
                      title: "Warning Missing Field",
                      content: "Are you sure you want to set as missing?",
                      rightBtnOnPressed: () {
                        _updateSm(swdDecayClass: const d.Value(-1));
                        Get.back();
                      },
                    ));
                  } else {
                    _updateSm(swdDecayClass: const d.Value(null));
                  }
                },
                onBeforePopup: (String? s) async {
                  if (widget.complete) {
                    Get.dialog(completeWarningPopup);
                    return false;
                  }
                  return true;
                },
                onChangedFn: (String? s) {
                  widget.complete
                      ? Get.dialog(completeWarningPopup)
                      : _updateSm(swdDecayClass: d.Value(int.parse(s!)));
                },
                selectedItem: Global.nullableToStr(wdSm.swdDecayClass),
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
                    ? Get.dialog(completeWarningPopup)
                    : (wdSm.swdTallyS > 0
                        ? _updateSm(swdTallyS: wdSm.swdTallyS - 1)
                        : null);
              },
              addOnPress: () => widget.complete
                  ? Get.dialog(completeWarningPopup)
                  : _updateSm(swdTallyS: wdSm.swdTallyS + 1),
            ),
            BoxIncrement(
                title: "Class 2",
                subtitle: "3.1 - 5.0cm",
                boxVal: wdSm.swdTallyM.toString(),
                minusOnPress: () {
                  widget.complete
                      ? Get.dialog(completeWarningPopup)
                      : (wdSm.swdTallyM > 0
                          ? _updateSm(swdTallyM: wdSm.swdTallyM - 1)
                          : null);
                },
                addOnPress: () => widget.complete
                    ? Get.dialog(completeWarningPopup)
                    : _updateSm(swdTallyM: wdSm.swdTallyM + 1)),
            BoxIncrement(
                title: "Class 3",
                subtitle: "5.1 - 7.5cm",
                boxVal: wdSm.swdTallyL.toString(),
                minusOnPress: () {
                  widget.complete
                      ? Get.dialog(completeWarningPopup)
                      : (wdSm.swdTallyL > 0
                          ? _updateSm(swdTallyL: wdSm.swdTallyL - 1)
                          : null);
                },
                addOnPress: () => widget.complete
                    ? Get.dialog(completeWarningPopup)
                    : _updateSm(swdTallyL: wdSm.swdTallyL + 1)),
          ],
        ),
      ],
    );
  }

  void _updateSm(
      {int? swdTallyS,
      int? swdTallyM,
      int? swdTallyL,
      d.Value<int?> swdDecayClass = const d.Value.absent()}) {
    setState(() => wdSm = wdSm.copyWith(
        swdTallyS: swdTallyS ?? wdSm.swdTallyS,
        swdTallyM: swdTallyM ?? wdSm.swdTallyM,
        swdTallyL: swdTallyL ?? wdSm.swdTallyL,
        swdDecayClass: d.Value(
            swdDecayClass.present ? swdDecayClass.value : wdSm.swdDecayClass)));

    (_db.update(_db.woodyDebrisSmall)..where((t) => t.id.equals(wdSm.id)))
        .write(wdSm);
  }
}
