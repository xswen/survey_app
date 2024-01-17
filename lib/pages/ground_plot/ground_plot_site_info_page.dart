import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/Expansion/expansion_title.dart';
import 'package:survey_app/widgets/checkbox/custom_checkbox.dart';
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
  bool? plotComp;
  bool unreported = false;
  bool flat = true;

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");

    return Scaffold(
      appBar: const OurAppBar("Ground Plot Site Info"),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      bottomNavigationBar:
          ElevatedButton(child: Text("Save"), onPressed: () => null),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
        child: ListView(
          children: [
            Column(
              children: [
                const TextHeaderSeparator(title: "Plot Completion"),
                DropDownDefault(
                    title: "Plot completion",
                    onChangedFn: (s) {
                      setState(() {
                        s == "Full" ? plotComp = true : plotComp = false;
                      });
                    },
                    itemsList: const ["Full", "Partial", "Unavailable"],
                    selectedItem: "Please select completion level"),
                Visibility(
                  visible: plotComp != null && !plotComp!,
                  child: DropDownDefault(
                    title: "Reason",
                    onChangedFn: (s) {},
                    itemsList: test,
                    selectedItem:
                        "Please select a reason for why plot wasn't completed",
                  ),
                ),
                const SizedBox(height: kPaddingH),
              ],
            ), //Plot completion
            ExpansionTitle(
              title: "Site Info",
              children: [
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
                          onValidate: (s) {
                            return null;
                          },
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
                HideInfoCheckbox(
                  title: "Elevation at plot center",
                  checkTitle: "Unreported",
                  checkValue: false,
                  child: DataInput(
                    generalPadding: EdgeInsets.zero,
                    textBoxPadding: EdgeInsets.zero,
                    onSubmit: (s) {},
                    onValidate: (s) {},
                  ),
                ),
              ],
            ),
            ExpansionTitle(
              title: "Land Cover Classification",
              children: [
                DropDownDefault(
                  title: "Land Base",
                  onChangedFn: (s) {},
                  itemsList: test,
                  selectedItem: "Please select",
                ),
                DropDownDefault(
                  title: "Land Cover",
                  onChangedFn: (s) {},
                  itemsList: test,
                  selectedItem: "Please select",
                ),
                DropDownDefault(
                  title: "Land Position",
                  onChangedFn: (s) {},
                  itemsList: test,
                  selectedItem: "Please select",
                ),
                DropDownDefault(
                  title: "Vegetation type",
                  onChangedFn: (s) {},
                  itemsList: test,
                  selectedItem: "Please select",
                ),
                DropDownDefault(
                  title: "Density class",
                  onChangedFn: (s) {},
                  itemsList: test,
                  selectedItem: "Please select",
                ),
                DropDownDefault(
                  title: "Stand structure",
                  onChangedFn: (s) {},
                  itemsList: test,
                  selectedItem: "Please select",
                ),
                DropDownDefault(
                  title: "Succession stage",
                  onChangedFn: (s) {},
                  itemsList: test,
                  selectedItem: "Please select",
                ),
                DropDownDefault(
                  title: "Wetland class",
                  onChangedFn: (s) {},
                  itemsList: test,
                  selectedItem: "Please select",
                ),
              ],
            ),
            ExpansionTitle(
              title: "Plot Center Location",
              children: [
                CustomCheckbox(
                  title: "Coordinates are post-processed",
                  checkValue: false,
                ),
                DataInput(
                    title: "UTM Northing",
                    onSubmit: (s) {},
                    onValidate: (s) {}),
                DataInput(
                    title: "UTM Easting", onSubmit: (s) {}, onValidate: (s) {}),
                DataInput(
                    title: "Field Accuracy Northing",
                    onSubmit: (s) {},
                    onValidate: (s) {}),
                DataInput(
                    title: "Field Accuracy Easting",
                    onSubmit: (s) {},
                    onValidate: (s) {}),
              ],
            ),
            ExpansionTitle(
              title: "General GPS Information",
              children: [
                DataInput(
                    title: "GPS Make", onSubmit: (s) {}, onValidate: (s) {}),
                DataInput(
                    title: "GPS Model", onSubmit: (s) {}, onValidate: (s) {}),
                HideInfoCheckbox(
                  title: "Points averaged",
                  checkTitle: "Unreported",
                  checkValue: false,
                  child: DataInput(onSubmit: (s) {}, onValidate: (s) {}),
                ),
                DropDownDefault(
                  title: "Density class",
                  onChangedFn: (s) {},
                  itemsList: [...test, "unreported"],
                  selectedItem: "Please select",
                ),
                DropDownDefault(
                  title: "UTM Zone",
                  onChangedFn: (s) {},
                  itemsList: [...test, "unreported"],
                  selectedItem: "Please select",
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
