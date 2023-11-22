import 'package:survey_app/barrels/page_imports_barrel.dart';

class SoilPitSiteInfoPage extends ConsumerStatefulWidget {
  static const String routeName = "siteInfo";
  final GoRouterState state;
  const SoilPitSiteInfoPage(this.state, {super.key});

  @override
  SoilPitSiteInfoPageState createState() => SoilPitSiteInfoPageState();
}

class SoilPitSiteInfoPageState extends ConsumerState<SoilPitSiteInfoPage> {
  final String title = "Site Info";
  late final PopupDismiss completeWarningPopup;
  final PopupDismiss surveyCompleteWarningPopup =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  late final int spId;
  late SoilSiteInfoCompanion siteInfo;

  @override
  void initState() {
    spId = PathParamValue.getSoilPitSummary(widget.state);
    siteInfo = widget.state.extra as SoilSiteInfoCompanion;
    completeWarningPopup = Popups.generateCompleteErrorPopup(title);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    return const Placeholder();
  }
}
