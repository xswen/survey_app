import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/providers/woody_debris_providers.dart';
import 'package:survey_app/wrappers/column_header_object.dart';

import '../../../widgets/text/text_header_separator.dart';

class ColNames {
  ColNames();
  ColumnHeaders id = ColumnHeaders(ColumnHeaders.headerNameId, visible: false);
  ColumnHeaders pieceNum = ColumnHeaders("Piece Number");
  ColumnHeaders type = ColumnHeaders("Type");
  ColumnHeaders genus = ColumnHeaders("Genus");
  ColumnHeaders species = ColumnHeaders("Species");
  ColumnHeaders horLen = ColumnHeaders("Horizontal Length");
  ColumnHeaders verDep = ColumnHeaders("Vertical Depth");
  ColumnHeaders diameter = ColumnHeaders("Diameter");
  ColumnHeaders tiltAngle = ColumnHeaders("Tilt Angle");
  ColumnHeaders decayClass = ColumnHeaders("Decay Class");
  ColumnHeaders edit = ColumnHeaders(ColumnHeaders.headerNameEdit, sort: false);

  String empty = "-";

  List<ColumnHeaders> getColHeadersList() => [
        pieceNum,
        type,
        genus,
        species,
        horLen,
        verDep,
        diameter,
        tiltAngle,
        decayClass,
        edit
      ];
}

class WoodyDebrisHeaderPieceMainPage extends ConsumerStatefulWidget {
  const WoodyDebrisHeaderPieceMainPage(this.goRouterState, {super.key});
  static const String routeName = "woodyDebrisHeaderPieceMain";

  final GoRouterState goRouterState;

  @override
  WoodyDebrisHeaderPieceMainPageState createState() =>
      WoodyDebrisHeaderPieceMainPageState();
}

class WoodyDebrisHeaderPieceMainPageState
    extends ConsumerState<WoodyDebrisHeaderPieceMainPage> {
  final PopupDismiss completeWarningPopup =
      Popups.generateCompleteErrorPopup("Wood Debris Piece");
  final PopupDismiss surveyCompleteWarningPopup =
      Popups.generatePreviousMarkedCompleteErrorPopup("Survey");

  late final int wdSmId;
  late final int wdhId;

  ColNames columnData = ColNames();

  @override
  void initState() {
    wdSmId = PathParamValue.getWdSmallId(widget.goRouterState);
    wdhId = PathParamValue.getWdHeaderId(widget.goRouterState)!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    final AsyncValue<WoodyDebrisHeaderData> wdh = ref.watch(wdhProvider(wdhId));
    final wdSmall = ref.watch(wdSmallProvider(wdhId));
    final pieceOdd = ref.watch(wdPieceOddProvider(wdhId));
    final pieceRound = ref.watch(wdPieceRoundProvider(wdhId));

    return wdh.when(
        data: (wdh) => Scaffold(
              appBar: OurAppBar("Woody Debris: Transect ${wdh.transNum}"),
              endDrawer: DrawerMenu(onLocaleChange: () {}),
              body: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: kPaddingV,
                    ),
                    const TextHeaderSeparator(title: "Small Woody Debris"),
                    const SizedBox(
                      height: kPaddingV,
                    ),

                    //Coarse Woody debris
                  ],
                ),
              ),
            ),
        error: (err, stack) => Text("Error: $err"),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
