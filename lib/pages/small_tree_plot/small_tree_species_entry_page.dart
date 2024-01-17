import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/checkbox/hide_info_checkbox.dart';

import '../../widgets/buttons/delete_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_default.dart';

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
            DropDownDefault(
                title: "Original plot area",
                onChangedFn: (s) {},
                itemsList: [],
                selectedItem: "Please select plot area"),
            DropDownDefault(
                title: "Small tree genus",
                onChangedFn: (s) {},
                itemsList: [],
                selectedItem: "Please select genus"),
            DropDownDefault(
                title: "Small tree species",
                onChangedFn: (s) {},
                itemsList: [],
                selectedItem: "Please select species"),
            DropDownDefault(
                title: "Small tree variety",
                onChangedFn: (s) {},
                itemsList: [],
                selectedItem: "Please select variety"),
            DropDownDefault(
                title: "Small tree status",
                onChangedFn: (s) {},
                itemsList: [],
                selectedItem: "Please select status"),
            HideInfoCheckbox(
              title: "Small tree DBH",
              titleWidget: "Unreported",
              checkValue: false,
              child: DataInput(
                  paddingGeneral: const EdgeInsets.only(top: 0),
                  onSubmit: (s) {},
                  onValidate: (s) {}),
            ),
            HideInfoCheckbox(
              title: "Small tree height",
              titleWidget: "Unreported",
              checkValue: false,
              child: DataInput(
                  paddingGeneral: const EdgeInsets.only(top: 0),
                  onSubmit: (s) {},
                  onValidate: (s) {}),
            ),
            DropDownDefault(
                title: "Measured or estimated small tree height",
                onChangedFn: (s) {},
                itemsList: [],
                selectedItem: "Please select"),
            DropDownDefault(
                title: "Stem condition",
                onChangedFn: (s) {},
                itemsList: [],
                selectedItem: "Please select"),
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
