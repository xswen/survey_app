import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';

part 'woody_debris_header_page.g.dart';

@riverpod
Future<bool> parentComplete(ParentCompleteRef ref, int wdId) async =>
    (await ref.read(databaseProvider).woodyDebrisTablesDao.getWdSummary(wdId))
        .complete;

@riverpod
Future<WoodyDebrisHeaderData> wdh(WdhRef ref, int wdhId) async =>
    ref.read(databaseProvider).woodyDebrisTablesDao.getWdHeader(wdhId);

class WoodyDebrisHeaderPage extends ConsumerStatefulWidget {
  static const String routeName = "woodyDebrisHeader";
  final GoRouterState goRouterState;
  const WoodyDebrisHeaderPage(this.goRouterState, {super.key});

  @override
  WoodyDebrisHeaderPageState createState() => WoodyDebrisHeaderPageState();
}

class WoodyDebrisHeaderPageState extends ConsumerState<WoodyDebrisHeaderPage> {
  final PopupDismiss completeWarningPopup =
      Popups.generateCompleteErrorPopup("Woody Debris Transect");
  final PopupDismiss surveyCompleteWarningPopup =
      Popups.generatePreviousMarkedCompleteErrorPopup("Woody Debris");

  late int wdId;
  late int wdhId;

  @override
  void initState() {
    wdId = RouteParams.getWdSummaryId(widget.goRouterState);
    wdhId = RouteParams.getWdHeaderId(widget.goRouterState);
    super.initState();
  }

  void updateWdhData(WoodyDebrisHeaderCompanion entry) {
    final db = ref.read(databaseProvider);

    (db.update(db.woodyDebrisHeader)..where((t) => t.id.equals(wdhId)))
        .write(entry);

    ref.refresh(wdhProvider(wdhId));
  }

  Future<int> getOrCreateWdSmallId() async {
    final db = ref.read(databaseProvider);

    WoodyDebrisSmallData? wdSm = await (db.select(db.woodyDebrisSmall)
          ..where((tbl) => tbl.wdHeaderId.equals(wdhId)))
        .getSingleOrNull();

    wdSm ??
        db.woodyDebrisTablesDao
            .addWdSmall(WoodyDebrisSmallCompanion(wdHeaderId: d.Value(wdhId)));

    return (await db.woodyDebrisTablesDao.getWdSmall(wdhId))!.id;
  }

  //Return null on no issue. Otherwise return error message
  List<String>? errorCheck(
      WoodyDebrisHeaderData wdh, WoodyDebrisSmallData? wdSm) {
    List<String> results = [];

    if (wdh.transAzimuth == null ||
        wdh.lcwdMeasLen == null ||
        wdh.mcwdMeasLen == null ||
        wdh.nomTransLen == null ||
        wdh.swdDecayClass == null ||
        wdh.swdMeasLen == null) {
      results.add("Transect Header Data");
    }
    if (wdSm == null) {
      results.add("Piece Measurements");
    }

    return results.isEmpty ? null : results;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);

    return const Placeholder();
  }
}
