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

class SiteInfoTreatmentPage extends StatefulWidget {
  const SiteInfoTreatmentPage({super.key, required this.title});
  final String title;

  @override
  State<SiteInfoTreatmentPage> createState() => _SiteInfoTreatmentPageState();
}

class _SiteInfoTreatmentPageState extends State<SiteInfoTreatmentPage> {
  bool complete = false;
  final PopupDismiss completeWarningPopup =
      Global.generateCompleteErrorPopup("Site Info Disturbance");

  String treatType = "";

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
                title: "Treatment Type",
                onBeforePopup: (String? s) async {
                  if (complete) {
                    Get.dialog(completeWarningPopup);
                    return false;
                  } else {
                    return true;
                  }
                },
                onChangedFn: (String? s) async {
                  treatType = s!;
                  setState(() {});
                },
                itemsList: [
                  "CT: Commercial thinning – partial cut in older immature stands.",
                  "FT: Fertilization",
                  "SP: Mechanical site preparation",
                  "PB: Prescribed burning"
                ],
                selectedItem: treatType),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(
                kPaddingH, 0, kPaddingH, kPaddingV / 2),
            child: DataInput(
                readOnly: complete,
                title: "Treatment Year",
                boxLabel:
                    "An estimate of the year of treatment. Enter -9 for not applicable (i.e. no disturbance). -1: Missing.",
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
                title: "Treatment Percentage",
                boxLabel:
                    "Extent of treatment, expressed as a percentage of the total plot area. Enter -9 for not applicable (i.e. no disturbance). -1: Missing.",
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
        ],
      ),
    );
  }

  bool _checkComplete() => true;
  void _update() => null;
  String? _errorDistYear(String s) => null;
}
