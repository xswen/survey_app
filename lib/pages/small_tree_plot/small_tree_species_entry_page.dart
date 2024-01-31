import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/checkbox/hide_info_checkbox.dart';

import '../../widgets/builders/reference_name_select_builder.dart';
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
