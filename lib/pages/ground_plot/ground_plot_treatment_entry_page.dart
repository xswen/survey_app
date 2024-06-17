import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/checkbox/hide_info_checkbox.dart';

import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_default.dart';

class GroundPlotTreatmentEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotTreatmentEntry";
  final GoRouterState state;
  const GroundPlotTreatmentEntryPage(this.state, {super.key});

  @override
  GroundPlotTreatmentEntryPageState createState() =>
      GroundPlotTreatmentEntryPageState();
}

class GroundPlotTreatmentEntryPageState
    extends ConsumerState<GroundPlotTreatmentEntryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: const OurAppBar("Treatment Entry"),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      bottomNavigationBar:
          ElevatedButton(child: const Text("Save"), onPressed: () {}),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
        child: ListView(
          children: [
            DropDownDefault(
                title: "Type",
                onChangedFn: (s) {},
                itemsList: const ["CC", "PC"],
                selectedItem: ""),
            DataInput(
                title: "Treatment year", onSubmit: (s) {}, onValidate: (s) {
                  return null;
                }),
            HideInfoCheckbox(
              title: "Treatment extent",
              titleWidget: "Unreported",
              checkValue: false,
              child: DataInput(
                  paddingGeneral: EdgeInsets.zero,
                  paddingTextbox: EdgeInsets.zero,
                  onSubmit: (s) {},
                  onValidate: (s) {
                    return null;
                  }),
            )
          ],
        ),
      )),
    );
  }
}
