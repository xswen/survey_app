import 'package:survey_app/barrels/page_imports_barrel.dart';

import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_default.dart';
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
            DropDownDefault(
                title: "Quadrant",
                onChangedFn: (s) {},
                itemsList: const ["NE", "SE", "SW", "NW", "OP", "Not reported"],
                selectedItem: "Please select quadrant"),
            DataInput(
                title: "Tree number", onSubmit: (s) {}, onValidate: (s) {}),
            DropDownDefault(
                title: "Tree type",
                onChangedFn: (s) {},
                itemsList: const [
                  "T",
                  "TL",
                  "TS",
                  "TO",
                  "TR",
                  "L",
                  "S",
                  "O",
                  "R",
                  "N",
                  "Unreported"
                ],
                selectedItem: "Please select tree type"),
            DataInput(
                title: "Outside bark diameter at bored height",
                onSubmit: (s) {},
                onValidate: (s) {}),
            DataInput(
                title: "Bored height", onSubmit: (s) {}, onValidate: (s) {}),
            DropDownDefault(
                title: "Site height suitability",
                onChangedFn: (s) {},
                itemsList: const ["Yes", "No", "Missing"],
                selectedItem: "Please select suitability"),
            DropDownDefault(
                title: "Site age suitability",
                onChangedFn: (s) {},
                itemsList: const ["Yes", "No", "Missing"],
                selectedItem: "Please select suitability"),
            DataInput(title: "Field age", onSubmit: (s) {}, onValidate: (s) {}),
            DropDownDefault(
                title: "Prorate code",
                onChangedFn: (s) {},
                itemsList: const ["ROT", "CRC", "OTH", "NA", "Not reported"],
                selectedItem: "Please select code"),
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
