import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/pages/soil_pit/soil_pit_summary_page.dart';
import 'package:survey_app/providers/soil_pit_providers.dart';
import 'package:survey_app/widgets/dropdowns/drop_down_async_list.dart';

import '../../formatters/format_string.dart';
import '../../formatters/thousands_formatter.dart';
import '../../widgets/data_input/data_input.dart';
import '../../widgets/text/text_header_separator.dart';

class SoilPitSiteInfoPage extends ConsumerStatefulWidget {
  static const String routeName = "siteInfo";
  final GoRouterState state;
  const SoilPitSiteInfoPage(this.state, {super.key});

  @override
  SoilPitSiteInfoPageState createState() => SoilPitSiteInfoPageState();
}

class SoilPitSiteInfoPageState extends ConsumerState<SoilPitSiteInfoPage> {
  final String title = "Soil Pit Site Info";
  final d.Value<String> kUnknownCode = const d.Value("UNKN");
  final d.Value<String> kNACode = const d.Value("N/A");

  bool changeMade = false;
  late bool parentComplete = false;

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

    _loadData();
    super.initState();
  }

  void _loadData() async {
    final parent = await Database.instance.soilPitTablesDao.getSummary(spId);

    if (mounted) {
      setState(() {
        parentComplete = parent.complete;
      });
    }
  }

  void updateSiteInfo(SoilSiteInfoCompanion newSiteInfo) {
    changeMade = true;
    setState(() => siteInfo = newSiteInfo);
  }

  Future<String> getDrainageName(String code) async {
    if (code.isEmpty) {
      return "Please select drainage class";
    }

    return ref
        .read(databaseProvider)
        .referenceTablesDao
        .getSoilDrainageName(int.parse(code));
  }

  Future<String> getMoistureName(String code) async {
    if (code.isEmpty) {
      return "Please select moisture class";
    }

    return ref
        .read(databaseProvider)
        .referenceTablesDao
        .getSoilMoistureName(int.parse(code));
  }

  Future<String> getDepositionName(String code) async {
    if (code.isEmpty) {
      return "Please select deposition";
    }

    return ref
        .read(databaseProvider)
        .referenceTablesDao
        .getSoilDepositionName(code);
  }

  Future<String> getHumusFormName(String code) async {
    if (code.isEmpty) {
      return "Please select humus class";
    }

    return ref
        .read(databaseProvider)
        .referenceTablesDao
        .getSoilHumusFormName(code);
  }

  List<String>? errorCheck() {
    List<String> results = [];

    if (siteInfo.soilClassOrder == const d.Value.absent()) {
      results.add("Missing soil class order");
    }
    if (siteInfo.soilClassGreatGroup == const d.Value.absent()) {
      results.add("Missing soil class great group");
    }
    if (siteInfo.soilClassSubGroup == const d.Value.absent()) {
      results.add("Missing soil class sub group");
    } else {
      if (siteInfo.soilClass == const d.Value.absent()) {
        results.add("Error: soil Class is missing. Please contact support");
      }
    }

    if (siteInfo.profileDepth == const d.Value.absent()) {
      results.add("Missing profile depth");
    } else if (errorProfileDepth(ref
            .read(databaseProvider)
            .companionValueToStr(siteInfo.profileDepth)) !=
        null) {
      results.add("Error for profile depth");
    }
    if (siteInfo.drainage == const d.Value.absent()) {
      results.add("Missing drainage");
    }
    if (siteInfo.moisture == const d.Value.absent()) {
      results.add("Missing moisture");
    }
    if (siteInfo.deposition == const d.Value.absent()) {
      results.add("Missing deposition");
    }
    if (siteInfo.humusForm == const d.Value.absent()) {
      results.add("Missing humus form");
    }

    return results.isEmpty ? null : results;
  }

  String? errorProfileDepth(String? text) {
    if (text?.isEmpty ?? true) {
      return "Can't be empty";
    } else if (double.parse(text!) == -1.0) {
      return null;
    } else if (0.0 > double.parse(text!) || double.parse(text!) > 250) {
      return "Input out of range. Must be between 0.0 to 250.0 inclusive.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.read(databaseProvider);
    bool isSoil() => !{kUnknownCode, kNACode}.contains(siteInfo.soilClass);

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
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingV * 2, horizontal: kPaddingH),
        child: Center(
            child: ListView(
          children: [
            const TextHeaderSeparator(
              title: "CSSC Soil Classification",
              fontSize: 20,
            ),
            DropDownAsyncList(
              searchable: true,
              enabled: !parentComplete,
              title: "Order",
              onChangedFn: (s) {
                if (db.companionValueToStr(siteInfo.soilClassOrder) != s) {
                  if (s! == "Not applicable: non-soil") {
                    updateSiteInfo(siteInfo.copyWith(
                      soilClassOrder: d.Value(s),
                      soilClassGreatGroup: const d.Value("Not applicable"),
                      soilClassSubGroup: const d.Value("Not applicable"),
                      soilClass: kNACode,
                    ));
                  } else if (s! == "Unknown or not reported") {
                    updateSiteInfo(siteInfo.copyWith(
                      soilClassOrder: d.Value(s),
                      soilClassGreatGroup:
                          const d.Value("Unknown or not reported"),
                      soilClassSubGroup:
                          const d.Value("Unknown or not reported"),
                      soilClass: kUnknownCode,
                    ));
                  } else {
                    updateSiteInfo(siteInfo.copyWith(
                        soilClassOrder: d.Value(s!),
                        soilClassGreatGroup: const d.Value.absent(),
                        soilClassSubGroup: const d.Value.absent(),
                        soilClass: const d.Value.absent()));
                  }
                }
              },
              selectedItem:
                  db.companionValueToStr(siteInfo.soilClassOrder).isEmpty
                      ? "Please select classification order"
                      : db.companionValueToStr(siteInfo.soilClassOrder),
              asyncItems: (s) => db.referenceTablesDao.getSoilClassOrderList(),
            ),
            isSoil()
                ? Column(
                    children: [
                      DropDownAsyncList(
                        searchable: true,
                        enabled: !parentComplete,
                        title: "Great Group",
                        onChangedFn: (s) {
                          if (db.companionValueToStr(
                                  siteInfo.soilClassGreatGroup) !=
                              s) {
                            changeMade = true;
                            setState(() {
                              siteInfo = siteInfo.copyWith(
                                  soilClassGreatGroup: d.Value(s!),
                                  soilClassSubGroup: const d.Value.absent(),
                                  soilClass: const d.Value.absent());
                            });
                          }
                        },
                        selectedItem: db
                                .companionValueToStr(
                                    siteInfo.soilClassGreatGroup)
                                .isEmpty
                            ? "Please select great group"
                            : db.companionValueToStr(
                                siteInfo.soilClassGreatGroup),
                        asyncItems: (s) => db.referenceTablesDao
                            .getSoilClassGreatGroupList(db
                                .companionValueToStr(siteInfo.soilClassOrder)),
                      ),
                      DropDownAsyncList(
                        searchable: true,
                        enabled: !parentComplete,
                        title: "Sub Group",
                        onChangedFn: (s) {
                          if (db.companionValueToStr(
                                  siteInfo.soilClassSubGroup) !=
                              s) {
                            changeMade = true;
                            db.referenceTablesDao
                                .getSoilClassCode(
                                    db.companionValueToStr(
                                        siteInfo.soilClassOrder),
                                    db.companionValueToStr(
                                        siteInfo.soilClassGreatGroup),
                                    s!)
                                .then((code) => setState(() {
                                      siteInfo = siteInfo.copyWith(
                                          soilClassSubGroup: d.Value(s!),
                                          soilClass: d.Value(code));
                                    }));
                          }
                        },
                        selectedItem: db
                                .companionValueToStr(siteInfo.soilClassSubGroup)
                                .isEmpty
                            ? "Please select sub group"
                            : db.companionValueToStr(
                                siteInfo.soilClassSubGroup),
                        asyncItems: (s) => db.referenceTablesDao
                            .getSoilClassSubGroupList(
                                db.companionValueToStr(siteInfo.soilClassOrder),
                                db.companionValueToStr(
                                    siteInfo.soilClassGreatGroup)),
                      )
                    ],
                  )
                : Container(),
            const SizedBox(height: kPaddingV * 2),
            const TextHeaderSeparator(
              title: "Measurements",
              fontSize: 20,
            ),
            const SizedBox(height: kPaddingV),
            DataInput(
              title:
                  "The depth of the soil pit from which soil characteristics were described",
              readOnly: parentComplete,
              boxLabel: "Measure to the nearest 0.1",
              prefixIcon: FontAwesomeIcons.ruler,
              suffixVal: "cm",
              startingStr: db.companionValueToStr(siteInfo.profileDepth),
              paddingGeneral: const EdgeInsets.all(0),
              onValidate: (s) => errorProfileDepth(s),
              inputType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
                ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
              ],
              onSubmit: (s) {
                changeMade = true;
                s.isEmpty
                    ? setState(() => siteInfo =
                        siteInfo.copyWith(profileDepth: const d.Value.absent()))
                    : setState(() => siteInfo = siteInfo.copyWith(
                        profileDepth: d.Value(double.parse(s))));
              },
            ),
            FutureBuilder(
                future:
                    getDrainageName(db.companionValueToStr(siteInfo.drainage)),
                initialData: "Please select drainage",
                builder: (BuildContext context, AsyncSnapshot<String> text) {
                  return DropDownAsyncList(
                    title: "Drainage class",
                    searchable: true,
                    enabled: !parentComplete,
                    onChangedFn: (s) {
                      changeMade = true;
                      db.referenceTablesDao
                          .getSoilDrainageCode(s!)
                          .then((code) => setState(() {
                                siteInfo =
                                    siteInfo.copyWith(drainage: d.Value(code));
                              }));
                    },
                    asyncItems: (s) async {
                      List<String> namesList =
                          await db.referenceTablesDao.getSoilDrainageNameList();

                      if (isSoil()) {
                        namesList
                            .removeWhere((element) => element.contains("-9"));
                      }

                      return namesList;
                    },
                    selectedItem:
                        text.data ?? "Error loading drainage class name",
                  );
                }),
            FutureBuilder(
                future:
                    getMoistureName(db.companionValueToStr(siteInfo.moisture)),
                initialData: "Please select moisture",
                builder: (BuildContext context, AsyncSnapshot<String> text) {
                  return DropDownAsyncList(
                    title: "Moisture class",
                    searchable: true,
                    enabled: !parentComplete,
                    onChangedFn: (s) {
                      changeMade = true;
                      db.referenceTablesDao
                          .getSoilMoistureCode(s!)
                          .then((code) => setState(() {
                                siteInfo =
                                    siteInfo.copyWith(moisture: d.Value(code));
                              }));
                    },
                    asyncItems: (s) async {
                      List<String> namesList =
                          await db.referenceTablesDao.getSoilMoistureNameList();

                      if (isSoil()) {
                        namesList.removeWhere(
                            (element) => element.contains("Non-applicable"));
                      }

                      return namesList;
                    },
                    selectedItem:
                        text.data ?? "Error loading moisture class name",
                  );
                }),
            const SizedBox(height: kPaddingV),
            FutureBuilder(
                future: getDepositionName(
                    db.companionValueToStr(siteInfo.deposition)),
                initialData: "Please select deposition",
                builder: (BuildContext context, AsyncSnapshot<String> text) {
                  return DropDownAsyncList(
                    title: "Mode of deposition of soil parent material",
                    searchable: true,
                    enabled: !parentComplete,
                    onChangedFn: (s) {
                      changeMade = true;
                      db.referenceTablesDao
                          .getSoilDepositionCode(s!)
                          .then((code) => setState(() {
                                siteInfo = siteInfo.copyWith(
                                    deposition: d.Value(code));
                              }));
                    },
                    asyncItems: (s) =>
                        db.referenceTablesDao.getSoilDepositionNameList(),
                    selectedItem:
                        text.data ?? "Error loading drainage class name",
                  );
                }),
            FutureBuilder(
                future: getHumusFormName(
                    db.companionValueToStr(siteInfo.humusForm)),
                initialData: "Please select humus form",
                builder: (BuildContext context, AsyncSnapshot<String> text) {
                  return DropDownAsyncList(
                    title:
                        "Humus Form: form of the organic and organic-enriched "
                        "mineral horizons at the soil surface’",
                    searchable: true,
                    enabled: !parentComplete,
                    onChangedFn: (s) {
                      changeMade = true;
                      db.referenceTablesDao
                          .getSoilHumusFormCode(s!)
                          .then((code) => setState(() {
                                siteInfo =
                                    siteInfo.copyWith(humusForm: d.Value(code));
                              }));
                    },
                    asyncItems: (s) =>
                        db.referenceTablesDao.getSoilHumusFormNameList(),
                    selectedItem: text.data ?? "Error loading humus class name",
                  );
                }),
            Container(
                margin: const EdgeInsets.only(
                    top: kPaddingV * 2, bottom: kPaddingV * 2),
                child: ElevatedButton(
                    onPressed: () {
                      if (parentComplete) {
                        Popups.show(context,
                            Popups.generateCompleteErrorPopup("Woody Debris"));
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
                        db.soilPitTablesDao
                            .addOrUpdateSiteInfo(siteInfo)
                            .then((siteId) {
                          ref.refresh(soilSummaryDataProvider(spId));
                          context.goNamed(SoilPitSummaryPage.routeName,
                              pathParameters: PathParamGenerator.soilPitSummary(
                                  widget.state, spId.toString()));
                        });
                      }
                    },
                    child: const Text("Submit"))),
          ],
        )),
      ),
    );
  }
}
