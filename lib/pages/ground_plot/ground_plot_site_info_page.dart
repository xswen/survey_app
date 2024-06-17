import 'dart:math';

import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/formatters/no_comma_formatter.dart';
import 'package:survey_app/widgets/Expansion/expansion_title.dart';
import 'package:survey_app/widgets/builders/reference_name_select_builder.dart';
import 'package:survey_app/widgets/checkbox/hide_info_checkbox.dart';
import 'package:survey_app/widgets/data_input/data_input.dart';
import 'package:survey_app/widgets/disable_widget.dart';
import 'package:survey_app/widgets/dropdowns/drop_down_default.dart';
import 'package:survey_app/widgets/text/text_header_separator.dart';

import '../../formatters/format_string.dart';
import '../../formatters/thousands_formatter.dart';
import '../../providers/ground_plot_providers.dart';
import 'ground_plot_summary_page.dart';

class GroundPlotSiteInfoPage extends ConsumerStatefulWidget {
  static const String routeName = "groundPlotSiteInfo";
  final GoRouterState state;

  const GroundPlotSiteInfoPage(this.state, {super.key});

  @override
  GroundPlotSiteInfoPageState createState() => GroundPlotSiteInfoPageState();
}

class GroundPlotSiteInfoPageState
    extends ConsumerState<GroundPlotSiteInfoPage> {
  final String title = "Ground Plot Site Info";
  List<String> test = ["test", "test"];
  bool? plotComp;
  bool unreported = false;
  bool flat = true;

  bool changeMade = false;
  late bool parentComplete = false;

  late final PopupDismiss completeWarningPopup;

  late final int gpSId;
  late GpSiteInfoCompanion siteInfo;

  final _slopeController = TextEditingController();

  @override
  void initState() {
    gpSId = PathParamValue.getGpSummaryId(widget.state);
    siteInfo = widget.state.extra as GpSiteInfoCompanion;
    completeWarningPopup = Popups.generateCompleteErrorPopup(title);

    _loadData();
    super.initState();
  }

  @override
  void dispose() {
    _slopeController.dispose();
    super.dispose();
  }

  void _loadData() async {
    final parent = await Database.instance.siteInfoTablesDao.getSummary(gpSId);

    if (mounted) {
      setState(() {
        parentComplete = parent.complete;
      });
    }
  }

  void updateSiteInfo(GpSiteInfoCompanion newSiteInfo) {
    changeMade = true;
    setState(() => siteInfo = newSiteInfo);
    print(siteInfo);
  }

  Future<String> getLandBaseName() {
    final db = ref.read(databaseProvider);
    if (siteInfo.plotCompletion == const d.Value.absent()) {
      return Future.value("Please select a plot completion first");
    } else {
      return db.referenceTablesDao
          .getGpSiteInfoLandBaseName(db.companionValueToStr(siteInfo.landBase));
    }
  }

  Future<String> getLandCoverName() {
    final db = ref.read(databaseProvider);
    if (siteInfo.plotCompletion == const d.Value.absent()) {
      return Future.value("Please select a plot completion first");
    } else if (siteInfo.landBase == const d.Value.absent()) {
      return Future.value("Please select land base first");
    } else {
      return db.referenceTablesDao.getGpSiteInfoLandCoverName(
          db.companionValueToStr(siteInfo.landCover));
    }
  }

  String? _errorTypeRef(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (value == "-1") {
      return null;
    } else if (int.parse(value) < 1 || int.parse(value) > 9999) {
      return "Reference number must be between 1 and 9999";
    }
    return null;
  }

  String? _errorSlope(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (value == "-1") {
      return null;
    } else if (int.parse(value) < 0 || int.parse(value) > 150) {
      return "Slope must be between 0 and 150";
    }
    return null;
  }

  String? _errorAspect(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (value == "-1" || value == "-999") {
      return null;
    } else if (int.parse(value) < 0 || int.parse(value) > 359) {
      return "Orientation of slope must be between 0 and 359";
    }
    return null;
  }

  String? _errorElevation(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (value == "-1") {
      return null;
    } else if (int.parse(value) < 0 || int.parse(value) > 5951) {
      return "Elevation must be between 0 and 5951";
    }
    return null;
  }

  String? _errorUtmN(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (int.parse(value) < 4614000 || int.parse(value) > 9297000) {
      return "UtmN must be between 4614000 and 9297000";
    }
    return null;
  }

  String? _errorUtmNAccuracy(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (value == "-1.0") {
      return null;
    } else if (double.parse(value) < 0.0 || double.parse(value) > 40.0) {
      return "UtmN accuracy must be between 0.000 and 40.000;";
    }
    return null;
  }

  String? _errorUtmE(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (int.parse(value) < 250000 || int.parse(value) > 750000) {
      return "UtmE must be between 250000 and 750000";
    }
    return null;
  }

  String? _errorUtmEAccuracy(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (value == "-1.0") {
      return null;
    } else if (double.parse(value) < 0.0 || double.parse(value) > 40.0) {
      return "UtmE accuracy must be between 0.000 and 40.000;";
    }
    return null;
  }

  String? _errorGpsMake(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (value.length > 25) {
      return "Must be under 25 characters";
    }
    return null;
  }

  String? _errorGpsModel(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (value.length > 25) {
      return "Must be under 25 characters";
    }
    return null;
  }

  String? _errorGpsPoints(String? value) {
    if (value == null || value == "") {
      return "Can't be left empty";
    } else if (value == "-1") {
      return null;
    } else if (int.parse(value) < 0 || int.parse(value) > 999) {
      return "Gps points must be between 0 and 999;";
    }
    return null;
  }

  List<String>? errorCheck() {
    final db = ref.read(databaseProvider);
    List<String> results = [];

    if (siteInfo.plotCompletion == const d.Value.absent()) {
      results.add("Plot type");
    }
    if (siteInfo.incompReason == const d.Value.absent()) {
      results.add("Missing plot completion reason");
    }
    if (siteInfo.ecozone == const d.Value.absent()) {
      results.add("Missing plot completion reason");
    }
    if (db.companionValueToStr(siteInfo.provEcoType).isEmpty) {
      results.add("Missing provincial ecosystem type");
    }
    if (_errorTypeRef(db.companionValueToStr(siteInfo.provEcoRef)) != null) {
      results.add("Provincial ecosystem type reference");
    }
    if (_errorSlope(db.companionValueToStr(siteInfo.slope)) != null) {
      results.add("Slope gradient");
    }

    if (_errorAspect(db.companionValueToStr(siteInfo.aspect)) != null) {
      results.add("Orientation of slope");
    }

    if (_errorElevation(db.companionValueToStr(siteInfo.elevation)) != null) {
      results.add("Elevation");
    }

    if (siteInfo.landBase == d.Value.absent()) {
      results.add("Land base");
    }

    if (siteInfo.landCover == d.Value.absent()) {
      results.add("Land cover");
    }
    if (siteInfo.landPos == d.Value.absent()) {
      results.add("Land position");
    }
    if (siteInfo.vegType == d.Value.absent()) {
      results.add("Vegetation type");
    }

    if (siteInfo.densityCl == d.Value.absent()) {
      results.add("Density class");
    }

    if (siteInfo.standStru == d.Value.absent()) {
      results.add("Stand structure");
    }

    if (siteInfo.succStage == d.Value.absent()) {
      results.add("Land base");
    }

    if (siteInfo.wetlandClass == d.Value.absent()) {
      results.add("Land base");
    }

    if (siteInfo.postProcessing == d.Value.absent()) {
      results.add("Post processing");
    }

    if (_errorUtmN(db.companionValueToStr(siteInfo.utmN)) != null) {
      results.add("Utm N");
    }

    if (_errorUtmNAccuracy(db.companionValueToStr(siteInfo.utmNAccuracy)) !=
        null) {
      results.add("Utm N Accuracy");
    }

    if (_errorUtmE(db.companionValueToStr(siteInfo.utmE)) != null) {
      results.add("Utm E");
    }

    if (_errorUtmEAccuracy(db.companionValueToStr(siteInfo.utmEAccuracy)) !=
        null) {
      results.add("Utm E Accuracy");
    }

    if (_errorGpsMake(db.companionValueToStr(siteInfo.gpsMake)) != null) {
      results.add("Gps Make");
    }

    if (_errorGpsModel(db.companionValueToStr(siteInfo.gpsModel)) != null) {
      results.add("Gps Model");
    }

    if (_errorGpsPoints(db.companionValueToStr(siteInfo.gpsPoint)) != null) {
      results.add("Gps Points");
    }

    if (siteInfo.utmZone == d.Value.absent()) {
      results.add("Utm Zone");
    }

    return results.isEmpty ? null : results;
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
          } else {
            context.pop();
          }
        },
      ),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      bottomNavigationBar: ElevatedButton(
          child: const Text("Save"),
          onPressed: () {
            if (parentComplete) {
              Popups.show(context, Popups.generateCompleteErrorPopup(title));
              return;
            }
            List<String>? errors = errorCheck();
            if (errors != null) {
              Popups.show(
                  context,
                  PopupDismiss(
                    "Error: Incorrect Data",
                    contentWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Errors were found in the following places",
                          textAlign: TextAlign.start,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            FormatString.generateBulletList(errors),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ));
            } else {
              db.siteInfoTablesDao
                  .addOrUpdateGpSiteInfo(siteInfo)
                  .then((siteId) {
                ref.refresh(GpSummaryDataProvider(gpSId));
                context.goNamed(GroundPlotSummaryPage.routeName,
                    pathParameters: PathParamGenerator.gpSummary(
                        widget.state, gpSId.toString()));
              });
            }
          }),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingV * 2, horizontal: kPaddingH / 2),
        child: ListView(
          children: [
            Column(
              children: [
                const TextHeaderSeparator(title: "Plot Completion"),
                ReferenceNameSelectBuilder(
                  name: db.referenceTablesDao.getGpSiteInfoPlotCompletionName(
                      db.companionValueToStr(siteInfo.plotCompletion)),
                  asyncListFn:
                      db.referenceTablesDao.getGpSiteInfoPlotCompletionList,
                  enabled: !parentComplete,
                  onChange: (s) => db.referenceTablesDao
                      .getGpSiteInfoPlotCompletionCode(s)
                      .then(
                    (value) {
                      if (db.companionValueToStr(siteInfo.plotCompletion) ==
                              "U" &&
                          s != "U") {
                        db.companionValueToStr(siteInfo.landBase) == "U"
                            ? updateSiteInfo(siteInfo.copyWith(
                                landBase: const d.Value.absent()))
                            : null;
                        updateSiteInfo(siteInfo.copyWith(
                          landCover: const d.Value.absent(),
                          vegType: const d.Value.absent(),
                          densityCl: const d.Value.absent(),
                          standStru: const d.Value.absent(),
                        ));
                      }
                      if (s == "F") {
                        updateSiteInfo(siteInfo.copyWith(
                            plotCompletion: d.Value(value),
                            incompReason: const d.Value("NA")));
                      } else {
                        updateSiteInfo(siteInfo.copyWith(
                            plotCompletion: d.Value(value),
                            incompReason: const d.Value.absent()));

                        if (s == "U") {
                          updateSiteInfo(siteInfo.copyWith(
                            landCover: const d.Value("U"),
                            vegType: const d.Value("U"),
                            densityCl: const d.Value("U"),
                            standStru: const d.Value("NA"),
                          ));
                        }
                      }
                    },
                  ),
                ),
                Visibility(
                  visible:
                      db.companionValueToStr(siteInfo.plotCompletion) != "F" &&
                          db
                              .companionValueToStr(siteInfo.plotCompletion)
                              .isNotEmpty,
                  child: ReferenceNameSelectBuilder(
                    title: "Reason",
                    name: db.referenceTablesDao
                        .getGpSiteInfoPlotIncompleteReasonName(
                            db.companionValueToStr(siteInfo.incompReason)),
                    asyncListFn: db.referenceTablesDao
                        .getGpSiteInfoPlotIncompleteReasonList,
                    enabled: !parentComplete,
                    onChange: (s) => db.referenceTablesDao
                        .getGpSiteInfoPlotIncompleteReasonCode(s)
                        .then(
                          (value) => updateSiteInfo(
                              siteInfo.copyWith(incompReason: d.Value(value))),
                        ),
                  ),
                ),
                const SizedBox(height: kPaddingH),
              ],
            ), //Plot completion
            ExpansionTitle(
              title: "Site Info",
              children: [
                ReferenceNameSelectBuilder(
                  title: "Ecozone",
                  name: db.referenceTablesDao.getGpSiteInfoEcozoneName(
                      db.companionValueToStr(siteInfo.ecozone)),
                  asyncListFn: db.referenceTablesDao.getGpSiteInfoEcozoneList,
                  enabled: !parentComplete,
                  onChange: (s) =>
                      db.referenceTablesDao.getGpSiteInfoEcozoneCode(s).then(
                            (value) => updateSiteInfo(
                                siteInfo.copyWith(ecozone: d.Value(value))),
                          ),
                ),
                DisableWidget(
                  disabled: parentComplete,
                  child: DataInput(
                      title: "Provincial ecosystem type",
                      boxLabel: "Note: No commas are allowed",
                      startingStr: db.companionValueToStr(siteInfo.provEcoType),
                      inputFormatters: [
                        NoCommaInputFormatter(),
                      ],
                      onSubmit: (s) => updateSiteInfo(
                          siteInfo.copyWith(provEcoType: d.Value(s))),
                      onValidate: (s) {
                        return null;
                      }),
                ),
                DisableWidget(
                  disabled: parentComplete,
                  child: HideInfoCheckbox(
                    title: "Provincial Ecosystem type reference",
                    titleWidget: "Unreported",
                    checkValue:
                        db.companionValueToStr(siteInfo.provEcoRef) == "-1",
                    onChange: (b) => b!
                        ? updateSiteInfo(
                            siteInfo.copyWith(provEcoRef: const d.Value(-1)))
                        : updateSiteInfo(siteInfo.copyWith(
                            provEcoRef: const d.Value.absent())),
                    child: DataInput(
                      boxLabel:
                          "Number assignment refers to a list of provincial classification manuals.",
                      startingStr: db.companionValueToStr(siteInfo.provEcoRef),
                      paddingGeneral: EdgeInsets.zero,
                      paddingTextbox: EdgeInsets.zero,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(4),
                        ThousandsFormatter(
                            allowFraction: false, maxDigitsBeforeDecimal: 4),
                      ],
                      onSubmit: (s) {
                        s.isEmpty
                            ? updateSiteInfo(siteInfo.copyWith(
                                provEcoRef: const d.Value.absent()))
                            : updateSiteInfo(siteInfo.copyWith(
                                provEcoRef: d.Value(int.parse(s))));
                      },
                      onValidate: _errorTypeRef,
                    ),
                  ),
                ),
                DisableWidget(
                  disabled: parentComplete,
                  child: HideInfoCheckbox(
                    title: "Measurement of slope gradient",
                    titleWidget: "Unreported",
                    checkValue: db.companionValueToStr(siteInfo.slope) == "-1",
                    onChange: (b) => b!
                        ? updateSiteInfo(
                            siteInfo.copyWith(slope: const d.Value(-1)))
                        : updateSiteInfo(
                            siteInfo.copyWith(slope: const d.Value.absent())),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: DataInput(
                            boxLabel:
                                "Slope is measured, in the field, using a "
                                "clinometer or similar instrument and is "
                                "reported in percent.",
                            startingStr: db.companionValueToStr(siteInfo.slope),
                            controller: _slopeController,
                            paddingGeneral: EdgeInsets.zero,
                            paddingTextbox: EdgeInsets.zero,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                              ThousandsFormatter(
                                  allowFraction: false, allowNegative: false),
                            ],
                            onSubmit: (s) {
                              s.isEmpty
                                  ? updateSiteInfo(siteInfo.copyWith(
                                      slope: const d.Value.absent()))
                                  : updateSiteInfo(siteInfo.copyWith(
                                      slope: d.Value(int.parse(s))));
                            },
                            onValidate: _errorSlope,
                          ),
                        ),
                        const SizedBox(
                          width: kPaddingH,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              int angle = 0;

                              Popups.show(
                                context,
                                AlertDialog(
                                  title: const Text('Measurement in degrees'),
                                  content: DataInput(
                                    paddingGeneral: EdgeInsets.zero,
                                    paddingTextbox: EdgeInsets.zero,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(3),
                                      ThousandsFormatter(
                                          allowFraction: false,
                                          allowNegative: false),
                                    ],
                                    onSubmit: (s) {
                                      if (int.parse(s) > 0 ||
                                          int.parse(s) < 360) {
                                        angle = int.parse(s);
                                      }
                                    },
                                    onValidate: (s) {
                                      if (angle < 0 || angle > 360) {
                                        return "Angle needs to be between 0 and 360";
                                      }

                                      return null;
                                    },
                                  ),
                                  actions: <Widget>[
                                    DisableWidget(
                                      disabled: angle < 0 || angle > 360,
                                      child: ElevatedButton(
                                        child: const Text('Calculate'),
                                        onPressed: () {
                                          int result =
                                              (100 * tan(angle * pi / 180))
                                                  .round();
                                          if (context.mounted) {
                                            setState(() => _slopeController
                                                .text = result.toString());
                                          }
                                          updateSiteInfo(siteInfo.copyWith(
                                              slope: d.Value(result)));
                                          context.pop();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            child: const Text("Calculate with degree")),
                      ],
                    ),
                  ),
                ),
                DisableWidget(
                  disabled: parentComplete,
                  child: HideInfoCheckbox(
                    title: "Orientation of slope",
                    titleWidget: "Unreported",
                    checkValue: db.companionValueToStr(siteInfo.aspect) == "-1",
                    onChange: (b) => b!
                        ? updateSiteInfo(
                            siteInfo.copyWith(aspect: const d.Value(-1)))
                        : updateSiteInfo(
                            siteInfo.copyWith(aspect: const d.Value.absent())),
                    child: HideInfoCheckbox(
                      padding: EdgeInsets.zero,
                      titleWidget: "Flat terrain",
                      checkValue:
                          db.companionValueToStr(siteInfo.aspect) == "999",
                      onChange: (b) => b!
                          ? updateSiteInfo(
                              siteInfo.copyWith(aspect: const d.Value(99)))
                          : updateSiteInfo(siteInfo.copyWith(
                              aspect: const d.Value.absent())),
                      child: DataInput(
                        paddingGeneral: EdgeInsets.zero,
                        paddingTextbox: EdgeInsets.zero,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(3),
                          ThousandsFormatter(
                              allowFraction: false, allowNegative: false),
                        ],
                        onSubmit: (s) {
                          s.isEmpty
                              ? updateSiteInfo(siteInfo.copyWith(
                                  aspect: const d.Value.absent()))
                              : updateSiteInfo(siteInfo.copyWith(
                                  aspect: d.Value(int.parse(s))));
                        },
                        onValidate: _errorAspect,
                      ),
                    ),
                  ),
                ),
                HideInfoCheckbox(
                  title: "Elevation at plot center",
                  titleWidget: "Unreported",
                  checkValue:
                      db.companionValueToStr(siteInfo.elevation) == "-1",
                  onChange: (b) => b!
                      ? updateSiteInfo(
                          siteInfo.copyWith(elevation: const d.Value(-1)))
                      : updateSiteInfo(
                          siteInfo.copyWith(elevation: const d.Value.absent())),
                  child: DataInput(
                    paddingGeneral: EdgeInsets.zero,
                    paddingTextbox: EdgeInsets.zero,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(4),
                      ThousandsFormatter(
                          allowFraction: false, allowNegative: false),
                    ],
                    onSubmit: (s) {
                      s.isEmpty
                          ? updateSiteInfo(siteInfo.copyWith(
                              elevation: const d.Value.absent()))
                          : updateSiteInfo(siteInfo.copyWith(
                              elevation: d.Value(int.parse(s))));
                    },
                    onValidate: _errorElevation,
                  ),
                ),
              ],
            ),
            ExpansionTitle(
              title: "Land Cover Classification",
              children: [
                ReferenceNameSelectBuilder(
                  title: "Land base",
                  name: getLandBaseName(),
                  asyncListFn: db.referenceTablesDao.getGpSiteInfoLandBaseList,
                  enabled: !parentComplete &&
                      siteInfo.plotCompletion != const d.Value.absent(),
                  disabledFn: (s) {
                    if (s == "U: unknown" &&
                        db.companionValueToStr(siteInfo.plotCompletion) ==
                            "U") {
                      return true;
                    }
                    return false;
                  },
                  onChange: (s) => db.referenceTablesDao
                      .getGpSiteInfoLandBaseCode(s)
                      .then((value) => updateSiteInfo(
                          siteInfo.copyWith(landBase: d.Value(value)))),
                ),
                ReferenceNameSelectBuilder(
                  title: "Land Cover",
                  name: getLandCoverName(),
                  asyncListFn: db.referenceTablesDao.getGpSiteInfoLandCoverList,
                  enabled: !parentComplete &&
                      siteInfo.plotCompletion != const d.Value.absent() &&
                      siteInfo.landBase != const d.Value.absent(),
                  disabledFn: (s) {
                    if (s == "U: unknown" &&
                        db.companionValueToStr(siteInfo.plotCompletion) ==
                            "U") {
                      return true;
                    }
                    return false;
                  },
                  onChange: (s) => db.referenceTablesDao
                      .getGpSiteInfoLandCoverCode(s)
                      .then((value) => updateSiteInfo(
                          siteInfo.copyWith(landCover: d.Value(value)))),
                ),
                ReferenceNameSelectBuilder(
                  title: "Land Position",
                  name: db.referenceTablesDao.getGpSiteInfoLandPosName(
                      db.companionValueToStr(siteInfo.landPos)),
                  asyncListFn: db.referenceTablesDao.getGpSiteInfoLandPosList,
                  enabled: !parentComplete &&
                      siteInfo.plotCompletion != const d.Value.absent(),
                  disabledFn: (s) {
                    if (s == "U: unknown" &&
                        db.companionValueToStr(siteInfo.plotCompletion) ==
                            "U") {
                      return true;
                    }
                    return false;
                  },
                  onChange: (s) => db.referenceTablesDao
                      .getGpSiteInfoLandPosCode(s)
                      .then((value) => updateSiteInfo(
                          siteInfo.copyWith(landPos: d.Value(value)))),
                ),
                ReferenceNameSelectBuilder(
                  title: "Vegetation type",
                  name: db.referenceTablesDao.getGpSiteInfoVegTypeName(
                      db.companionValueToStr(siteInfo.vegType)),
                  asyncListFn: db.referenceTablesDao.getGpSiteInfoVegTypeList,
                  enabled: !parentComplete &&
                      siteInfo.plotCompletion != const d.Value.absent(),
                  disabledFn: (s) {
                    if (s == "U: unknown" &&
                        db.companionValueToStr(siteInfo.plotCompletion) ==
                            "U") {
                      return true;
                    }
                    return false;
                  },
                  onChange: (s) => db.referenceTablesDao
                      .getGpSiteInfoVegTypeCode(s)
                      .then((value) => updateSiteInfo(
                          siteInfo.copyWith(vegType: d.Value(value)))),
                ),
                ReferenceNameSelectBuilder(
                  title: "Density class",
                  name: db.referenceTablesDao.getGpSiteInfoDensityName(
                      db.companionValueToStr(siteInfo.densityCl)),
                  asyncListFn: db.referenceTablesDao.getGpSiteInfoDensityList,
                  enabled: !parentComplete &&
                      siteInfo.plotCompletion != const d.Value.absent(),
                  disabledFn: (s) {
                    if (s == "U: unknown" &&
                        db.companionValueToStr(siteInfo.plotCompletion) ==
                            "U") {
                      return true;
                    }
                    return false;
                  },
                  onChange: (s) => db.referenceTablesDao
                      .getGpSiteInfoDensityCode(s)
                      .then((value) => updateSiteInfo(
                          siteInfo.copyWith(densityCl: d.Value(value)))),
                ),
                ReferenceNameSelectBuilder(
                  title: "Stand structure",
                  name: db.referenceTablesDao.getGpSiteInfoStandStructureName(
                      db.companionValueToStr(siteInfo.standStru)),
                  asyncListFn:
                      db.referenceTablesDao.getGpSiteInfoStandStructureList,
                  enabled: !parentComplete &&
                      siteInfo.plotCompletion != const d.Value.absent(),
                  disabledFn: (s) {
                    if (s == "U: unknown" &&
                        db.companionValueToStr(siteInfo.plotCompletion) ==
                            "U") {
                      return true;
                    }
                    return false;
                  },
                  onChange: (s) => db.referenceTablesDao
                      .getGpSiteInfoStandStructureCode(s)
                      .then((value) => updateSiteInfo(
                          siteInfo.copyWith(standStru: d.Value(value)))),
                ),
                ReferenceNameSelectBuilder(
                  title: "Succession stage",
                  name: db.referenceTablesDao.getGpSiteInfoSuccessionStageName(
                      db.companionValueToStr(siteInfo.succStage)),
                  asyncListFn:
                      db.referenceTablesDao.getGpSiteInfoSuccessionStageList,
                  enabled: !parentComplete &&
                      siteInfo.plotCompletion != const d.Value.absent(),
                  disabledFn: (s) {
                    if (s == "U: unknown" &&
                        db.companionValueToStr(siteInfo.plotCompletion) ==
                            "U") {
                      return true;
                    }
                    return false;
                  },
                  onChange: (s) => db.referenceTablesDao
                      .getGpSiteInfoSuccessionStageCode(s)
                      .then((value) => updateSiteInfo(
                          siteInfo.copyWith(succStage: d.Value(value)))),
                ),
                ReferenceNameSelectBuilder(
                  title: "Wetland class",
                  name: db.referenceTablesDao.getGpSiteInfoWetlandName(
                      db.companionValueToStr(siteInfo.wetlandClass)),
                  asyncListFn: db.referenceTablesDao.getGpSiteInfoWetlandList,
                  enabled: !parentComplete &&
                      siteInfo.plotCompletion != const d.Value.absent(),
                  disabledFn: (s) {
                    if (s == "U: unknown" &&
                        db.companionValueToStr(siteInfo.plotCompletion) ==
                            "U") {
                      return true;
                    }
                    return false;
                  },
                  onChange: (s) => db.referenceTablesDao
                      .getGpSiteInfoWetlandCode(s)
                      .then((value) => updateSiteInfo(
                          siteInfo.copyWith(wetlandClass: d.Value(value)))),
                ),
              ],
            ),
            ExpansionTitle(
              title: "Plot Center Location",
              children: [
                ReferenceNameSelectBuilder(
                  title: "Post Processing",
                  name: db.referenceTablesDao.getGpSiteInfoPostProcessingName(
                      db.companionValueToStr(siteInfo.postProcessing)),
                  asyncListFn:
                      db.referenceTablesDao.getGpSiteInfoPostProcessingList,
                  enabled: !parentComplete,
                  onChange: (s) => db.referenceTablesDao
                      .getGpSiteInfoPostProcessingCode(s)
                      .then((value) => value == "S"
                          ? updateSiteInfo(siteInfo.copyWith(
                              postProcessing: d.Value(value),
                              utmEAccuracy: const d.Value(-1),
                              utmNAccuracy: const d.Value(-1)))
                          : updateSiteInfo(siteInfo.copyWith(
                              postProcessing: d.Value(value)))),
                ),
                DisableWidget(
                  disabled: parentComplete,
                  child: DataInput(
                    title: "UTM northing",
                    boxLabel:
                        "The UTM northing that describes the centre point location "
                        "of a ground plot upon the national grid. The"
                        " coordinate is measured and report to the nearest meter,",
                    startingStr: db.companionValueToStr(siteInfo.utmN),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(7),
                      ThousandsFormatter(
                        allowFraction: false,
                      ),
                    ],
                    onSubmit: (s) {
                      s.isEmpty
                          ? updateSiteInfo(
                              siteInfo.copyWith(utmN: const d.Value.absent()))
                          : updateSiteInfo(
                              siteInfo.copyWith(utmN: d.Value(int.parse(s))));
                    },
                    onValidate: _errorUtmN,
                  ),
                ),
                DisableWidget(
                  disabled: parentComplete &&
                      db.companionValueToStr(siteInfo.postProcessing) == "S",
                  child: HideInfoCheckbox(
                    title: "Field accuracy northing",
                    titleWidget: "Not reported",
                    checkValue:
                        db.companionValueToStr(siteInfo.utmNAccuracy) == "-1.0",
                    onChange: (b) => b!
                        ? updateSiteInfo(
                            siteInfo.copyWith(utmNAccuracy: const d.Value(-1)))
                        : updateSiteInfo(siteInfo.copyWith(
                            utmNAccuracy: const d.Value.absent())),
                    child: DataInput(
                      boxLabel:
                          "Describes the accuracy of the UTM northing coordinate reported. Expressed in meters.",
                      startingStr:
                          db.companionValueToStr(siteInfo.utmNAccuracy),
                      paddingGeneral: EdgeInsets.zero,
                      paddingTextbox: EdgeInsets.zero,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
                        ThousandsFormatter(
                            allowFraction: true,
                            maxDigitsBeforeDecimal: 2,
                            decimalPlaces: 3),
                      ],
                      onSubmit: (s) {
                        s.isEmpty
                            ? updateSiteInfo(siteInfo.copyWith(
                                utmNAccuracy: const d.Value.absent()))
                            : updateSiteInfo(siteInfo.copyWith(
                                utmNAccuracy: d.Value(double.parse(s))));
                      },
                      onValidate: _errorUtmNAccuracy,
                    ),
                  ),
                ),
                DisableWidget(
                  disabled: parentComplete &&
                      db.companionValueToStr(siteInfo.postProcessing) == "S",
                  child: DataInput(
                    title: "UTM easting",
                    boxLabel:
                        "The UTM easting that describes the centre point location "
                        "of a ground plot upon the national grid. The"
                        " coordinate is measured and report to the nearest meter,",
                    startingStr: db.companionValueToStr(siteInfo.utmE),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                      ThousandsFormatter(
                        allowFraction: false,
                      ),
                    ],
                    onSubmit: (s) {
                      s.isEmpty
                          ? updateSiteInfo(
                              siteInfo.copyWith(utmE: const d.Value.absent()))
                          : updateSiteInfo(
                              siteInfo.copyWith(utmE: d.Value(int.parse(s))));
                    },
                    onValidate: _errorUtmE,
                  ),
                ),
                DisableWidget(
                  disabled: parentComplete,
                  child: HideInfoCheckbox(
                    title: "Field accuracy easting",
                    titleWidget: "Not reported",
                    checkValue:
                        db.companionValueToStr(siteInfo.utmEAccuracy) == "-1.0",
                    onChange: (b) => b!
                        ? updateSiteInfo(
                            siteInfo.copyWith(utmEAccuracy: const d.Value(-1)))
                        : updateSiteInfo(siteInfo.copyWith(
                            utmEAccuracy: const d.Value.absent())),
                    child: DataInput(
                      title: "UTM Easting",
                      boxLabel:
                          "Describes the accuracy of the UTM easting coordinate reported. Expressed in meters.",
                      startingStr:
                          db.companionValueToStr(siteInfo.utmEAccuracy),
                      paddingGeneral: EdgeInsets.zero,
                      paddingTextbox: EdgeInsets.zero,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
                        ThousandsFormatter(
                            allowFraction: true,
                            maxDigitsBeforeDecimal: 2,
                            decimalPlaces: 3),
                      ],
                      onSubmit: (s) {
                        s.isEmpty
                            ? updateSiteInfo(siteInfo.copyWith(
                                utmEAccuracy: const d.Value.absent()))
                            : updateSiteInfo(siteInfo.copyWith(
                                utmEAccuracy: d.Value(double.parse(s))));
                      },
                      onValidate: _errorUtmEAccuracy,
                    ),
                  ),
                ),
              ],
            ),
            ExpansionTitle(
              title: "General GPS Information",
              children: [
                DataInput(
                    title: "GPS Make",
                    startingStr: db.companionValueToStr(siteInfo.gpsMake),
                    onSubmit: (s) {
                      s.isEmpty
                          ? updateSiteInfo(siteInfo.copyWith(
                              gpsMake: const d.Value.absent()))
                          : updateSiteInfo(
                              siteInfo.copyWith(gpsMake: d.Value(s)));
                    },
                    onValidate: _errorGpsMake),
                DataInput(
                    title: "GPS Model",
                    startingStr: db.companionValueToStr(siteInfo.gpsModel),
                    onSubmit: (s) {
                      s.isEmpty
                          ? updateSiteInfo(siteInfo.copyWith(
                              gpsModel: const d.Value.absent()))
                          : updateSiteInfo(
                              siteInfo.copyWith(gpsModel: d.Value(s)));
                    },
                    onValidate: _errorGpsModel),
                HideInfoCheckbox(
                  title: "Points averaged",
                  titleWidget: "Unreported",
                  checkValue: db.companionValueToStr(siteInfo.gpsPoint) == "-1",
                  child: DataInput(
                      onSubmit: (s) {},
                      onValidate: (s) {
                        return null;
                      }),
                ),
                DropDownDefault(
                  title: "Density class",
                  onChangedFn: (s) {},
                  itemsList: [...test, "unreported"],
                  selectedItem: "Please select",
                ),
                DropDownDefault(
                  title: "UTM Zone",
                  onChangedFn: (s) {},
                  itemsList: [...test, "unreported"],
                  selectedItem: "Please select",
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
