import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';

import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/reference_name_select_builder.dart';
import '../../widgets/buttons/delete_button.dart';
import '../../widgets/data_input/data_input.dart';

class ShrubPlotSpeciesEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "shrubPlotSpeciesEntry";
  final GoRouterState state;
  const ShrubPlotSpeciesEntryPage(this.state, {super.key});

  @override
  ShrubPlotSpeciesEntryPageState createState() =>
      ShrubPlotSpeciesEntryPageState();
}

class ShrubPlotSpeciesEntryPageState
    extends ConsumerState<ShrubPlotSpeciesEntryPage> {
  String? _errorFrequency(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (double.parse(value) < 1 || double.parse(value) > 999) {
      return "Dbh must be between 1 and 999";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: const OurAppBar(
        "Shrub Plot Species Entry",
      ),
      endDrawer: DrawerMenu(onLocaleChange: () {}),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingH),
        child: Center(
          child: ListView(children: [
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
              name: db.referenceTablesDao.getShrubStatusName(""),
              asyncListFn: db.referenceTablesDao.getShrubStatusList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getShrubStatusCode(s)
                  .then((value) => null),
            ),
            ReferenceNameSelectBuilder(
              title: "Basal diameter class",
              defaultSelectedValue: "Please diameter class",
              name: db.referenceTablesDao.getShrubBasalDiameterName(""),
              asyncListFn: db.referenceTablesDao.getShrubBasalDiameterList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getShrubBasalDiameterCode(s)
                  .then((value) => null),
            ),
            DataInput(
                title: "Frequency",
                boxLabel:
                    "Number of primary stems tallied for each unique combination",
                prefixIcon: FontAwesomeIcons.tree,
                inputType:
                    const TextInputType.numberWithOptions(decimal: false),
                startingStr: "",
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                  ThousandsFormatter(maxDigitsBeforeDecimal: 3),
                ],
                onSubmit: (s) {},
                onValidate: _errorFrequency),
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
