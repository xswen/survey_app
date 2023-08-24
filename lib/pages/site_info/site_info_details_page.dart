import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constants/margins_padding.dart';
import '../../global.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/floating_complete_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_default.dart';
import '../../widgets/popups/popup_dismiss_dep.dart';

class SiteInfoDetailsPage extends StatefulWidget {
  const SiteInfoDetailsPage({super.key, required this.title});
  final String title;

  @override
  State<SiteInfoDetailsPage> createState() => _SiteInfoDetailsPageState();
}

class _SiteInfoDetailsPageState extends State<SiteInfoDetailsPage> {
  bool complete = false;
  String province = "";
  String ecozone = "";
  String landbase = "";
  String landCover = "";
  String landPos = "";
  String vegType = "";
  String densityClass = "";
  String standStruct = "";
  String succStage = "";
  String wetlandClass = "";

  final PopupDismissDep completeWarningPopup =
      Global.generateCompleteErrorPopup("Site Info Details");

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
      body: Center(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              child: DropDownDefault(
                  title: "Province/Territory",
                  onBeforePopup: (String? s) async {
                    if (complete) {
                      Get.dialog(completeWarningPopup);
                      return false;
                    } else {
                      return true;
                    }
                  },
                  onChangedFn: (String? s) async {
                    province != s ? ecozone = "" : null;
                    province = s!;
                    setState(() {});
                  },
                  itemsList: ["MB: Manitoba", "YT: Yukon Territory"],
                  selectedItem: province),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              child: DropDownDefault(
                  title: "Ecozone",
                  onBeforePopup: (String? s) async {
                    if (complete) {
                      Get.dialog(completeWarningPopup);
                      return false;
                    } else {
                      return true;
                    }
                  },
                  onChangedFn: (String? s) async {
                    ecozone = s!;
                    setState(() {});
                  },
                  itemsList: province == "MB: Manitoba"
                      ? ["10: Prairies"]
                      : ["2: Northern Arctic", "3: Southern Arctic"],
                  selectedItem: ecozone),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              child: DataInput(
                  readOnly: complete,
                  title: "Provincial Ecosystem Type",
                  boxLabel:
                      "Ecosystem type identifier classified to the site association/site series level using the applicable ecosystem classification for the province the site is in. Do not use commas",
                  prefixIcon: FontAwesomeIcons.noteSticky,
                  suffixVal: "",
                  startingStr: "",
                  errorMsg: _errorEcoType(""),
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
                  title: "Provincial Ecosystem Type Reference",
                  boxLabel:
                      "Refers to reference or publication used for ecosystem provincial ecosystem type classification scheme. -1 for unreported",
                  prefixIcon: FontAwesomeIcons.check,
                  suffixVal: "",
                  inputType:
                      const TextInputType.numberWithOptions(signed: true),
                  startingStr: "",
                  errorMsg: _errorProvEco(""),
                  //Add negatives
                  inputFormatters: [],
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
                  title: "Slope",
                  boxLabel:
                      "A measurement of the slope gradient. Measured in percent. -1 for Missing",
                  prefixIcon: FontAwesomeIcons.percent,
                  suffixVal: "%",
                  inputType:
                      const TextInputType.numberWithOptions(signed: true),
                  startingStr: "",
                  errorMsg: _errorProvEco(""),
                  //Add negatives
                  inputFormatters: [],
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
                  title: "Aspect",
                  boxLabel:
                      "The orientation of the slope. Measured in degrees. -1 for Missing",
                  prefixIcon: FontAwesomeIcons.check,
                  suffixVal: "Degrees",
                  inputType:
                      const TextInputType.numberWithOptions(signed: true),
                  startingStr: "",
                  errorMsg: _errorProvEco(""),
                  //Add negatives
                  inputFormatters: [],
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
                  title: "Elevation",
                  boxLabel:
                      "Elevation at plot centre. Record in meters. -1 for Missing",
                  prefixIcon: FontAwesomeIcons.ruler,
                  suffixVal: "m",
                  inputType:
                      const TextInputType.numberWithOptions(signed: true),
                  startingStr: "",
                  errorMsg: _errorProvEco(""),
                  //Add negatives
                  inputFormatters: [],
                  onSubmit: (String s) {
                    //TODO: Handle Submit
                    setState(() {});
                  }),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              child: DropDownDefault(
                  title: "Land Base",
                  onBeforePopup: (String? s) async {
                    if (complete) {
                      Get.dialog(completeWarningPopup);
                      return false;
                    } else {
                      return true;
                    }
                  },
                  onChangedFn: (String? s) async {
                    landbase = s!;
                    setState(() {});
                  },
                  itemsList: [
                    "V: vegetated (establishment plots)",
                    "N: non-vegetated (re-measurement plots only)",
                    "U: unknown"
                  ],
                  selectedItem: landbase),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              child: DropDownDefault(
                  title: "Land Cover",
                  onBeforePopup: (String? s) async {
                    if (complete) {
                      Get.dialog(completeWarningPopup);
                      return false;
                    } else {
                      return true;
                    }
                  },
                  onChangedFn: (String? s) async {
                    landCover = s!;
                    setState(() {});
                  },
                  itemsList: [
                    "T: treed",
                    "N: non-treed",
                    "L: land",
                    "W: water",
                    "U: unknown"
                  ],
                  selectedItem: landCover),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              child: DropDownDefault(
                  title: "Landscape position",
                  onBeforePopup: (String? s) async {
                    if (complete) {
                      Get.dialog(completeWarningPopup);
                      return false;
                    } else {
                      return true;
                    }
                  },
                  onChangedFn: (String? s) async {
                    landPos = s!;
                    setState(() {});
                  },
                  itemsList: [
                    "W: wetland",
                    "U: upland",
                    "A: alpine",
                    "N: not known"
                  ],
                  selectedItem: landPos),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              child: DropDownDefault(
                  title: "Vegetation Type",
                  onBeforePopup: (String? s) async {
                    if (complete) {
                      Get.dialog(completeWarningPopup);
                      return false;
                    } else {
                      return true;
                    }
                  },
                  onChangedFn: (String? s) async {
                    vegType = s!;
                    setState(() {});
                  },
                  itemsList: ["TC: coniferous", "TB: broadleaf", "U: unknown"],
                  selectedItem: vegType),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              child: DropDownDefault(
                  title: "Density Class",
                  onBeforePopup: (String? s) async {
                    if (complete) {
                      Get.dialog(completeWarningPopup);
                      return false;
                    } else {
                      return true;
                    }
                  },
                  onChangedFn: (String? s) async {
                    densityClass = s!;
                    setState(() {});
                  },
                  itemsList: ["DE: dense", "OP: open", "U: unknown"],
                  selectedItem: densityClass),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              child: DropDownDefault(
                  title: "Stand Structure",
                  onBeforePopup: (String? s) async {
                    if (complete) {
                      Get.dialog(completeWarningPopup);
                      return false;
                    } else {
                      return true;
                    }
                  },
                  onChangedFn: (String? s) async {
                    standStruct = s!;
                    setState(() {});
                  },
                  itemsList: [
                    "SNGL: single storied",
                    "MULT: two or more distinct canopy layers",
                    "U: unknown"
                  ],
                  selectedItem: standStruct),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              child: DropDownDefault(
                  title: "Successional Stage",
                  onBeforePopup: (String? s) async {
                    if (complete) {
                      Get.dialog(completeWarningPopup);
                      return false;
                    } else {
                      return true;
                    }
                  },
                  onChangedFn: (String? s) async {
                    succStage = s!;
                    setState(() {});
                  },
                  itemsList: ["ES: early seral stage", "MS: mid seral stage"],
                  selectedItem: succStage),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(
                  kPaddingH, 0, kPaddingH, kPaddingV / 2),
              child: DropDownDefault(
                  title: "Wetland Class",
                  onBeforePopup: (String? s) async {
                    if (complete) {
                      Get.dialog(completeWarningPopup);
                      return false;
                    } else {
                      return true;
                    }
                  },
                  onChangedFn: (String? s) async {
                    wetlandClass = s!;
                    setState(() {});
                  },
                  itemsList: ["B: Bog", "F: Fen", "U: Unreported"],
                  selectedItem: wetlandClass),
            ),
          ],
        ),
      ),
    );
  }

  bool _checkComplete() => true;
  void _update() => null;
  String? _errorEcoType(String type) => null;
  String? _errorProvEco(String type) => null;
}
