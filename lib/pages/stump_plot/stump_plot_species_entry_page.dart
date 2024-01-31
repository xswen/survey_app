import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/builders/decay_class_select_builder.dart';

import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/reference_name_select_builder.dart';
import '../../widgets/buttons/delete_button.dart';
import '../../widgets/checkbox/hide_info_checkbox.dart';
import '../../widgets/data_input/data_input.dart';

class StumpPlotSpeciesEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "stumpPlotSpeciesEntry";
  final GoRouterState state;
  const StumpPlotSpeciesEntryPage(this.state, {super.key});

  @override
  StumpPlotSpeciesEntryPageState createState() =>
      StumpPlotSpeciesEntryPageState();
}

class StumpPlotSpeciesEntryPageState
    extends ConsumerState<StumpPlotSpeciesEntryPage> {
  String? _errorDib(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (double.parse(value) < 4.0 || double.parse(value) > 999.9) {
      return "Dbh must be between 4.0 and 999.9cm";
    }
    return null;
  }

  String? _errorDiameter(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (double.parse(value) < 4.0 || double.parse(value) > 999.9) {
      return "Diameter must be between 4.0 and 999.9cm";
    }
    return null;
  }

  String? _errorLength(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (double.parse(value) < 0.01 || double.parse(value) > 1.29) {
      return "Diameter must be between 0.01 and 1.29m";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: const OurAppBar(
        "Stump Plot Species Entry",
      ),
      endDrawer: DrawerMenu(onLocaleChange: () {}),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingH),
        child: Center(
          child: ListView(children: [
            ReferenceNameSelectBuilder(
              title: "Original plot area",
              defaultSelectedValue: "Select plot area",
              name: db.referenceTablesDao.getStumpOrigPlotAreaName(""),
              asyncListFn: db.referenceTablesDao.getStumpOrigPlotAreaList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getStumpOrigPlotAreaCode(s)
                  .then((value) => null),
            ),
            ReferenceNameSelectBuilder(
              title: "Genus",
              defaultSelectedValue: "Select genus",
              name: db.referenceTablesDao.getStpOrigAreaName(""),
              asyncListFn: () async => [],
              enabled: true,
              onChange: (s) => null,
            ),
            ReferenceNameSelectBuilder(
              title: "Species",
              defaultSelectedValue: "Select species",
              name: db.referenceTablesDao.getStpOrigAreaName(""),
              asyncListFn: () async => [],
              enabled: true,
              onChange: (s) => null,
            ),
            ReferenceNameSelectBuilder(
              title: "Variety",
              defaultSelectedValue: "Select variety",
              name: db.referenceTablesDao.getStpOrigAreaName(""),
              asyncListFn: () async => [],
              enabled: true,
              onChange: (s) => null,
            ),
            HideInfoCheckbox(
              title: "Stump DIB",
              titleWidget: "Unreported",
              checkValue: false,
              onChange: (b) => -1,
              child: DataInput(
                  boxLabel: "Top inside bark diameter of stump in cm.",
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
                  onValidate: _errorDib),
            ),
            HideInfoCheckbox(
              title: "Stump diameter",
              titleWidget: "Unreported",
              checkValue: false,
              onChange: (b) => -1,
              child: DataInput(
                  boxLabel: "Top diameter of stump including bark, if present. "
                      "If no bark present then STUMP_DIAMETER = STUMP_DIB. "
                      "Reported in cm.",
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
                  onValidate: _errorDiameter),
            ),
            HideInfoCheckbox(
              title: "Stump length",
              titleWidget: "Unreported",
              checkValue: false,
              onChange: (b) => -1,
              child: DataInput(
                  boxLabel: "Length, measured to the nearest 0.01 m.",
                  prefixIcon: FontAwesomeIcons.ruler,
                  suffixVal: "m",
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  startingStr: "",
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                    ThousandsFormatter(
                        allowFraction: true,
                        decimalPlaces: 2,
                        maxDigitsBeforeDecimal: 1),
                  ],
                  paddingGeneral: const EdgeInsets.only(top: 0),
                  onSubmit: (s) {},
                  onValidate: _errorLength),
            ),
            Padding(
              padding: const EdgeInsets.only(top: kPaddingV * 2),
              child: DecayClassSelectBuilder(
                  title: "Decay Class", onChangedFn: (s) {}, selectedItem: ""),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kPaddingV * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () => null,
                      child: const Text("Save and return")),
                  ElevatedButton(
                      onPressed: () => null,
                      child: const Text("Save and Add New Feature")),
                ],
              ),
            ),
            true
                ? DeleteButton(
                    delete: () => Popups.show(
                      context,
                      PopupContinue("Warning: Deleting Stump Plot Species",
                          contentText: "You are about to delete this feature. "
                              "Are you sure you want to continue?",
                          rightBtnOnPressed: () {
                        //close popup
                        context.pop();
                        // context.pushNamed(DeletePage.routeName, extra: {
                        //   DeletePage.keyObjectName:
                        //   "Soil Pit Feature: ${feature.toString()}",
                        //   DeletePage.keyDeleteFn: () {
                        //     (db.delete(db.soilPitFeature)
                        //       ..where(
                        //               (tbl) => tbl.id.equals(feature.id.value)))
                        //         .go()
                        //         .then((value) => goToFeaturePage());
                        //   },
                        // });
                      }),
                    ),
                  )
                : Container()
          ]),
        ),
      ),
    );
  }
}
