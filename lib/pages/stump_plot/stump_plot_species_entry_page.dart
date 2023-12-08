import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/builders/decay_class_select_builder.dart';

import '../../widgets/buttons/delete_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_default.dart';
import '../../widgets/hide_info_checkbox.dart';

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
            DropDownDefault(
                title: "Original plot area",
                onChangedFn: (s) {},
                itemsList: [],
                selectedItem: "Please select plot area"),
            DropDownDefault(
                title: "Genus",
                onChangedFn: (s) {},
                itemsList: [],
                selectedItem: "Please select genus"),
            DropDownDefault(
                title: "Species",
                onChangedFn: (s) {},
                itemsList: [],
                selectedItem: "Please select species"),
            DropDownDefault(
                title: "Variety",
                onChangedFn: (s) {},
                itemsList: [],
                selectedItem: "Please select variety"),
            HideInfoCheckbox(
              title: "Stump DIB",
              checkTitle: "Missing",
              checkValue: false,
              child: DataInput(
                  boxLabel: "Top inside bark diameter of stump in cm.",
                  generalPadding: const EdgeInsets.only(top: 0),
                  onSubmit: (s) {},
                  onValidate: (s) {}),
            ),
            HideInfoCheckbox(
              title: "Stump diameter",
              checkTitle: "Missing",
              checkValue: false,
              child: DataInput(
                  boxLabel: "Top diameter of stump including bark, if present. "
                      "If no bark present then STUMP_DIAMETER = STUMP_DIB. "
                      "Reported in cm.",
                  generalPadding: const EdgeInsets.only(top: 0),
                  onSubmit: (s) {},
                  onValidate: (s) {}),
            ),
            HideInfoCheckbox(
              title: "Stump length",
              checkTitle: "Missing",
              checkValue: false,
              child: DataInput(
                  boxLabel: "Length, measured to the nearest 0.01 m.",
                  generalPadding: const EdgeInsets.only(top: 0),
                  onSubmit: (s) {},
                  onValidate: (s) {}),
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
