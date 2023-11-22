import 'package:drift/drift.dart' as d;
import 'package:flutter/services.dart';
import 'package:survey_app/barrels/page_imports_barrel.dart';
import 'package:survey_app/widgets/dropdowns/drop_down_async_list.dart';
import 'package:survey_app/widgets/hide_info_checkbox.dart';

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
  final String title = "Site Info";
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

  Future<String> getSoilDrainageName(String code) async {
    if (code.isEmpty) {
      return "Please select drainage class";
    }

    return ref
        .read(databaseProvider)
        .referenceTablesDao
        .getSoilDrainageName(int.parse(code));
  }

  Future<String> getSoilMoistureName(String code) async {
    if (code.isEmpty) {
      return "Please select moisture class";
    }

    return ref
        .read(databaseProvider)
        .referenceTablesDao
        .getSoilMoistureName(int.parse(code));
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
            child: ListView(
          children: [
            const TextHeaderSeparator(
              title: "CSC Soil Classification Field",
              fontSize: 20,
            ),
            DropDownAsyncList(
              searchable: true,
              enabled: !parentComplete,
              title: "Order",
              onChangedFn: (s) {
                if (db.companionValueToStr(siteInfo.soilClassOrder) != s) {
                  changeMade = true;
                  setState(() {
                    siteInfo = siteInfo.copyWith(
                        soilClassOrder: d.Value(s!),
                        soilClassGreatGroup: const d.Value.absent(),
                        soilClassSubGroup: const d.Value.absent(),
                        soilClass: const d.Value.absent());
                  });
                }
              },
              selectedItem:
                  db.companionValueToStr(siteInfo.soilClassOrder).isEmpty
                      ? "Please select classification order"
                      : db.companionValueToStr(siteInfo.soilClassOrder),
              asyncItems: (s) => db.referenceTablesDao.getSoilClassOrderList(),
            ),
            DropDownAsyncList(
              searchable: true,
              enabled: !parentComplete,
              title: "Great Group",
              onChangedFn: (s) {
                if (db.companionValueToStr(siteInfo.soilClassGreatGroup) != s) {
                  changeMade = true;
                  setState(() {
                    siteInfo = siteInfo.copyWith(
                        soilClassGreatGroup: d.Value(s!),
                        soilClassSubGroup: const d.Value.absent(),
                        soilClass: const d.Value.absent());
                  });
                }
              },
              selectedItem:
                  db.companionValueToStr(siteInfo.soilClassGreatGroup).isEmpty
                      ? "Please select great group"
                      : db.companionValueToStr(siteInfo.soilClassGreatGroup),
              asyncItems: (s) => db.referenceTablesDao
                  .getSoilClassGreatGroupList(
                      db.companionValueToStr(siteInfo.soilClassOrder)),
            ),
            DropDownAsyncList(
              searchable: true,
              enabled: !parentComplete,
              title: "Sub Group",
              onChangedFn: (s) {
                if (db.companionValueToStr(siteInfo.soilClassSubGroup) != s) {
                  changeMade = true;
                  db.referenceTablesDao
                      .getSoilClassCode(
                          db.companionValueToStr(siteInfo.soilClassOrder),
                          db.companionValueToStr(siteInfo.soilClassGreatGroup),
                          s!)
                      .then((code) => setState(() {
                            siteInfo = siteInfo.copyWith(
                                soilClassSubGroup: d.Value(s!),
                                soilClass: d.Value(code));
                          }));
                }
              },
              selectedItem:
                  db.companionValueToStr(siteInfo.soilClassSubGroup).isEmpty
                      ? "Please select sub group"
                      : db.companionValueToStr(siteInfo.soilClassSubGroup),
              asyncItems: (s) => db.referenceTablesDao.getSoilClassSubGroupList(
                  db.companionValueToStr(siteInfo.soilClassOrder),
                  db.companionValueToStr(siteInfo.soilClassGreatGroup)),
            ),
            const SizedBox(height: kPaddingV * 2),
            const TextHeaderSeparator(
              title: "Measurements",
              fontSize: 20,
            ),
            HideInfoCheckbox(
              title:
                  "The depth of the soil pit from which soil characteristics were described",
              checkTitle: "Unreported",
              checkValue:
                  db.companionValueToStr(siteInfo.profileDepth) == "-1.0",
              onChange: (b) {
                if (parentComplete) return;
                b!
                    ? setState(() => siteInfo =
                        siteInfo.copyWith(profileDepth: const d.Value(-1)))
                    : setState(() => siteInfo = siteInfo.copyWith(
                        profileDepth: const d.Value.absent()));
              },
              child: DataInput(
                readOnly: parentComplete,
                boxLabel: "Measure to the nearest 0.1",
                prefixIcon: FontAwesomeIcons.ruler,
                suffixVal: "cm",
                startingStr: db.companionValueToStr(siteInfo.profileDepth),
                generalPadding: const EdgeInsets.all(0),
                onValidate: (s) => errorProfileDepth(s),
                inputType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(5),
                  ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
                ],
                onSubmit: (s) {
                  s.isEmpty
                      ? setState(() => siteInfo = siteInfo.copyWith(
                          profileDepth: const d.Value.absent()))
                      : setState(() => siteInfo = siteInfo.copyWith(
                          profileDepth: d.Value(double.parse(s))));
                },
              ),
            ),
            HideInfoCheckbox(
                title: "Drainage class",
                checkTitle: "Missing",
                checkValue: db.companionValueToStr(siteInfo.drainage) == "-1",
                onChange: (b) {
                  if (parentComplete) return;
                  b!
                      ? setState(() => siteInfo =
                          siteInfo.copyWith(drainage: const d.Value(-1)))
                      : setState(() => siteInfo =
                          siteInfo.copyWith(drainage: const d.Value.absent()));
                },
                child: FutureBuilder(
                    future: getSoilDrainageName(
                        db.companionValueToStr(siteInfo.drainage)),
                    initialData: "Please select drainage",
                    builder:
                        (BuildContext context, AsyncSnapshot<String> text) {
                      return DropDownAsyncList(
                        searchable: true,
                        enabled: !parentComplete,
                        padding: 0,
                        onChangedFn: (s) {
                          db.referenceTablesDao
                              .getSoilDrainageCode(s!)
                              .then((code) => setState(() {
                                    siteInfo = siteInfo.copyWith(
                                        drainage: d.Value(code));
                                  }));
                        },
                        asyncItems: (s) =>
                            db.referenceTablesDao.getSoilDrainageNameList(),
                        selectedItem:
                            text.data ?? "Error loading drainage class name",
                      );
                    })),
            HideInfoCheckbox(
                title: "Moisture class",
                checkTitle: "Unreported",
                checkValue: db.companionValueToStr(siteInfo.moisture) == "-1",
                onChange: (b) {
                  if (parentComplete) return;
                  b!
                      ? setState(() => siteInfo =
                          siteInfo.copyWith(moisture: const d.Value(-1)))
                      : setState(() => siteInfo =
                          siteInfo.copyWith(moisture: const d.Value.absent()));
                },
                child: FutureBuilder(
                    future: getSoilMoistureName(
                        db.companionValueToStr(siteInfo.moisture)),
                    initialData: "Please select moisture",
                    builder:
                        (BuildContext context, AsyncSnapshot<String> text) {
                      return DropDownAsyncList(
                        searchable: true,
                        enabled: !parentComplete,
                        padding: 0,
                        onChangedFn: (s) {
                          db.referenceTablesDao
                              .getSoilMoistureCode(s!)
                              .then((code) => setState(() {
                                    siteInfo = siteInfo.copyWith(
                                        moisture: d.Value(code));
                                  }));
                        },
                        asyncItems: (s) =>
                            db.referenceTablesDao.getSoilMoistureNameList(),
                        selectedItem:
                            text.data ?? "Error loading drainage class name",
                      );
                    })),
          ],
        )),
      ),
    );
  }
}
