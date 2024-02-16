import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/builders/ltp_genus_select_builder.dart';
import 'package:survey_app/widgets/builders/ltp_species_select_builder.dart';
import 'package:survey_app/widgets/builders/ltp_variety_select_builder.dart';

import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/reference_name_select_builder.dart';
import '../../widgets/checkbox/hide_info_checkbox.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_default.dart';
import '../../widgets/popups/popup_warning_change_made.dart';
import '../../widgets/text/text_header_separator.dart';

class LargeTreePlotTreeInfoListEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "largeTreePlotInfoListEntry";
  final GoRouterState state;
  const LargeTreePlotTreeInfoListEntryPage(this.state, {super.key});

  @override
  LargeTreePlotTreeInfoListEntryPageState createState() =>
      LargeTreePlotTreeInfoListEntryPageState();
}

class LargeTreePlotTreeInfoListEntryPageState
    extends ConsumerState<LargeTreePlotTreeInfoListEntryPage> {
  final String title = "Tree Info";
  bool changeMade = false;
  bool tmpRenum = false;
  String tempMeasType = "";
  String tmpHeight = "";
  String tmpGenus = "";
  String tmpSpecies = "";
  String tmpVariety = "";
  String tmpStatus = "";
  bool tmpCrownHeight = false;
  bool tmpAz = false;
  bool tmpDist = false;

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: OurAppBar(
        title,
        backFn: () {
          if (changeMade) {
            Popups.show(context, PopupWarningChangesUnsaved(
              rightBtnOnPressed: () {
                //ref.refresh(soilHorizonListProvider(spId));
                context.pop();
                context.pop();
              },
            ));
          } else {
            //ref.refresh(soilHorizonListProvider(spId));
            context.pop();
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingH),
        child: Center(
          child: ListView(children: [
            const TextHeaderSeparator(
              title: "Tree Details",
              fontSize: 20,
            ),
            DropDownDefault(
                title: "Plot sector",
                onChangedFn: (s) {},
                itemsList: const [
                  "1",
                  "2",
                  "3",
                  "4",
                  "5",
                  "6",
                  "7",
                  "8",
                  "Missing"
                ],
                selectedItem: "Please select sector"),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kPaddingV * 2),
                const Text("Tree number", style: kTitleStyle),
                CheckboxListTile(
                  title: const Text(
                    "Renumbered",
                    style: kTextStyle,
                  ),
                  value: tmpRenum,
                  onChanged: (check) {
                    if (check != null) {
                      setState(() {
                        tmpRenum = check;
                      });
                    }
                  },
                  controlAffinity: ListTileControlAffinity.platform,
                ),
                Visibility(
                    visible: tmpRenum,
                    child: Column(
                      children: [
                        DataInput(
                            title: "New tree number",
                            paddingGeneral:
                                const EdgeInsets.only(bottom: kPaddingV),
                            onSubmit: (s) {},
                            onValidate: (s) {}),
                        DataInput(
                            title: "Original tree number",
                            paddingGeneral:
                                const EdgeInsets.only(bottom: kPaddingV),
                            onSubmit: (s) {},
                            onValidate: (s) {}),
                      ],
                    )),
              ],
            ),
            ReferenceNameSelectBuilder(
              title: "Original plot area",
              name: db.referenceTablesDao.getLtpOrigPlotAreaName(""),
              asyncListFn: db.referenceTablesDao.getLtpOrigPlotAreaList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getLtpOrigPlotAreaCode(s)
                  .then((value) => null),
            ),
            LtpGenusSelectBuilder(
                title: "Tree genus",
                enabled: true,
                updateGenusFn: (genus, species, variety) {
                  setState(() {
                    tmpGenus = genus.value;
                    tmpSpecies = db.companionValueToStr(species);
                    tmpVariety = db.companionValueToStr(variety);
                  });
                },
                genusCode: tmpGenus),
            LtpSpeciesSelectBuilder(
                enabled: true,
                selectedSpeciesCode: tmpSpecies,
                genusCode: tmpGenus,
                updateSpeciesFn: (species, variety) {
                  setState(() {
                    tmpSpecies = db.companionValueToStr(species);
                    tmpVariety = db.companionValueToStr(variety);
                  });
                }),
            LtpVarietySelectBuilder(
                title: "Tree Variety",
                enabled: true,
                genusCode: tmpGenus,
                speciesCode: tmpSpecies,
                selectedVarietyCode: tmpVariety,
                updateVarietyFn: (variety) {
                  tmpVariety = db.companionValueToStr(variety);
                }),
            ReferenceNameSelectBuilder(
              title: "Tree status",
              name: db.referenceTablesDao.getLtpStatusFieldName(""),
              asyncListFn: db.referenceTablesDao.getLtpStatusFieldList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getLtpStatusFieldCode(s)
                  .then((value) => null),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kPaddingV * 2),
                const Text("Diameter at breast height", style: kTitleStyle),
                CheckboxListTile(
                  title: const Text(
                    "Measured",
                    style: kTextStyle,
                  ),
                  value: tempMeasType == "M",
                  onChanged: (check) {
                    setState(() {
                      check == true ? tempMeasType = "M" : tempMeasType = "E";
                    });
                  },
                  controlAffinity: ListTileControlAffinity.platform,
                ),
                CheckboxListTile(
                  title: const Text(
                    "Estimated",
                    style: kTextStyle,
                  ),
                  value: tempMeasType == "E",
                  onChanged: (check) {
                    setState(() {
                      check == false ? tempMeasType = "M" : tempMeasType = "E";
                    });
                  },
                  controlAffinity: ListTileControlAffinity.platform,
                ),
                DataInput(
                    boxLabel: "Report to the nearest 0.1cm",
                    prefixIcon: FontAwesomeIcons.ruler,
                    suffixVal: "cm",
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    startingStr: "",
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(5),
                      ThousandsFormatter(
                          allowFraction: true,
                          decimalPlaces: 1,
                          maxDigitsBeforeDecimal: 3),
                    ],
                    paddingGeneral: const EdgeInsets.only(top: 0),
                    onSubmit: (s) {},
                    onValidate: (s) {
                      if (s == null || s == "") {
                        return "Can't be left empty";
                      } else if (double.parse(s) < 0.1 ||
                          double.parse(s) > 999.9) {
                        return "Dbh must be between 0.1 and 999.9cm";
                      }
                      return null;
                    }),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kPaddingV * 2),
                const Text("Tree height", style: kTitleStyle),
                CheckboxListTile(
                  title: const Text(
                    "Actual field measurement",
                    style: kTextStyle,
                  ),
                  value: tmpHeight == "A",
                  onChanged: (check) {
                    setState(() {
                      check == true ? tmpHeight = "A" : tmpHeight = "N";
                    });
                  },
                  controlAffinity: ListTileControlAffinity.platform,
                ),
                CheckboxListTile(
                  title: const Text(
                    "Calculated (e.g. using height diameter curves)",
                    style: kTextStyle,
                  ),
                  value: tmpHeight == "C",
                  onChanged: (check) {
                    setState(() {
                      check == true ? tmpHeight = "C" : tmpHeight = "N";
                    });
                  },
                  controlAffinity: ListTileControlAffinity.platform,
                ),
                CheckboxListTile(
                  title: const Text(
                    "Estimated by field crew",
                    style: kTextStyle,
                  ),
                  value: tmpHeight == "E",
                  onChanged: (check) {
                    setState(() {
                      check == true ? tmpHeight = "E" : tmpHeight = "N";
                    });
                  },
                  controlAffinity: ListTileControlAffinity.platform,
                ),
                CheckboxListTile(
                  title: const Text(
                    "Not specified",
                    style: kTextStyle,
                  ),
                  // contentPadding: EdgeInsets.zero,
                  value: tmpHeight == "N",
                  onChanged: (check) {
                    setState(() {
                      check == true ? tmpHeight = "N" : tmpHeight = "";
                    });
                  },
                  controlAffinity: ListTileControlAffinity.platform,
                ),
                DataInput(
                    boxLabel: "Report to the nearest 0.1m",
                    prefixIcon: FontAwesomeIcons.ruler,
                    suffixVal: "m",
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                    startingStr: "",
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(5),
                      ThousandsFormatter(
                          allowFraction: true,
                          decimalPlaces: 1,
                          maxDigitsBeforeDecimal: 3),
                    ],
                    paddingGeneral: const EdgeInsets.only(top: 0),
                    onSubmit: (s) {},
                    onValidate: (s) {
                      if (s == null || s == "") {
                        return "Can't be left empty";
                      } else if (double.parse(s) < 0.1 ||
                          double.parse(s) > 999.9) {
                        return "Dbh must be between 0.1 and 999.9cm";
                      }
                      return null;
                    }),
              ],
            ),
            DropDownDefault(
                title: "Crown class",
                onChangedFn: (s) {},
                itemsList: const ["D", "C", "I", "S", "V", "N", "M"],
                selectedItem: "Please select tree status"),
            ReferenceNameSelectBuilder(
              title: "Tree status",
              name: db.referenceTablesDao.getLtpStatusFieldName(""),
              asyncListFn: db.referenceTablesDao.getLtpStatusFieldList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getLtpStatusFieldCode(s)
                  .then((value) => setState(() => tmpStatus = value)),
            ),
            Visibility(
              visible: !(tmpStatus == "DS" || tmpStatus == "LF"),
              child: Column(
                children: [
                  HideInfoCheckbox(
                    title: "Height to base of live crown",
                    titleWidget: "Missing",
                    checkValue: tmpCrownHeight,
                    child: DataInput(
                        boxLabel: "Report to the nearest 0.1m",
                        prefixIcon: FontAwesomeIcons.ruler,
                        suffixVal: "m",
                        inputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        startingStr: "",
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          ThousandsFormatter(
                              allowFraction: true,
                              decimalPlaces: 1,
                              maxDigitsBeforeDecimal: 3),
                        ],
                        paddingGeneral: const EdgeInsets.only(top: 0),
                        onSubmit: (s) {},
                        onValidate: (s) {
                          if (s == null || s == "") {
                            return "Can't be left empty";
                          } else if (double.parse(s) < 0.1 ||
                              double.parse(s) > 999.9) {
                            return "Dbh must be between 0.1 and 999.9cm";
                          }
                          return null;
                        }),
                  ),
                  HideInfoCheckbox(
                    title: "Height to top of live crown",
                    titleWidget: "Missing",
                    checkValue: tmpCrownHeight,
                    child: DataInput(
                        boxLabel: "Report to the nearest 0.1m",
                        prefixIcon: FontAwesomeIcons.ruler,
                        suffixVal: "m",
                        inputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        startingStr: "",
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          ThousandsFormatter(
                              allowFraction: true,
                              decimalPlaces: 1,
                              maxDigitsBeforeDecimal: 3),
                        ],
                        paddingGeneral: const EdgeInsets.only(top: 0),
                        onSubmit: (s) {},
                        onValidate: (s) {
                          if (s == null || s == "") {
                            return "Can't be left empty";
                          } else if (double.parse(s) < 0.1 ||
                              double.parse(s) > 999.9) {
                            return "Dbh must be between 0.1 and 999.9cm";
                          }
                          return null;
                        }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kPaddingV * 2),
            const TextHeaderSeparator(
              title: "Condition",
              fontSize: 20,
            ),
            DropDownDefault(
                title: "Stem condition",
                onChangedFn: (s) {},
                itemsList: const ["B", "I", "M"],
                selectedItem: "Please select tree status"),
            DropDownDefault(
                title: "Crown condition",
                onChangedFn: (s) {},
                itemsList: const ["1", "2", "3", "4", "5", "6", "Missing"],
                selectedItem: "Please select tree status"),
            DropDownDefault(
                title: "Bark condition",
                onChangedFn: (s) {},
                itemsList: const ["1", "2", "3", "4", "5", "6", "7", "Missing"],
                selectedItem: "Please select tree status"),
            DropDownDefault(
                title: "Wood condition",
                onChangedFn: (s) {},
                itemsList: const [
                  "1",
                  "2",
                  "3",
                  "4",
                  "5",
                  "6",
                  "7",
                  "8",
                  "Missing"
                ],
                selectedItem: "Please select tree status"),
            const SizedBox(height: kPaddingV * 2),
            const TextHeaderSeparator(
              title: "Stem Mapping",
              fontSize: 20,
            ),
            HideInfoCheckbox(
                titleWidget: "No trees stem mapped",
                checkValue: tmpAz,
                child: Column(
                  children: [
                    DataInput(
                        title: "Azimuth to tree",
                        boxLabel: "Report to the nearest degree",
                        prefixIcon: FontAwesomeIcons.ruler,
                        suffixVal: kDegreeSign,
                        inputType: const TextInputType.numberWithOptions(
                            decimal: false),
                        startingStr: "",
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(3),
                          ThousandsFormatter(allowFraction: false),
                        ],
                        paddingGeneral: const EdgeInsets.only(top: 0),
                        onSubmit: (s) {},
                        onValidate: (s) {
                          if (s == null || s == "") {
                            return "Can't be left empty";
                          } else if (double.parse(s) < 0 ||
                              double.parse(s) > 360) {
                            return "Dbh must be between 0.1 and 999.9cm";
                          }
                          return null;
                        }),
                    DataInput(
                        title: "Distance to tree face",
                        boxLabel: "Report to the nearest 0.1m",
                        prefixIcon: FontAwesomeIcons.ruler,
                        suffixVal: "m",
                        inputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        startingStr: "",
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                          ThousandsFormatter(
                              allowFraction: true,
                              decimalPlaces: 1,
                              maxDigitsBeforeDecimal: 2),
                        ],
                        paddingGeneral: const EdgeInsets.only(top: 0),
                        onSubmit: (s) {},
                        onValidate: (s) {
                          if (s == null || s == "") {
                            return "Can't be left empty";
                          } else if (double.parse(s) < 0.1 ||
                              double.parse(s) > 99.9) {
                            return "Dbh must be between 0.1 and 999.9cm";
                          }
                          return null;
                        }),
                  ],
                )),

            const SizedBox(height: kPaddingV * 2),
            const TextHeaderSeparator(
              title: "Damage Agents",
              fontSize: 20,
            ),
            //TODO: Add damage agents
            Text("TO ADD"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kPaddingV * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () => null, //handleSubmit(goToHorizonPage),
                      child: const Text("Save and return")),
                  ElevatedButton(
                      onPressed: () =>
                          null, //handleSubmit(goToNewHorizonEntry),
                      child: const Text("Save and add new tree")),
                ],
              ),
            ),
            // horizon.id != const d.Value.absent()
            //     ? DeleteButton(
            //   delete: () => Popups.show(
            //     context,
            //     PopupContinue("Warning: Deleting Soil Pit Feature",
            //         contentText: "You are about to delete this feature. "
            //             "Are you sure you want to continue?",
            //         rightBtnOnPressed: () {
            //           //close popup
            //           context.pop();
            //           context.pushNamed(DeletePage.routeName, extra: {
            //             DeletePage.keyObjectName:
            //             "Soil Pit Feature: ${horizon.toString()}",
            //             DeletePage.keyDeleteFn: () {
            //               (db.delete(db.soilPitHorizonDescription)
            //                 ..where(
            //                         (tbl) => tbl.id.equals(horizon.id.value)))
            //                   .go()
            //                   .then((value) => goToHorizonPage());
            //             },
            //           });
            //         }),
            //   ),
            // )
            //     : Container()
          ]),
        ),
      ),
    );
  }
}
