import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/ecological_plot/ecological_plot_header_page.dart';
import 'package:survey_app/providers/ecological_plot_providers.dart';
import 'package:survey_app/widgets/buttons/custom_button_styles.dart';
import 'package:survey_app/widgets/popups/popup_marked_complete.dart';

import '../../providers/survey_info_providers.dart';
import '../../widgets/buttons/mark_complete_button.dart';
import '../../widgets/date_select.dart';
import '../../widgets/tile_cards/tile_card_transect.dart';
import '../delete_page.dart';
import 'ecological_plot_create_plot_page.dart';

class EcologicalPlotSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "ecologicalPlotSummary";
  final GoRouterState state;

  const EcologicalPlotSummaryPage(this.state, {super.key});

  @override
  EcologicalPlotSummaryPageState createState() =>
      EcologicalPlotSummaryPageState();
}

class EcologicalPlotSummaryPageState
    extends ConsumerState<EcologicalPlotSummaryPage> {
  final String title = "Ecological Plot";
  final PopupDismiss surveyCompleteWarningPopup =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  late final int surveyId;
  late final int ecpId;
  late final PopupDismiss completeWarningPopup;

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    ecpId = PathParamValue.getEcpSummaryId(widget.state);
    completeWarningPopup = Popups.generateCompleteErrorPopup(title);

    super.initState();
  }

  Future<void> updateEcpSummary(EcpSummaryCompanion entry) async {
    final db = ref.read(databaseProvider);
    (db.update(db.ecpSummary)..where((t) => t.id.equals(ecpId))).write(entry);
    ref.refresh(ecpDataProvider(ecpId));
  }

  void createPlot() {
    final db = ref.read(databaseProvider);

    db.ecologicalPlotTablesDao.ecpPlotAvailable(ecpId).then((available) =>
        !available
            ? Popups.show(
                context,
                const PopupDismiss(
                  "Error: No Plots available",
                  contentText:
                      "The max number of plots have already been created. "
                      "Please delete a pre-existing plot first to add "
                      "another plot.",
                ))
            : context.pushNamed(EcologicalPlotCreatePlotPage.routeName,
                pathParameters: PathParamGenerator.ecpSummary(
                    widget.state, ecpId.toString())));
  }

  void goToEcpHPage(int ecpHId) => context
          .pushNamed(EcologicalPlotHeaderPage.routeName,
              pathParameters:
                  PathParamGenerator.ecpHeader(widget.state, ecpHId.toString()))
          .then((value) {
        ref.refresh(ecpTransListProvider(ecpId));
        ref.refresh(ecpDataProvider(ecpId));
      });

  SurveyStatus getStatus(EcpHeaderData ecpH) {
    if (ecpH.complete) return SurveyStatus.complete;
    if (ecpH.ecpNum == null) return SurveyStatus.notStarted;
    return SurveyStatus.inProgress;
  }

  bool checkHeadersComplete(List<EcpHeaderData> transList) {
    for (int i = 0; i < transList.length; i++) {
      if (!transList[i].complete) return false;
    }
    return true;
  }

  void markComplete(EcpSummaryData ecp, List<EcpHeaderData> transList) {
    final db = ref.read(databaseProvider);

    db.surveyInfoTablesDao.getSurvey(ecp.surveyId).then((value) {
      bool surveyComplete = value.complete;
      if (surveyComplete) {
        Popups.show(context, surveyCompleteWarningPopup);
      } else if (ecp.complete) {
        updateEcpSummary(const EcpSummaryCompanion(complete: d.Value(false)));
      } else if (transList.isEmpty) {
        Popups.showMissingTransect(context);
      } else {
        if (checkHeadersComplete(transList)) {
          updateEcpSummary(const EcpSummaryCompanion(complete: d.Value(true)));
          Popups.show(context,
              const PopupMarkedComplete(title: "Ecological plot summary"));
        } else {
          Popups.showIncompleteTransect(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<EcpSummaryData> ecpSummary = ref.watch(ecpDataProvider(ecpId));
    AsyncValue<List<EcpHeaderData>> transList =
        ref.watch(ecpTransListProvider(ecpId));

    return ecpSummary.when(
        error: (err, stack) => Text("Error: $err"),
        loading: () => DefaultPageLoadingScaffold(title: title),
        data: (ecp) => transList.when(
              error: (err, stack) => Text("Error: $err"),
              loading: () => DefaultPageLoadingScaffold(title: title),
              data: (transList) => Scaffold(
                appBar: OurAppBar(
                  title,
                  complete: ecp.complete,
                  backFn: () {
                    ref.refresh(updateSurveyCardProvider(surveyId));
                    context.pop();
                  },
                ),
                endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
                bottomNavigationBar: MarkCompleteButton(
                    title: "Ecological Plot",
                    complete: ecp.complete,
                    onPressed: () => markComplete(ecp, transList)),
                body: Column(
                  children: [
                    CalendarSelect(
                      date: ecp.measDate,
                      label: "Enter Measurement Date",
                      readOnly: ecp.complete,
                      readOnlyPopup: completeWarningPopup,
                      onDateSelected: (DateTime date) async => updateEcpSummary(
                          EcpSummaryCompanion(measDate: d.Value(date))),
                    ),
                    const SizedBox(height: kPaddingV),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          kPaddingH, 0, kPaddingH, kPaddingV / 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Select a plot to enter data for:",
                            style: TextStyle(fontSize: kTextHeaderSize),
                          ),
                          ElevatedButton(
                              onPressed: () => ecp.complete
                                  ? Popups.show(
                                      context, surveyCompleteWarningPopup)
                                  : createPlot(),
                              style: CustomButtonStyles.inactiveButton(
                                  isActive: !ecp.complete),
                              child: const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: kPaddingH),
                                    child: Icon(
                                      FontAwesomeIcons.circlePlus,
                                      size: 20,
                                    ),
                                  ),
                                  Text("Add plot")
                                ],
                              )),
                        ],
                      ),
                    ),
                    transList.isEmpty
                        ? const Center(
                            child: Text("No plots created. Please add plot."))
                        : Expanded(
                            child: ListView.builder(
                                itemCount: transList.length,
                                itemBuilder: (BuildContext cxt, int index) {
                                  EcpHeaderData ecpH = transList[index];
                                  return TileCardTransect(
                                    title:
                                        "Plot ${ecpH.plotType}${ecpH.ecpNum}",
                                    onPressed: () async {
                                      ecp.complete
                                          ? Popups.show(
                                              context,
                                              Popups
                                                  .generateNoticeSurveyComplete(
                                                "Ecological Plot",
                                                () {
                                                  context.pop();
                                                  goToEcpHPage(ecpH.id);
                                                },
                                              ))
                                          : goToEcpHPage(ecpH.id);
                                    },
                                    status: getStatus(ecpH),
                                    onDelete: () => Popups.show(
                                      context,
                                      PopupContinue(
                                          "Warning: Deleting Ecological Plot",
                                          contentText:
                                              "You are about to delete plot "
                                              "${ecpH.plotType}${ecpH.ecpNum}. "
                                              "Are you sure you want to continue?",
                                          rightBtnOnPressed: () {
//close popup
                                        context.pop();
                                        context.pushNamed(DeletePage.routeName,
                                            extra: {
                                              DeletePage.keyObjectName:
                                                  "Ecological Plot ${ecpH.plotType}${ecpH.ecpNum}",
                                              DeletePage.keyDeleteFn: () {
                                                Database.instance
                                                    .ecologicalPlotTablesDao
                                                    .deleteEcpHeader(ecpH.id)
                                                    .then((value) {
                                                  ref.refresh(
                                                      ecpTransListProvider(
                                                          ecpId));
                                                  context.goNamed(
                                                      EcologicalPlotSummaryPage
                                                          .routeName,
                                                      pathParameters: widget
                                                          .state
                                                          .pathParameters);
                                                });
                                              },
                                            });
                                      }),
                                    ),
                                  );
                                }),
                          ),
                  ],
                ),
              ),
            ));
  }
}
