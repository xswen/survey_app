import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/checkbox/hide_info_checkbox.dart';
import 'package:survey_app/widgets/data_input/data_input.dart';
import 'package:survey_app/widgets/dropdowns/drop_down_default.dart';

class GroundPlotDisturbanceEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotDisturbanceEntry";
  final GoRouterState state;
  const GroundPlotDisturbanceEntryPage(this.state, {super.key});

  @override
  GroundPlotDisturbanceEntryPageState createState() =>
      GroundPlotDisturbanceEntryPageState();
}

class GroundPlotDisturbanceEntryPageState
    extends ConsumerState<GroundPlotDisturbanceEntryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: const OurAppBar("Natural Disturbance Entry"),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      bottomNavigationBar:
          ElevatedButton(child: Text("Save"), onPressed: () => null),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
        child: ListView(
          children: [
            DropDownDefault(
                title: "Natural disturbance agent",
                onChangedFn: (s) {},
                itemsList: ["Fire", "Wind"],
                selectedItem: ""),
            HideInfoCheckbox(
              title: "Disturbance Year",
              titleWidget: "Unreported",
              checkValue: false,
              child: DataInput(
                paddingGeneral: EdgeInsets.zero,
                paddingTextbox: EdgeInsets.zero,
                onSubmit: (s) {},
                onValidate: (s) {},
              ),
            ),
            HideInfoCheckbox(
              title: "Extent of disturbance",
              titleWidget: "Unreported",
              checkValue: false,
              child: DataInput(
                paddingGeneral: EdgeInsets.zero,
                paddingTextbox: EdgeInsets.zero,
                onSubmit: (s) {},
                onValidate: (s) {},
              ),
            ),
            HideInfoCheckbox(
              title: "Extent of tree mortality",
              titleWidget: "Unreported",
              checkValue: false,
              child: DataInput(
                paddingGeneral: EdgeInsets.zero,
                paddingTextbox: EdgeInsets.zero,
                onSubmit: (s) {},
                onValidate: (s) {},
              ),
            ),
            DropDownDefault(
                title: "Basis for mortality extent",
                onChangedFn: (s) {},
                itemsList: const ["VL", "BA"],
                selectedItem: ""),
            SizedBox(
              height: kPaddingV * 2,
            ),
            const Text("Comment Box. To do"),
          ],
        ),
      )),
    );
  }
}
