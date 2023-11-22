import 'package:drift/drift.dart' as d;
import 'package:survey_app/barrels/page_imports_barrel.dart';

import '../../widgets/builders/soil_pit_code_select_builder.dart';

class SoilPitHorizonDescriptionEntryPage extends ConsumerStatefulWidget {
  static const String routeName = "soilPitHorizonDescriptionEntry";
  final GoRouterState state;
  const SoilPitHorizonDescriptionEntryPage(this.state, {super.key});

  @override
  SoilPitHorizonDescriptionEntryPageState createState() =>
      SoilPitHorizonDescriptionEntryPageState();
}

class SoilPitHorizonDescriptionEntryPageState
    extends ConsumerState<SoilPitHorizonDescriptionEntryPage> {
  final String title = "Soil Pit Horizon";
  bool changeMade = false;

  late final int spId;
  late SoilPitHorizonDescriptionCompanion horizon;
  late SoilPitHorizonDescriptionCompanion originalHorizon;

  @override
  void initState() {
    spId = PathParamValue.getSoilPitSummary(widget.state);
    horizon = widget.state.extra as SoilPitHorizonDescriptionCompanion;
    originalHorizon = widget.state.extra as SoilPitHorizonDescriptionCompanion;

    super.initState();
  }

  Future<String> getPitCodeName(String code) async {
    if (code.isEmpty) {
      return "Please select soil pit code";
    }

    return ref
        .read(databaseProvider)
        .referenceTablesDao
        .getSoilPitCodeFieldName(code);
  }

  Future<String> getSoilColorName(String code) async {
    if (code.isEmpty) {
      return "Please select soil pit code";
    }

    return ref.read(databaseProvider).referenceTablesDao.getSoilColorName(code);
  }

  Future<String> getSoilTextureName(String code) async {
    if (code.isEmpty) {
      return "Please select soil pit code";
    }

    return ref
        .read(databaseProvider)
        .referenceTablesDao
        .getSoilTextureName(code);
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    return Scaffold(
      appBar: OurAppBar(
        "$title: ${db.companionValueToStr(horizon.soilPitCodeField)}",
      ),
      endDrawer: DrawerMenu(onLocaleChange: () {}),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingH),
        child: Center(
          child: Column(children: [
            SoilPitCodeSelectBuilder(
                code: db.companionValueToStr(horizon.soilPitCodeField),
                initPlotCodeName: "",
                plotCodeNames:
                    db.referenceTablesDao.getSoilPitCodeFieldNameList(),
                usedPlotCodes: Future.value([]),
                onChange: (s) {
                  db.referenceTablesDao
                      .getSoilPitCodeCompiledCode(s!)
                      .then((code) {
                    if (code !=
                        db.companionValueToStr(horizon.soilPitCodeField)) {
                      setState(() {
                        horizon = horizon.copyWith(
                            soilPitCodeField: d.Value(code),
                            horizonNum: const d.Value.absent());
                      });
                    }
                  });
                }),
            // HideInfoCheckbox(
            //     title: "Soil feature noted from soil pit",
            //     checkTitle: "Unreported",
            //     checkValue:
            //     db.companionValueToStr(feature.soilPitSoilFeature) == "S",
            //     onChange: (b) {
            //       changeMade = true;
            //       b!
            //           ? setState(() => feature = feature.copyWith(
            //           soilPitSoilFeature: const d.Value("S"),
            //           depthFeature: const d.Value(-9)))
            //           : setState(() => feature = feature.copyWith(
            //           soilPitSoilFeature: const d.Value.absent(),
            //           depthFeature: const d.Value.absent()));
            //     },
            //     child: FutureBuilder(
            //         future: getFeatureName(
            //             db.companionValueToStr(feature.soilPitSoilFeature)),
            //         initialData: "Please select drainage",
            //         builder:
            //             (BuildContext context, AsyncSnapshot<String> text) {
            //           return DropDownAsyncList(
            //             searchable: true,
            //             padding: 0,
            //             onChangedFn: (s) {
            //               changeMade = true;
            //               db.referenceTablesDao
            //                   .getSoilPitFeatureClassCode(s!)
            //                   .then((code) => setState(() {
            //                 if (code == "N" || code == "S") {
            //                   feature = feature.copyWith(
            //                       soilPitSoilFeature: d.Value(code),
            //                       depthFeature: const d.Value(-9));
            //                 } else {
            //                   feature = feature.copyWith(
            //                       soilPitSoilFeature: d.Value(code));
            //                 }
            //               }));
            //             },
            //             asyncItems: (s) => db.referenceTablesDao
            //                 .getSoilPitFeatureClassNameList(),
            //             selectedItem:
            //             text.data ?? "Error loading drainage class name",
            //           );
            //         })),
            // db.companionValueToStr(feature.depthFeature) != "-9"
            //     ? DataInput(
            //   title: "Depth to soil feature",
            //   boxLabel: "Measured from “zero depth” to soil feature. "
            //       "“Zero depth” is mineral soil surface for mineral soils, "
            //       "and ground surface for organic soils.",
            //   prefixIcon: FontAwesomeIcons.ruler,
            //   suffixVal: "cm",
            //   startingStr: db.companionValueToStr(feature.depthFeature),
            //   onValidate: (s) => errorDepthFeature(s),
            //   inputType:
            //   const TextInputType.numberWithOptions(decimal: true),
            //   inputFormatters: [
            //     LengthLimitingTextInputFormatter(3),
            //     ThousandsFormatter(allowFraction: false),
            //   ],
            //   onSubmit: (s) {
            //     changeMade = true;
            //     s.isEmpty
            //         ? setState(() => feature = feature.copyWith(
            //         depthFeature: const d.Value.absent()))
            //         : setState(() => feature = feature.copyWith(
            //         depthFeature: d.Value(int.parse(s))));
            //   },
            // )
            //     : Container(),
            // Container(
            //     margin: const EdgeInsets.only(
            //         top: kPaddingV * 2, bottom: kPaddingV * 2),
            //     child: ElevatedButton(
            //         onPressed: () {
            //           List<String>? errors = errorCheck();
            //           if (errors != null) {
            //             Popups.show(
            //                 context,
            //                 PopupDismiss(
            //                   "Error: Incorrect Data",
            //                   contentWidget: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       const Text(
            //                         "Errors were found in the following places",
            //                         textAlign: TextAlign.start,
            //                       ),
            //                       Padding(
            //                         padding: const EdgeInsets.only(left: 12),
            //                         child: Text(
            //                           FormatString.generateBulletList(errors),
            //                           textAlign: TextAlign.start,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ));
            //           } else {
            //             db.soilPitTablesDao
            //                 .addOrUpdateFeature(feature)
            //                 .then((featureId) {
            //               ref.refresh(soilFeatureListProvider(spId));
            //               context.goNamed(SoilPitFeaturePage.routeName,
            //                   pathParameters: PathParamGenerator.soilPitSummary(
            //                       widget.state, spId.toString()));
            //             });
            //           }
            //         },
            //         child: const Text("Submit"))),
          ]),
        ),
      ),
    );
  }
}
