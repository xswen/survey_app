import 'package:dropdown_search/dropdown_search.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';

import '../../../providers/survey_info_providers.dart';

class SurveyInfoSummaryPage extends ConsumerStatefulWidget {
  static const String routeName = "surveyInfoSummary";
  final GoRouterState state;
  const SurveyInfoSummaryPage(this.state, {super.key});

  @override
  SurveyInfoSummaryPageState createState() => SurveyInfoSummaryPageState();
}

class SurveyInfoSummaryPageState extends ConsumerState<SurveyInfoSummaryPage> {
  final String title = "Survey Info Summary";
  late final int surveyId;
  late final PopupDismiss completeWarningPopup;

  late List<String> photosList = [];

  @override
  void initState() {
    surveyId = PathParamValue.getSurveyId(widget.state)!;
    completeWarningPopup = Popups.generateCompleteErrorPopup(title);

    _loadData();
    super.initState();
  }

  void _loadData() async {
    final photos = await Database.instance.surveyInfoTablesDao
        .getListGroundPlotPhoto(surveyId);
    print(photos);
    if (mounted) {
      // Only proceed if the widget is still in the tree
      setState(() {
        photosList = photos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: OurAppBar(
        "Survey Info Summary",
        backFn: () {
          ref.refresh(updateSurveyCardProvider(surveyId));
          context.pop();
        },
      ),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.fromLTRB(kPaddingH, 0, kPaddingH, kPaddingV / 2),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 0),
                child: Text(
                  "Ground Photos",
                  style: kTitleStyle,
                ),
              ),
              photosList.isEmpty
                  ? const Center(child: kLoadingWidget)
                  : DropdownSearch<String>.multiSelection(
                      popupProps: const PopupPropsMultiSelection.dialog(
                        showSelectedItems: true,
                        showSearchBox: true,
                        // disabledItemFn: widget.disabledItemFn,
                        searchDelay: Duration(microseconds: 0),
                      ),
                      enabled: true,
                      //   onBeforePopupOpening: widget.onBeforePopup,
                      onChanged: (photos) => db.surveyInfoTablesDao
                          .updateGroundPhoto(surveyId, photos)
                          .then((value) => setState(() => photosList = photos)),
                      items: const [
                        "Plot Pin (Center)",
                        "Transect 1 (0-15m)",
                        "Transect 1 (15-30m)",
                        "Transect 2 (0-15m)",
                        "Transect 2 (15-30m)",
                        "Horizontal",
                        "Canopy",
                        "Soil Profile",
                        "Other1 (describe)",
                        "Other2 (describe)",
                        "Other3 (describe)",
                        "Other4 (describe)"
                      ],
                      selectedItems: photosList,
                      clearButtonProps: const ClearButtonProps(isVisible: true),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
