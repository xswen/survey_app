import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/checkbox/hide_info_checkbox.dart';

import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/reference_name_select_builder.dart';
import '../../widgets/buttons/delete_button.dart';
import '../../widgets/data_input/data_input.dart';

class SmallTreeSpeciesEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "smallTreeSpeciesEntry";
  final GoRouterState state;
  const SmallTreeSpeciesEntryPage(this.state, {super.key});

  @override
  SmallTreeSpeciesEntryPageState createState() =>
      SmallTreeSpeciesEntryPageState();
}

class SmallTreeSpeciesEntryPageState
    extends ConsumerState<SmallTreeSpeciesEntryPage> {
  String? _errorDbh(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (double.parse(value) < 0.1 || double.parse(value) > 8.9) {
      return "Dbh must be between 0.1 and 8.9cm";
    }
    return null;
  }

  String? _errorHeight(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (double.parse(value) < 1.3 || double.parse(value) > 20) {
      return "Height3 must be between 1.3 and 20m";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: const OurAppBar(
        "Small Tree Plot Species Entry",
      ),
      endDrawer: DrawerMenu(onLocaleChange: () {}),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingH),
        child: Center(
          child: ListView(children: [
            ReferenceNameSelectBuilder(
              title: "Original plot area",
              defaultSelectedValue: "Select plot area",
              name: db.referenceTablesDao.getStpOrigAreaName(""),
              asyncListFn: db.referenceTablesDao.getStpOrigAreaList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getStpOrigAreaCode(s)
                  .then((value) => null),
            ),
            ReferenceNameSelectBuilder(
              title: "Small tree genus",
              defaultSelectedValue: "Select genus",
              name: db.referenceTablesDao.getStpOrigAreaName(""),
              asyncListFn: () async => [],
              enabled: true,
              onChange: (s) => null,
            ),
            ReferenceNameSelectBuilder(
              title: "Small tree species",
              defaultSelectedValue: "Select species",
              name: db.referenceTablesDao.getStpOrigAreaName(""),
              asyncListFn: () async => [],
              enabled: true,
              onChange: (s) => null,
            ),
            ReferenceNameSelectBuilder(
              title: "Small tree variety",
              defaultSelectedValue: "Select variety",
              name: db.referenceTablesDao.getStpOrigAreaName(""),
              asyncListFn: () async => [],
              enabled: true,
              onChange: (s) => null,
            ),
            ReferenceNameSelectBuilder(
              title: "Small tree status",
              defaultSelectedValue: "Please select status",
              name: db.referenceTablesDao.getStpStatusName(""),
              asyncListFn: db.referenceTablesDao.getStpStatusList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getStpStatusCode(s)
                  .then((value) => null),
            ),
            HideInfoCheckbox(
              title: "Small tree DBH",
              titleWidget: "Unreported",
              checkValue: false,
              onChange: (b) => -1,
              child: DataInput(
                  boxLabel: "Report to the nearest 0.1cm",
                  prefixIcon: FontAwesomeIcons.ruler,
                  suffixVal: "cm",
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
                  onValidate: _errorDbh),
            ),
            HideInfoCheckbox(
              title: "Small tree height",
              titleWidget: "Unreported",
              checkValue: false,
              onChange: (b) => -1,
              child: DataInput(
                  boxLabel: "Report to the nearest 0.1m",
                  prefixIcon: FontAwesomeIcons.ruler,
                  suffixVal: "m",
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
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
                  onValidate: _errorHeight),
            ),
            ReferenceNameSelectBuilder(
              title: "Measured or estimated small tree height",
              defaultSelectedValue: "Select height",
              name: db.referenceTablesDao.getStpHeightName(""),
              asyncListFn: db.referenceTablesDao.getStpHeightList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getStpOrigAreaCode(s)
                  .then((value) => null),
            ),
            ReferenceNameSelectBuilder(
              title: "Stem condition",
              defaultSelectedValue: "Select stem condition",
              name: db.referenceTablesDao.getStpStemConditionName(""),
              asyncListFn: db.referenceTablesDao.getStpStemConditionList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getStpStemConditionCode(s)
                  .then((value) => null),
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
                      PopupContinue("Warning: Deleting Small Tree Plot Species",
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
