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
import '../../widgets/popups/popup_dismiss_dep.dart';

class SiteInfoDisturbancePage extends StatefulWidget {
  const SiteInfoDisturbancePage({super.key, required this.title});
  final String title;

  @override
  State<SiteInfoDisturbancePage> createState() =>
      _SiteInfoDisturbancePageState();
}

class _SiteInfoDisturbancePageState extends State<SiteInfoDisturbancePage> {
  bool complete = false;
  String mort = "";
  String agent = "";
  final PopupDismissDep completeWarningPopup =
      Global.generateCompleteErrorPopup("Site Info Disturbance");

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
                : Get.dialog(const PopupDismissDep(
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
                title: "Natural Disturbance Agent",
                onBeforePopup: (String? s) async {
                  if (complete) {
                    Get.dialog(completeWarningPopup);
                    return false;
                  } else {
                    return true;
                  }
                },
                onChangedFn: (String? s) async {
                  agent = s!;
                  setState(() {});
                },
                itemsList: [
                  "FIRE: Plot has experienced a fire.",
                  "WIND: Vegetation in plot has experienced windthrow.",
                  "SNOW: Vegetation in plot has experienced significant snow damage."
                ],
                selectedItem: agent),
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
                inputType: const TextInputType.numberWithOptions(signed: true),
                startingStr: "",
                errorMsg: _errorDistYear(""),
                inputFormatters: [LengthLimitingTextInputFormatter(4)],
                onSubmit: (String s) {
                  //TODO: Handle Submit
                  setState(() {});
                }),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(
                kPaddingH, 0, kPaddingH, kPaddingV / 2),
            child: DataInput(
                readOnly: complete,
                title: "Extent of Disturbance",
                boxLabel:
                    "For the purposes of this inventory, a disturbance is described as a discreet force that has caused significant change in structure and/or composition of the plot vegetation. -1: Missing.",
                prefixIcon: FontAwesomeIcons.percent,
                suffixVal: "%",
                inputType: const TextInputType.numberWithOptions(signed: true),
                startingStr: "",
                errorMsg: _errorDistYear(""),
                inputFormatters: [LengthLimitingTextInputFormatter(4)],
                onSubmit: (String s) {
                  //TODO: Handle Submit
                  setState(() {});
                }),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(
                kPaddingH, 0, kPaddingH, kPaddingV / 2),
            child: DataInput(
                readOnly: complete,
                title: "Tree Mortality",
                boxLabel:
                    "Extent of tree mortality, within the disturbed area, reported to the nearest percent. Enter -1 for missing data. Enter -9 if there are no trees in the plot.",
                prefixIcon: FontAwesomeIcons.percent,
                suffixVal: "%",
                inputType: const TextInputType.numberWithOptions(signed: true),
                startingStr: "",
                errorMsg: _errorDistYear(""),
                inputFormatters: [LengthLimitingTextInputFormatter(3)],
                onSubmit: (String s) {
                  //TODO: Handle Submit
                  setState(() {});
                }),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(
                kPaddingH, 0, kPaddingH, kPaddingV / 2),
            child: DropDownDefault(
                title: "Mortality Basis",
                onBeforePopup: (String? s) async {
                  if (complete) {
                    Get.dialog(completeWarningPopup);
                    return false;
                  } else {
                    return true;
                  }
                },
                onChangedFn: (String? s) async {
                  mort = s!;
                  setState(() {});
                },
                itemsList: [
                  "VL: Volume",
                  "BA: Basal area",
                  "CA: Crown area",
                  "ST: Stem numbers"
                ],
                selectedItem: mort),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(
                kPaddingH, 0, kPaddingH, kPaddingV / 2),
            child: DataInput(
                readOnly: complete,
                title: "Specific Disturbance Comments",
                boxLabel: "A data field for comments. Do not use commas.",
                prefixIcon: FontAwesomeIcons.percent,
                suffixVal: "%",
                startingStr: "",
                errorMsg: _errorDistYear(""),
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
  String? _errorDistYear(String year) => null;
}
