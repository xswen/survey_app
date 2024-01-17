import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/Expansion/test.dart';
import 'package:survey_app/widgets/checkbox/hide_info_checkbox.dart';
import 'package:survey_app/widgets/data_input/data_input.dart';
import 'package:survey_app/widgets/dropdowns/drop_down_default.dart';
import 'package:survey_app/widgets/text/text_header_separator.dart';

class GroundPlotSiteInfoPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotSiteInfo";
  final GoRouterState state;
  const GroundPlotSiteInfoPage(this.state, {super.key});

  @override
  GroundPlotSiteInfoPageState createState() => GroundPlotSiteInfoPageState();
}

class GroundPlotSiteInfoPageState
    extends ConsumerState<GroundPlotSiteInfoPage> {
  List<String> test = ["test", "test"];
  bool plotComp = false;

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");

    return Scaffold(
      appBar: const OurAppBar("Ground Plot Site Info"),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
        child: ListView(
          children: [
            const ExpansionTitle(
              title: "Site Info",
              children: [Text("hi")],
            ),

            const SizedBox(height: kPaddingH), //Plot Completion
            Column(
              children: [
                const TextHeaderSeparator(title: "Site Info"),
                DropDownDefault(
                    title: "Ecozone",
                    onChangedFn: (s) {},
                    itemsList: test,
                    selectedItem: ""),
                DataInput(
                    title: "Provincial ecosystem type",
                    onSubmit: (s) {},
                    onValidate: (s) {}),
                HideInfoCheckbox(
                  title: "Provincial Ecosystem type reference",
                  checkTitle: "Unreported",
                  checkValue: false,
                  child: DataInput(
                    generalPadding: EdgeInsets.zero,
                    textBoxPadding: EdgeInsets.zero,
                    onSubmit: (s) {},
                    onValidate: (s) {},
                  ),
                ),
                HideInfoCheckbox(
                  title: "Measurement of slope gradient",
                  checkTitle: "Unreported",
                  checkValue: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: DataInput(
                          generalPadding: EdgeInsets.zero,
                          textBoxPadding: EdgeInsets.zero,
                          onSubmit: (s) {},
                          onValidate: (s) {},
                        ),
                      ),
                      const SizedBox(
                        width: kPaddingH,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Popups.show(
                              context,
                              AlertDialog(
                                title: const Text('Measurement in degrees'),
                                content: DataInput(
                                  generalPadding: EdgeInsets.zero,
                                  textBoxPadding: EdgeInsets.zero,
                                  onSubmit: (s) {},
                                  onValidate: (s) {},
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text('Calculate'),
                                    onPressed: () {
                                      context.pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text("Caculate with degree")),
                    ],
                  ),
                ),
                HideInfoCheckbox(
                  title: "Orientation of slope",
                  checkTitle: "Unreported",
                  checkValue: false,
                  child: HideInfoCheckbox(
                    padding: EdgeInsets.zero,
                    checkTitle: "Flat terrain",
                    checkValue: false,
                    child: DataInput(
                      generalPadding: EdgeInsets.zero,
                      textBoxPadding: EdgeInsets.zero,
                      onSubmit: (s) {},
                      onValidate: (s) {},
                    ),
                  ),
                ),
              ],
            ), //Site Info
          ],
        ),
      )),
    );
  }
}
