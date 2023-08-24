import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constants/margins_padding.dart';
import '../../global.dart';
import '../../routes/route_names.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/buttons/icon_nav_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/date_select.dart';
import '../../widgets/dropdowns/drop_down_default.dart';
import '../../widgets/popups/popup_dismiss_dep.dart';

class SiteInfoSummary extends StatefulWidget {
  const SiteInfoSummary({super.key, required this.title});
  final String title;

  @override
  State<SiteInfoSummary> createState() => _SiteInfoSummaryState();
}

class _SiteInfoSummaryState extends State<SiteInfoSummary> {
  bool complete = false;
  DateTime date = DateTime.now();
  String comp = "";
  String reason = "";

  final PopupDismissDep completeWarningPopup =
      Global.generateCompleteErrorPopup("Site Info");

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
            _checkSummaryComplete()
                ? _updateSummary()
                : Get.dialog(const PopupDismissDep(
                    title: "Error", contentText: "Please complete"));
          }
          setState(() {});
        },
      ),
      body: Center(
        child: ListView(
          children: [
            CalendarSelect(
                date: date,
                label: "Enter Measurement Date",
                readOnly: complete,
                readOnlyPopup: completeWarningPopup,
                setStateFn: (DateTime date) async {
                  //TODO: Update Summary
                  _updateSummary();

                  setState(() {});
                }),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              child: DropDownDefault(
                  title: "Plot Completion",
                  onBeforePopup: (String? s) async {
                    if (complete) {
                      Get.dialog(completeWarningPopup);
                      return false;
                    } else {
                      return true;
                    }
                  },
                  onChangedFn: (String? s) async {
                    comp != s ? reason = "" : null;
                    comp = s!;
                    setState(() {});
                  },
                  itemsList: ["F: Full", "P: Partial"],
                  selectedItem: comp),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              child: DropDownDefault(
                  title: "Reason for plot being incomplete",
                  onBeforePopup: (String? s) async {
                    if (complete) {
                      Get.dialog(completeWarningPopup);
                      return false;
                    } else {
                      return true;
                    }
                  },
                  onChangedFn: (String? s) async {
                    reason = s!;
                    setState(() {});
                  },
                  itemsList: comp == "F: Full"
                      ? ["NA: Not Applicable"]
                      : ["AD: Access Denied", "HZ: Hazardous"],
                  selectedItem: reason),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              child: DataInput(
                  readOnly: complete,
                  title: "UTM Northing Coordinate",
                  boxLabel:
                      " Correct location on map or aerial photo within +/- 40 m of the provided location.",
                  prefixIcon: FontAwesomeIcons.compass,
                  suffixVal: "m",
                  inputType: const TextInputType.numberWithOptions(),
                  startingStr: "",
                  errorMsg: _errorUtmN(""),
                  inputFormatters: [LengthLimitingTextInputFormatter(7)],
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
                  title: "UTM Easting Coordinate",
                  boxLabel:
                      " Correct location on map or aerial photo within +/- 40 m of the provided location.",
                  prefixIcon: FontAwesomeIcons.compass,
                  suffixVal: "m",
                  inputType: const TextInputType.numberWithOptions(),
                  startingStr: "",
                  errorMsg: _errorUtmE(""),
                  inputFormatters: [LengthLimitingTextInputFormatter(7)],
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
                  title: "UTM Zone",
                  boxLabel:
                      "The UTM easting that describes the centre point location of a ground plot upon the national grid to the nearest m.",
                  prefixIcon: FontAwesomeIcons.compass,
                  suffixVal: "m",
                  inputType: const TextInputType.numberWithOptions(),
                  startingStr: "",
                  errorMsg: _errorUtmZone(""),
                  inputFormatters: [LengthLimitingTextInputFormatter(2)],
                  onSubmit: (String s) {
                    //TODO: Handle Submit
                    setState(() {});
                  }),
            ),
            IconNavButton(
              icon: const Icon(FontAwesomeIcons.ruler),
              space: kPaddingIcon,
              label: "Site Info Details",
              onPressed: () {
                Get.toNamed(Routes.siteInfoDetails);
              },
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV, horizontal: kPaddingH),
            ),
            IconNavButton(
              icon: const Icon(FontAwesomeIcons.ruler),
              space: kPaddingIcon,
              label: "Tree Cover Origins",
              onPressed: () {
                Get.toNamed(Routes.siteInfoOrigin);
              },
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV, horizontal: kPaddingH),
            ),
            IconNavButton(
              icon: const Icon(FontAwesomeIcons.ruler),
              space: kPaddingIcon,
              label: "Plot Tree Treatment",
              onPressed: () {
                Get.toNamed(Routes.siteInfoTreatment);
              },
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV, horizontal: kPaddingH),
            ),
            IconNavButton(
              icon: const Icon(FontAwesomeIcons.ruler),
              space: kPaddingIcon,
              label: "Natural Disturbance to the Plot Vegetation",
              onPressed: () {
                Get.toNamed(Routes.siteInfoDisturbance);
              },
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV, horizontal: kPaddingH),
            ),
          ],
        ),
      ),
    );
  }

  bool _checkSummaryComplete() => true;
  void _updateSummary() => null;
  String? _errorUtmN(String coord) => null;
  String? _errorUtmE(String coord) => null;
  String? _errorUtmZone(String coord) => null;
}
