import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constants/margins_padding.dart';
import '../../global.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_default.dart';
import '../../widgets/popups/popup_dismiss.dart';

class SiteInfoOriginPage extends StatefulWidget {
  const SiteInfoOriginPage({super.key, required this.title});
  final String title;

  @override
  State<SiteInfoOriginPage> createState() => _SiteInfoOriginPageState();
}

class _SiteInfoOriginPageState extends State<SiteInfoOriginPage> {
  bool complete = false;
  final PopupDismiss completeWarningPopup =
      Global.generateCompleteErrorPopup("Site Info Disturbance");

  String vegOrig = "";
  String regenType = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar(widget.title),
      floatingActionButton: FloatingCompleteButton(
        title: widget.title,
        complete: complete,
        onPressed: () async {
          if (complete) {
            //TODO: change complete to false
          } else {
            //TODO: error check
            _checkComplete()
                ? _update()
                : Get.dialog(const PopupDismiss(
                    title: "Error", contentText: "Please complete"));
          }
          setState(() {});
        },
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(
                kPaddingH, 0, kPaddingH, kPaddingV / 2),
            child: DropDownDefault(
                title: "Vegetation Cover Origin(s)",
                onBeforePopup: (String? s) async {
                  if (complete) {
                    Get.dialog(completeWarningPopup);
                    return false;
                  } else {
                    return true;
                  }
                },
                onChangedFn: (String? s) async {
                  vegOrig = s!;
                  setState(() {});
                },
                itemsList: [
                  "SUCC: The establishment of trees through secondary succession.",
                  "HARV: Regeneration after harvest.",
                  "DIST: Regeneration after other disturbance.",
                  "AFOR: Aforestation– the establishment"
                ],
                selectedItem: vegOrig),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(
                kPaddingH, 0, kPaddingH, kPaddingV / 2),
            child: DropDownDefault(
                title: "Type of Regeneration",
                onBeforePopup: (String? s) async {
                  if (complete) {
                    Get.dialog(completeWarningPopup);
                    return false;
                  } else {
                    return true;
                  }
                },
                onChangedFn: (String? s) async {
                  regenType = s!;
                  setState(() {});
                },
                itemsList: [
                  "NAT: Natural regeneration.",
                  "SUP: Natural regeneration with supplementary planting (< 50%).",
                  "PLA: Planted regeneration.",
                  "SOW: Seeded regeneration."
                ],
                selectedItem: regenType),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(
                kPaddingH, 0, kPaddingH, kPaddingV / 2),
            child: DataInput(
                readOnly: complete,
                title: "Disturbance Year",
                boxLabel:
                    "An estimate of the year of the disturbance. Enter -9 for not applicable (i.e. no disturbance). -1: Missing.",
                prefixIcon: FontAwesomeIcons.calendar,
                suffixVal: "year",
                inputType: const TextInputType.numberWithOptions(),
                startingStr: "",
                errorMsg: _errorDistYear(""),
                inputFormatters: [LengthLimitingTextInputFormatter(4)],
                onSubmit: (String s) {
                  //TODO: Handle Submit
                  setState(() {});
                }),
          ),
        ],
      ),
    );
  }

  bool _checkComplete() => true;
  void _update() => null;
  String? _errorDistYear(String s) => null;
}
