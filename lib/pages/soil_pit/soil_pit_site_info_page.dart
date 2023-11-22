import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/dropdowns/drop_down_async_list.dart';

import '../../widgets/text/text_header_separator.dart';

class SoilPitSiteInfoPage extends ConsumerStatefulWidget {
  static const String routeName = "siteInfo";
  final GoRouterState state;
  const SoilPitSiteInfoPage(this.state, {super.key});

  @override
  SoilPitSiteInfoPageState createState() => SoilPitSiteInfoPageState();
}

class SoilPitSiteInfoPageState extends ConsumerState<SoilPitSiteInfoPage> {
  final String title = "Site Info";
  bool changeMade = false;

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

    return Scaffold(
      appBar: OurAppBar(
        title,
        backFn: () {
          if (changeMade) {
            Popups.show(
                context,
                PopupContinue(
                  "Warning: Changes made",
                  contentText:
                      "Changes have been detected and will be discarded if "
                      "not saved first. Are you sure you want to go back?",
                  rightBtnOnPressed: () {
                    context.pop();
                    context.pop();
                  },
                ));
          }
          context.pop();
        },
      ),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingV * 2, horizontal: kPaddingH),
        child: Center(
            child: Column(
          children: [
            const TextHeaderSeparator(
              title: "CSC Soil Classification Field",
              fontSize: 20,
            ),
            DropDownAsyncList(
              searchable: true,
              enabled: true,
              title: "Order",
              onChangedFn: (s) {
                siteInfo = siteInfo.copyWith(
                    soilClassOrder: d.Value(s!),
                    soilClassGreatGroup: const d.Value.absent(),
                    soilClassSubGroup: const d.Value.absent(),
                    soilClass: const d.Value.absent());
              },
              selectedItem: db.companionValueToStr(siteInfo.soilClass).isEmpty
                  ? "Please select soil classification"
                  : db.companionValueToStr(siteInfo.soilClass),
              asyncItems: (s) => db.referenceTablesDao.getSoilClassNameList(),
            ),
          ],
        )),
      ),
    );
  }
}
