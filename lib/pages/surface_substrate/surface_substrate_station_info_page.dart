import 'package:drift/drift.dart' as d;
import 'package:survey_app/providers/surface_substrate_providers.dart';

import '../../barrels/page_imports_barrel.dart';

class SurfaceSubstrateStationInfoPage extends ConsumerStatefulWidget {
  static const String routeName = "surfaceSubstrateStationInfo";
  final GoRouterState state;

  const SurfaceSubstrateStationInfoPage(this.state, {super.key});

  @override
  SurfaceSubstrateStationInfoPageState createState() =>
      SurfaceSubstrateStationInfoPageState();
}

class SurfaceSubstrateStationInfoPageState
    extends ConsumerState<SurfaceSubstrateStationInfoPage> {
  final String title = "Surface Substrate Station";
  late final int sshId;
  late SurfaceSubstrateTallyCompanion ssTally;

  @override
  void initState() {
    sshId = PathParamValue.getSsHeaderId(widget.state);
    ssTally = widget.state.extra as SurfaceSubstrateTallyCompanion;
    super.initState();
  }

  void createNewSsTallyCompanion() => ref
      .read(databaseProvider)
      .surfaceSubstrateTablesDao
      .getNextStationNum(sshId)
      .then((stationNum) => context.goNamed(
          SurfaceSubstrateStationInfoPage.routeName,
          pathParameters: PathParamGenerator.ssStationInfo(
              widget.state, (ssTally.stationNum.value + 1).toString()),
          extra: SurfaceSubstrateTallyCompanion(
              ssHeaderId: d.Value(sshId),
              stationNum: d.Value(ssTally.stationNum.value + 1))));

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    return Scaffold(
      appBar: OurAppBar(
        "$title: ${db.companionValueToStr(ssTally.stationNum)}",
        onLocaleChange: () {},
        backFn: () {
          ref.refresh(ssTallyDataListProvider(sshId));
          context.pop();
        },
      ),
      endDrawer: DrawerMenu(onLocaleChange: () {}),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: () async {
                createNewSsTallyCompanion();
              },
              child: const Text("Save and Add New Station")),
          ElevatedButton(
              onPressed: () {
                //TODO: Implement
                // context.goNamed(SurfaceSubstrateHeaderPage.routeName,
                //     pathParameters:
                //         PathParamGenerator.ssHeader(widget.state, sshId.toString()));
              },
              child: const Text("Save and Return")),
        ],
      ),
    );
    Text("$ssTally");
  }
}
