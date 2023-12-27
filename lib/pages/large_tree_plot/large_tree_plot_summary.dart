import 'package:survey_app/barrels/page_imports_barrel.dart';

import '../../widgets/date_select.dart';

class LargeTreePlotSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "largeTreePlotSummary";
  final GoRouterState state;
  const LargeTreePlotSummaryPage(this.state, {super.key});

  @override
  LargeTreePlotSummaryPageState createState() =>
      LargeTreePlotSummaryPageState();
}

class LargeTreePlotSummaryPageState
    extends ConsumerState<LargeTreePlotSummaryPage> {
  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: OurAppBar(
        "Large Tree Plot",
        backFn: () {
          //ref.refresh(updateSurveyCardProvider(surveyId));
          context.pop();
        },
      ),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
          child: ListView(
            children: [
              CalendarSelect(
                date: DateTime.now(),
                label: "Enter Measurement Date",
                readOnly: false,
                setStateFn: (DateTime date) async => (),
              ),
              // DropDownDefault(
              //     title: "Plot type",
              //     onChangedFn: (s) {},
              //     itemsList: [],
              //     selectedItem: "Please select plot type"),
              // DataInput(
              //     title: "Nominal Plot Size",
              //     onSubmit: (s) {},
              //     onValidate: (s) {}),
              // DataInput(
              //     title: "Measured Plot Size",
              //     onSubmit: (s) {},
              //     onValidate: (s) {}),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //       vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       const Text(
              //         "Species",
              //         style: TextStyle(fontSize: kTextTitleSize),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(left: kPaddingH),
              //         child: ElevatedButton(
              //             onPressed: () async => context.pushNamed(
              //                 SmallTreeSpeciesEntryPage.routeName,
              //                 pathParameters: widget.state.pathParameters),
              //             style: ButtonStyle(
              //                 backgroundColor: false
              //                     ? MaterialStateProperty.all<Color>(
              //                     Colors.grey)
              //                     : null),
              //             child: const Text("Add species")),
              //       ),
              //     ],
              //   ),
              // ),
              // Expanded(
              //   child: TableCreationBuilder(
              //       source: getSourceBuilder(["hi"]),
              //       colNames: columnData.getColHeadersList(),
              //       onCellTap: (DataGridCellTapDetails details) {}),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
