import 'dart:collection';

import 'package:drift/drift.dart' as d;
import 'package:easy_localization/easy_localization.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/tags/tag_chips.dart';

import '../../l10n/locale_keys.g.dart';
import '../../providers/survey_info_providers.dart';
import '../../widgets/tile_cards/tile_card_dashboard.dart';
import 'create_survey_page.dart';
import 'survey_info_page.dart';

class DashboardPage extends ConsumerStatefulWidget {
  static const String routeName = "dashboard";
  const DashboardPage({super.key, required this.title});
  final String title;

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<SurveyHeader>> surveys =
        ref.watch(updateSurveyHeaderListProvider);
    HashSet<SurveyStatus> filters = ref.watch(dashboardSurveyFilterProvider);

    return Scaffold(
      appBar: const OurAppBar(LocaleKeys.dashboardTitle),
      endDrawer: DrawerMenu(
        onLocaleChange: () => setState(() {}),
      ),
      body: surveys.when(
        error: (err, stack) => Text("Error: $err"),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (surveys) => Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            label: const Text("Create New Survey"),
            icon: const Icon(FontAwesomeIcons.circlePlus),
            onPressed: () {
              context.pushNamed(
                CreateSurveyPage.routeName,
                extra: {
                  CreateSurveyPage.keySurvey: SurveyHeadersCompanion(
                      measNum: const d.Value(-1),
                      measDate: d.Value(DateTime.now())),
                  CreateSurveyPage.keyUpdateDash: () {}
                },
              );
            },
          ),
          body: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                spacing: kPaddingH,
                children: [
                  TagChip(
                    title: "All",
                    selected: filters.isEmpty,
                    onSelected: (selected) => ref
                        .read(dashboardSurveyFilterProvider.notifier)
                        .selectedAll(selected),
                  ),
                  TagChip(
                    title: "Completed",
                    selected: filters.contains(SurveyStatus.complete),
                    onSelected: (selected) => ref
                        .read(dashboardSurveyFilterProvider.notifier)
                        .selectedComplete(selected),
                  ),
                  TagChip(
                    title: "In Progress",
                    selected: filters.contains(SurveyStatus.inProgress),
                    onSelected: (selected) => ref
                        .read(dashboardSurveyFilterProvider.notifier)
                        .selectedInProgress(selected),
                  ),
                ],
              ),
              Expanded(
                child: surveys.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: kPaddingH),
                        child: Center(
                          child: const Text(
                            LocaleKeys.dashboardNoSurveys,
                            style: TextStyle(fontSize: kTextHeaderSize),
                          ).tr(),
                        ),
                      )
                    : ListView.builder(
                        itemCount: (surveys).length,
                        itemBuilder: (BuildContext cxt, int index) {
                          SurveyHeader survey = surveys[index];
                          return TitleCardDashboard(
                            surveyHeader: survey,
                            onTap: () async {
                              context.pushNamed(
                                SurveyInfoPage.routeName,
                                pathParameters:
                                    RouteParams.generateSurveyInfoParams(
                                        survey.id.toString()),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
