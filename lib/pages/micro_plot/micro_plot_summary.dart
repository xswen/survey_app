import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/dropdowns/drop_down_default.dart';

import '../../formatters/thousands_formatter.dart';
import '../../widgets/checkbox/hide_info_checkbox.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/disable_widget.dart';

class MicroPlotSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "microPlotSummary";
  final GoRouterState state;
  const MicroPlotSummaryPage(this.state, {super.key});

  @override
  MicroPlotSummaryPageState createState() => MicroPlotSummaryPageState();
}

class MicroPlotSummaryPageState extends ConsumerState<MicroPlotSummaryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: const OurAppBar("Title"),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
              child: ListView(
                children: [
                  DropDownDefault(
                      title: "Plot Type",
                      onChangedFn: (s) {},
                      itemsList: const [
                        "MPC: circular mini-plot",
                        "MPS: square mini-plot"
                      ],
                      selectedItem: ""),
                  DropDownDefault(
                      title: "Temp Type",
                      onChangedFn: (s) {},
                      enabled: false,
                      itemsList: const [
                        "MPC: circular mini-plot",
                        "MPS: square mini-plot"
                      ],
                      selectedItem: ""),
                  DisableWidget(
                    disabled: false,
                    child: HideInfoCheckbox(
                      title: "Nominal Plot Size",
                      titleWidget: "Unreported",
                      checkValue: false,
                      onChange: (b) {
                        // stp.nomPlotSize.value == -1
                        // ? updateStpData(
                        //     stp.copyWith(nomPlotSize: const d.Value(null)))
                        // : updateStpData(
                        //     stp.copyWith(nomPlotSize: const d.Value(-1)));
                      },
                      child: DataInput(
                          boxLabel: "Report to the nearest 0.0001ha",
                          prefixIcon: FontAwesomeIcons.rulerCombined,
                          suffixVal: "ha",
                          inputType: const TextInputType.numberWithOptions(
                              decimal: true),
                          startingStr: "",
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                            ThousandsFormatter(
                                allowFraction: true,
                                decimalPlaces: 6,
                                maxDigitsBeforeDecimal: 1),
                          ],
                          paddingGeneral: const EdgeInsets.only(top: 0),
                          onSubmit: (s) {
                            // s.isEmpty
                            //     ? updateStpData(stp.copyWith(
                            //         nomPlotSize: const d.Value(null)))
                            //     : _errorNom(s) == null
                            //         ? updateStpData(stp.copyWith(
                            //             nomPlotSize: d.Value(double.parse(s))))
                            //         : stp = stp.copyWith(
                            //             nomPlotSize: d.Value(double.parse(s)));
                          },
                          onValidate: (s) => null),
                    ),
                  ),
                ],
              ))),
    );
  }
}
