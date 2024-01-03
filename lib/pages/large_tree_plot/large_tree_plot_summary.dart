import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_site_tree_info_age_list_page.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_tree_info_list_page.dart';
import 'package:survey_app/pages/large_tree_plot/large_tree_plot_tree_removed_list_page.dart';

import '../../widgets/buttons/icon_nav_button.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/dropdowns/drop_down_default.dart';

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
              DropDownDefault(
                  title: "Plot type",
                  onChangedFn: (s) {},
                  itemsList: [],
                  selectedItem: "Please select plot type"),
              DataInput(
                  title: "Nominal plot Size",
                  onSubmit: (s) {},
                  onValidate: (s) {}),
              DataInput(
                  title: "Measured plot Size",
                  onSubmit: (s) {},
                  onValidate: (s) {}),
              DropDownDefault(
                  title: "Plot split",
                  onChangedFn: (s) {},
                  itemsList: [],
                  selectedItem: "Please select plot split"),
              const SizedBox(height: kPaddingV),
              IconNavButton(
                icon: const Icon(FontAwesomeIcons.tree),
                space: kPaddingIcon,
                label: "Tree Information",
                onPressed: () {
                  context.pushNamed(LargeTreePlotTreeInfoListPage.routeName,
                      pathParameters: widget.state.pathParameters);
                },
                padding: const EdgeInsets.symmetric(vertical: kPaddingV),
              ),
              IconNavButton(
                icon: const Icon(FontAwesomeIcons.xmark),
                space: kPaddingIcon,
                label: "Removed Trees",
                onPressed: () {
                  context.pushNamed(LargeTreePlotTreeRemovedListPage.routeName,
                      pathParameters: widget.state.pathParameters);
                },
                padding: const EdgeInsets.symmetric(vertical: kPaddingV),
              ),
              IconNavButton(
                icon: const Icon(FontAwesomeIcons.info),
                space: kPaddingIcon,
                label: "Site Tree and Age Information",
                onPressed: () {
                  context.pushNamed(
                      LargeTreePlotSiteTreeInfoAgeListPage.routeName,
                      pathParameters: widget.state.pathParameters);
                },
                padding: const EdgeInsets.symmetric(vertical: kPaddingV),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
