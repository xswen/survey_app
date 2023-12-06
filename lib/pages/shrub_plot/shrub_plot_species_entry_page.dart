import 'package:survey_app/barrels/page_imports_barrel.dart';

import '../../widgets/buttons/delete_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_default.dart';
import '../../widgets/hide_info_checkbox.dart';

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
            DropDownDefault(
                title: "Status",
                onChangedFn: (s) {},
                itemsList: [],
                selectedItem: "Please select status"),
            DropDownDefault(
                title: "Basal diameter class",
                onChangedFn: (s) {},
                itemsList: [],
                selectedItem: "Please select status"),
            HideInfoCheckbox(
              title: "Small tree DBH",
              checkTitle: "Missing",
              checkValue: false,
              child: DataInput(
                  generalPadding: const EdgeInsets.only(top: 0),
                  onSubmit: (s) {},
                  onValidate: (s) {}),
            ),
            DataInput(title: "Frequency", onSubmit: (s) {}, onValidate: (s) {}),
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
