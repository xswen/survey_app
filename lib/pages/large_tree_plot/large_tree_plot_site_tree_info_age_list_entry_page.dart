import 'package:survey_app/barrels/page_imports_barrel.dart';

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
                  .then((value) => setState(() => null)),
            ),
            DataInput(
                title: "Tree number", onSubmit: (s) {}, onValidate: (s) {}),
            ReferenceNameSelectBuilder(
              title: "Tree type",
              defaultSelectedValue: "Please select tree type",
              name: db.referenceTablesDao.getLtpTreeTypeName(""),
              asyncListFn: db.referenceTablesDao.getLtpTreeTypeList,
              enabled: true,
              searchable: true,
              onChange: (s) => db.referenceTablesDao
                  .getLtpTreeTypeCode(s)
                  .then((value) => setState(() => null)),
            ),
            DataInput(
                title: "Outside bark diameter at bored height",
                onSubmit: (s) {},
                onValidate: (s) {}),
            DataInput(
                title: "Bored height", onSubmit: (s) {}, onValidate: (s) {}),
            ReferenceNameSelectBuilder(
              title: "Site height suitability",
              defaultSelectedValue: "Please select suitability",
              name: db.referenceTablesDao.getLtpSiteHeightSuitabilityName(""),
              asyncListFn:
                  db.referenceTablesDao.getLtpSiteHeightSuitabilityList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getLtpSiteHeightSuitabilityCode(s)
                  .then((value) => setState(() => null)),
            ),
            ReferenceNameSelectBuilder(
              title: "Site age suitability",
              defaultSelectedValue: "Please select suitability",
              name: db.referenceTablesDao.getLtpSiteAgeSuitabilityName(""),
              asyncListFn: db.referenceTablesDao.getLtpSiteAgeSuitabilityList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getLtpSiteAgeSuitabilityCode(s)
                  .then((value) => setState(() => null)),
            ),
            DataInput(title: "Field age", onSubmit: (s) {}, onValidate: (s) {}),
            ReferenceNameSelectBuilder(
              title: "Prorate code",
              defaultSelectedValue: "Please select code",
              name: db.referenceTablesDao.getLtpProrateName(""),
              asyncListFn: db.referenceTablesDao.getLtpProrateList,
              enabled: true,
              onChange: (s) => db.referenceTablesDao
                  .getLtpProrateCode(s)
                  .then((value) => setState(() => null)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kPaddingV * 2),
              child: SaveEntryButton(
                saveRetFn: () => null,
                saveAndAddFn: () => null,
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
