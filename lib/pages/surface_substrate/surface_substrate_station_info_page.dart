import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/pages/surface_substrate/surface_substrate_header_page.dart';
import 'package:survey_app/providers/surface_substrate_providers.dart';
import 'package:survey_app/widgets/builders/substrate_depth_select_builder.dart';
import 'package:survey_app/widgets/buttons/delete_button.dart';
import 'package:survey_app/widgets/data_input/data_input.dart';
import 'package:survey_app/widgets/hide_info_checkbox.dart';
import 'package:survey_app/widgets/popups/popup_errors_found_list.dart';

import '../../barrels/page_imports_barrel.dart';
import '../../formatters/thousands_formatter.dart';
import '../../widgets/builders/substrate_type_select_builder.dart';
import '../delete_page.dart';

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
  late bool moreInfo;
  late SurfaceSubstrateTallyCompanion station;

  @override
  void initState() {
    sshId = PathParamValue.getSsHeaderId(widget.state);
    station = widget.state.extra as SurfaceSubstrateTallyCompanion;
    moreInfo = false;
    super.initState();
  }

  void addOrUpdateSsTally(void Function() fn) => ref
      .read(databaseProvider)
      .surfaceSubstrateTablesDao
      .addOrUpdateSsTally(station)
      .then((value) => fn());

  void returnToHeader() {
    ref.refresh(ssTallyDataListProvider(sshId));
    context.goNamed(SurfaceSubstrateHeaderPage.routeName,
        pathParameters:
            PathParamGenerator.ssHeader(widget.state, sshId.toString()));
  }

  void createNewSsTallyCompanion() => ref
          .read(databaseProvider)
          .surfaceSubstrateTablesDao
          .getNextStationNum(sshId)
          .then((stationNum) {
        if (stationNum > 25) {
          Popups.show(
              context,
              PopupContinue(
                "Max number of stations reached",
                contentText:
                    "You already have 25 stations. Please delete a previous station to add a new one.",
                rightBtnOnPressed: returnToHeader,
              ));
          return;
        }
        context.pushReplacementNamed(SurfaceSubstrateStationInfoPage.routeName,
            pathParameters: PathParamGenerator.ssStationInfo(
                widget.state, stationNum.toString()),
            extra: SurfaceSubstrateTallyCompanion(
              ssHeaderId: d.Value(sshId),
              stationNum: d.Value(stationNum),
            ));
      });

  List<String>? _errorCheck() {
    List<String> results = [];
    if (station.substrateType == const d.Value.absent()) {
      results.add("Missing substrate type");
    }
    if (station.depth == const d.Value.absent()) {
      results.add("Missing station depth");
    } else if (station.depth.value != kDataNotApplicable) {
      String? errorDepth = _errorSubstrateDepth(
          ref.read(databaseProvider).companionValueToStr(station.depth));
      if (errorDepth != null) results.add("Station depth: $errorDepth");
    }

    if (station.depthLimit == const d.Value.absent()) {
      results.add("Missing depth measured to");
    }

    return results.isEmpty ? null : results;
  }

  String? _errorSubstrateDepth(String? text) {
    if (text == null || text.isEmpty) {
      return "Can't be empty";
    }

    int val = int.parse(text);
    if (val != -1 && (1 > val || val > 500)) {
      return "Input out of range. Must be between 0 to 500 inclusive";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    return Scaffold(
      appBar: OurAppBar(
        "$title: ${db.companionValueToStr(station.stationNum)}",
        onLocaleChange: () {},
        backFn: () {
          ref.refresh(ssTallyDataListProvider(sshId));
          context.pop();
        },
      ),
      endDrawer: DrawerMenu(onLocaleChange: () {}),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingH),
        child: Center(
          child: ListView(
            children: [
              SubstrateTypeSelectBuilder(
                enabled: true,
                title: 'Substrate Type',
                updateType: (substrateTypeCode, depth) => setState(() =>
                    station = station.copyWith(
                        substrateType: substrateTypeCode,
                        depth: depth,
                        depthLimit: depth)),
                substrateTypeCode:
                    db.companionValueToStr(station.substrateType),
              ),
              station.substrateType != const d.Value.absent() &&
                      {"OM", "BM"}.contains(station.substrateType.value)
                  ? Column(
                      children: [
                        HideInfoCheckbox(
                          title: "Substrate Depth",
                          checkTitle: "Substrate Depth Missing",
                          checkValue:
                              db.companionValueToStr(station.depth) == "-1",
                          onChange: (b) {
                            b!
                                ? Popups.show(
                                    context,
                                    PopupContinue(
                                      "Warning: Setting depth as missing",
                                      contentText:
                                          "Are you sure you want to set depth as missing? ",
                                      rightBtnOnPressed: () {
                                        setState(() => station =
                                            station.copyWith(
                                                depth: const d.Value(-1)));
                                        context.pop();
                                      },
                                    ))
                                : setState(() => station = station.copyWith(
                                    depth: const d.Value.absent()));
                          },
                          child: DataInput(
                              boxLabel: "Report to the nearest 1m",
                              prefixIcon: FontAwesomeIcons.ruler,
                              suffixVal: "m",
                              inputType: const TextInputType.numberWithOptions(
                                  decimal: false),
                              startingStr:
                                  db.companionValueToStr(station.depth),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                                ThousandsFormatter(allowFraction: false),
                              ],
                              generalPadding: const EdgeInsets.all(0),
                              textBoxPadding: const EdgeInsets.all(0),
                              onSubmit: (String s) {
                                int? val = int.tryParse(s);
                                val != null
                                    ? setState(() => station =
                                        station.copyWith(depth: d.Value(val)))
                                    : null;
                              },
                              onValidate: _errorSubstrateDepth),
                        ),
                        SubstrateDepthSelectBuilder(
                          updateType: (depthLimit) => setState(() => station =
                              station.copyWith(depthLimit: depthLimit)),
                          substrateDepthCode:
                              db.companionValueToStr(station.depthLimit).isEmpty
                                  ? null
                                  : station.depthLimit.value,
                        )
                      ],
                    )
                  : Container(),
              const SizedBox(height: kPaddingV * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        List<String>? errors = _errorCheck();
                        if (errors != null) {
                          Popups.show(
                              context, PopupErrorsFoundList(errors: errors));
                        } else {
                          addOrUpdateSsTally(returnToHeader);
                        }
                      },
                      child: const Text("Save and Return")),
                  ElevatedButton(
                      onPressed: () async {
                        List<String>? errors = _errorCheck();
                        if (errors != null) {
                          Popups.show(
                              context, PopupErrorsFoundList(errors: errors));
                        } else {
                          addOrUpdateSsTally(createNewSsTallyCompanion);
                        }
                      },
                      child: const Text("Save and Add New Station")),
                ],
              ),
              station.id != const d.Value.absent()
                  ? DeleteButton(
                      delete: () => Popups.show(
                        context,
                        PopupContinue("Warning: Deleting Piece",
                            contentText: "You are about to delete this piece. "
                                "Are you sure you want to continue?",
                            rightBtnOnPressed: () {
                          //close popup
                          context.pop();
                          context.pushNamed(DeletePage.routeName, extra: {
                            DeletePage.keyObjectName:
                                "Surface Substrate Station: ${station.toString()}",
                            DeletePage.keyDeleteFn: () {
                              (db.delete(db.surfaceSubstrateTally)
                                    ..where((tbl) =>
                                        tbl.id.equals(station.id.value)))
                                  .go()
                                  .then((value) => returnToHeader());
                            },
                          });
                        }),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
    Text("$station");
  }
}
