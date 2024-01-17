import 'package:survey_app/barrels/page_imports_barrel.dart';

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
                  value: true,
                  onChanged: (check) {},
                  controlAffinity: ListTileControlAffinity.platform,
                ),
                DataInput(
                    title: "New tree number",
                    paddingGeneral: const EdgeInsets.only(bottom: kPaddingV),
                    onSubmit: (s) {},
                    onValidate: (s) {}),
                DataInput(
                    title: "Original tree number",
                    paddingGeneral: const EdgeInsets.only(bottom: kPaddingV),
                    onSubmit: (s) {},
                    onValidate: (s) {}),
              ],
            ),
            DropDownDefault(
                title: "Original plot area",
                onChangedFn: (s) {},
                itemsList: const ["Y", "N", "X", "U"],
                selectedItem: "Please select plot area code"),
            DropDownDefault(
                title: "Tree genus",
                onChangedFn: (s) {},
                itemsList: const [],
                selectedItem: "Please select tree genus"),
            DropDownDefault(
                title: "Tree species",
                onChangedFn: (s) {},
                itemsList: const [],
                selectedItem: "Please select tree species"),
            DropDownDefault(
                title: "Tree variety",
                onChangedFn: (s) {},
                itemsList: const [],
                selectedItem: "Please select tree variety"),
            DropDownDefault(
                title: "Tree status",
                onChangedFn: (s) {},
                itemsList: const ["LS", "LF", "DS", "M"],
                selectedItem: "Please select tree status"),
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
                  value: true,
                  onChanged: (check) {},
                  controlAffinity: ListTileControlAffinity.platform,
                ),
                CheckboxListTile(
                  title: const Text(
                    "Estimated",
                    style: kTextStyle,
                  ),
                  value: false,
                  onChanged: (check) {},
                  controlAffinity: ListTileControlAffinity.platform,
                ),
                DataInput(
                    paddingGeneral: const EdgeInsets.only(bottom: kPaddingV),
                    onSubmit: (s) {},
                    onValidate: (s) {}),
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
                  value: true,
                  onChanged: (check) {},
                  controlAffinity: ListTileControlAffinity.platform,
                ),
                CheckboxListTile(
                  title: const Text(
                    "Calculated (e.g. using height diameter curves)",
                    style: kTextStyle,
                  ),
                  value: false,
                  onChanged: (check) {},
                  controlAffinity: ListTileControlAffinity.platform,
                ),
                CheckboxListTile(
                  title: const Text(
                    "Estimated by field crew",
                    style: kTextStyle,
                  ),
                  value: false,
                  onChanged: (check) {},
                  controlAffinity: ListTileControlAffinity.platform,
                ),
                CheckboxListTile(
                  title: const Text(
                    "Not specified",
                    style: kTextStyle,
                  ),
                  // contentPadding: EdgeInsets.zero,
                  value: false,
                  onChanged: (check) {},
                  controlAffinity: ListTileControlAffinity.platform,
                ),
                DataInput(
                    paddingGeneral: const EdgeInsets.only(bottom: 0),
                    onSubmit: (s) {},
                    onValidate: (s) {}),
              ],
            ),
            DropDownDefault(
                title: "Crown class",
                onChangedFn: (s) {},
                itemsList: const ["D", "C", "I", "S", "V", "N", "M"],
                selectedItem: "Please select tree status"),
            DataInput(
                title: "Height to base of live crown",
                onSubmit: (s) {},
                onValidate: (s) {}),
            DataInput(
                title: "Height to top of live crown",
                onSubmit: (s) {},
                onValidate: (s) {}),
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
            DataInput(
                title: "Azimuth to tree", onSubmit: (s) {}, onValidate: (s) {}),
            DataInput(
                title: "Distance to tree face",
                onSubmit: (s) {},
                onValidate: (s) {}),
            DataInput(
                title: "Live crown length",
                onSubmit: (s) {},
                onValidate: (s) {}),
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
