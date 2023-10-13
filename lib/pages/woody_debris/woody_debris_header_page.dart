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
  late int surveyId;
  late int wdId;
  late int wdhId;

  @override
  void initState() {
    surveyId = RouteParams.getSurveyId(widget.goRouterState);
    wdId = RouteParams.getWdSummaryId(widget.goRouterState);
    wdhId = RouteParams.getWdHeaderId(widget.goRouterState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
