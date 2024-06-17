import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/checkbox/hide_info_checkbox.dart';

import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/reference_name_select_builder.dart';
import '../../widgets/buttons/save_entry_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/popups/popup_warning_change_made.dart';

class LargeTreePlotSiteTreeInfoAgeListEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "largeTreePlotSiteTreeInfoAgeListEntry";
  final GoRouterState state;
  const LargeTreePlotSiteTreeInfoAgeListEntryPage(this.state, {super.key});

  @override
  LargeTreePlotSiteTreeInfoAgeListEntryPageState createState() =>
      LargeTreePlotSiteTreeInfoAgeListEntryPageState();
}

class LargeTreePlotSiteTreeInfoAgeListEntryPageState
    extends ConsumerState<LargeTreePlotSiteTreeInfoAgeListEntryPage> {
  bool changeMade = false;
  String fieldAge = "";
  bool outsideBoredHeight = false;
  bool boredHeight = false;

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: OurAppBar(
        "Site Tree and Age Information",
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
            ReferenceNameSelectBuilder(
              title: "Quadrant",
              defaultSelectedValue: "Please select quadrant",
              name: db.referenceTablesDao.getLtpQuadrantName(""),
              asyncListFn: db.referenceTablesDao.getLtpQuadrantList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getLtpQuadrantCode(s)
                  .then((value) => setState(() {})),
            ),
            DataInput(
                title: "Tree number", onSubmit: (s) {}, onValidate: (s) {
                  return null;
                }),
            ReferenceNameSelectBuilder(
              title: "Tree type",
              defaultSelectedValue: "Please select tree type",
              name: db.referenceTablesDao.getLtpTreeTypeName(""),
              asyncListFn: db.referenceTablesDao.getLtpTreeTypeList,
              enabled: true,
              searchable: true,
              onChange: (s) => db.referenceTablesDao
                  .getLtpTreeTypeCode(s)
                  .then((value) => setState(() {})),
            ),

            HideInfoCheckbox(
              title: "Outside bark diameter at bored height",
              titleWidget: "Missing",
              checkValue: outsideBoredHeight,
              child: DataInput(
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
                        maxDigitsBeforeDecimal: 4),
                  ],
                  paddingGeneral: const EdgeInsets.only(top: 0),
                  onSubmit: (s) {},
                  onValidate: (s) {
                    if (s == null || s == "") {
                      return "Can't be left empty";
                    } else if (double.parse(s) < 0.1 ||
                        double.parse(s) > 999.9) {
                      return "Bored Height must be between 0.1 and 999.9cm";
                    }
                    return null;
                  }),
            ),
            HideInfoCheckbox(
              title: "Bored Height",
              titleWidget: "Missing",
              checkValue: boredHeight,
              child: DataInput(
                  boxLabel: "Report to the nearest 0.1m",
                  prefixIcon: FontAwesomeIcons.ruler,
                  suffixVal: "m",
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  startingStr: "",
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                    ThousandsFormatter(
                        allowFraction: true,
                        decimalPlaces: 1,
                        maxDigitsBeforeDecimal: 1),
                  ],
                  paddingGeneral: const EdgeInsets.only(top: 0),
                  onSubmit: (s) {},
                  onValidate: (s) {
                    if (s == null || s == "") {
                      return "Can't be left empty";
                    } else if (double.parse(s) < 0 || double.parse(s) > 9.9) {
                      return "Bored Height must be between 0 and 9.9m";
                    }
                    return null;
                  }),
            ),
            ReferenceNameSelectBuilder(
              title: "Site height suitability",
              defaultSelectedValue: "Please select suitability",
              name: db.referenceTablesDao.getLtpSiteHeightSuitabilityName(""),
              asyncListFn:
                  db.referenceTablesDao.getLtpSiteHeightSuitabilityList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getLtpSiteHeightSuitabilityCode(s)
                  .then((value) => setState(() {})),
            ),
            ReferenceNameSelectBuilder(
              title: "Site age suitability",
              defaultSelectedValue: "Please select suitability",
              name: db.referenceTablesDao.getLtpSiteAgeSuitabilityName(""),
              asyncListFn: db.referenceTablesDao.getLtpSiteAgeSuitabilityList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getLtpSiteAgeSuitabilityCode(s)
                  .then((value) => setState(() {})),
            ),
            const Text("Field age", style: kTitleStyle),
            CheckboxListTile(
                title: const Text(
                  "Tree core not collected this cycle",
                  style: kTextStyle,
                ),
                value: fieldAge == "N",
                onChanged: (check) => setState(() {
                      check == true ? fieldAge = "N" : fieldAge = "";
                    })),
            CheckboxListTile(
                title: const Text(
                  "Missing",
                  style: kTextStyle,
                ),
                value: fieldAge == "M",
                onChanged: (check) => setState(() {
                      check == true ? fieldAge = "M" : fieldAge = "";
                    })),
            Visibility(
              visible: fieldAge != "M" && fieldAge != "N",
              child: DataInput(
                  boxLabel: "Age determined in years",
                  prefixIcon: FontAwesomeIcons.calendar,
                  suffixVal: "years",
                  inputType:
                      const TextInputType.numberWithOptions(decimal: false),
                  startingStr: "",
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                    ThousandsFormatter(
                        allowFraction: false, maxDigitsBeforeDecimal: 4),
                  ],
                  paddingGeneral: const EdgeInsets.only(top: 0),
                  onSubmit: (s) {},
                  onValidate: (s) {
                    if (s == null || s == "") {
                      return "Can't be left empty";
                    } else if (double.parse(s) < 1 || double.parse(s) > 9999) {
                      return "Age must be between 1 and 9999 years";
                    }
                    return null;
                  }),
            ),

            ReferenceNameSelectBuilder(
              title: "Prorate code",
              defaultSelectedValue: "Please select code",
              name: db.referenceTablesDao.getLtpProrateName(""),
              asyncListFn: db.referenceTablesDao.getLtpProrateList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getLtpProrateCode(s)
                  .then((value) => setState(() {})),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kPaddingV * 2),
              child: SaveEntryButton(
                saveRetFn: () {},
                saveAndAddFn: () {},
                delVisible: true,
                deleteFn: () => Popups.show(
                  context,
                  PopupContinue(
                      "Warning: Deleting Large Tree Site Tree and Age Information",
                      contentText: "You are about to delete this feature. "
                          "Are you sure you want to continue?",
                      rightBtnOnPressed: () {
                    //close popup
                    context.pop();
                    // context.pushNamed(DeletePage.routeName, extra: {
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
                  }),
                ),
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
