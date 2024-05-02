import 'package:survey_app/barrels/page_imports_barrel.dart';

import '../../widgets/data_input/data_input.dart';
import '../../widgets/popups/popup_warning_change_made.dart';

class LargeTreePlotTreeRemovedListEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "largeTreePlotTreeRemovedEntryList";
  final GoRouterState state;
  const LargeTreePlotTreeRemovedListEntryPage(this.state, {super.key});

  @override
  LargeTreePlotTreeRemovedListEntryPageState createState() =>
      LargeTreePlotTreeRemovedListEntryPageState();
}

class LargeTreePlotTreeRemovedListEntryPageState
    extends ConsumerState<LargeTreePlotTreeRemovedListEntryPage> {
  bool changeMade = false;

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: OurAppBar(
        "Removed Tree",
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
            DataInput(
                title: "Tree number", onSubmit: (s) {}, onValidate: (s) {
                  return null;
                }),
            DataInput(title: "Reason", onSubmit: (s) {}, onValidate: (s) {
              return null;
            }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kPaddingV * 2),
              child: ElevatedButton(
                  onPressed: () {}, //handleSubmit(goToHorizonPage),
                  child: const Text("Save and return")),
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
