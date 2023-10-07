import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:survey_app/database/database.dart';

import '../../constants/margins_padding.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/drawer_menu.dart';
import '../../widgets/popups/popups.dart';

class SurfaceSubstrateHeaderMeasurementsPage extends StatefulWidget {
  static const String routeName = "surfaceSubstrateHeaderMeasurement";
  static const String keySsHeaderCompanion = "ssHeader";
  static const String keyUpdateSummaryPageTransList =
      "updateSummaryPageTransList";

  const SurfaceSubstrateHeaderMeasurementsPage(
      {super.key, required this.ssh, this.updateSummaryPageTransList});
  final SurfaceSubstrateHeaderCompanion ssh;
  final VoidCallback? updateSummaryPageTransList;

  @override
  State<SurfaceSubstrateHeaderMeasurementsPage> createState() =>
      _SurfaceSubstrateHeaderMeasurementsPageState();
}

class _SurfaceSubstrateHeaderMeasurementsPageState
    extends State<SurfaceSubstrateHeaderMeasurementsPage> {
  late SurfaceSubstrateHeaderCompanion ssh;

  final String title = "Surface Substrate Transect";
  bool changeMade = false;

  @override
  void initState() {
    ssh = widget.ssh;
    super.initState();
  }

  void updateSshCompanion(SurfaceSubstrateHeaderCompanion newSsh) =>
      setState(() => ssh = newSsh);

  @override
  Widget build(BuildContext context) {
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");
    final db = Provider.of<Database>(context);

    return Scaffold(
      appBar: OurAppBar(
          "Surface Substrate Measurement Data: Transect ${db.companionValueToStr(ssh.transNum)}",
          backFn: () => changeMade
              ? Popups.show(context, Popups.generateWarningUnsavedChanges(() {
                  context.pop();
                  context.pop();
                }))
              : context.pop(context.pop)),
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingH),
        children: [
          // SetTransectNumBuilder(
          //   getUsedTransNums:
          //   db.woodyDebrisTablesDao.getUsedTransnums(wdh.wdId.value),
          //   startingTransNum: db.companionValueToStr(widget.wdh.transNum),
          //   selectedItem: db.companionValueToStr(wdh.transNum).isEmpty
          //       ? "Please select transect number"
          //       : db.companionValueToStr(wdh.transNum),
          //   transList: kTransectNumsList,
          //   updateTransNum: (int transNum) =>
          //       updateWdhCompanion(wdh.copyWith(transNum: d.Value(transNum))),
          // ),
          // DataInput(
          //   title: "Length of the sample transect",
          //   boxLabel: "Report to the nearest 0.1m",
          //   prefixIcon: FontAwesomeIcons.ruler,
          //   suffixVal: "m",
          //   startingStr: db.companionValueToStr(wdh.nomTransLen),
          //   errorMsg: checkNomTransLen(db.companionValueToStr(wdh.nomTransLen)),
          //   inputType: const TextInputType.numberWithOptions(decimal: true),
          //   inputFormatters: [
          //     LengthLimitingTextInputFormatter(5),
          //     ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
          //   ],
          //   onSubmit: (String s) {
          //     changeMade = true;
          //     if (s == "") {
          //       updateWdhCompanion(
          //           wdh.copyWith(nomTransLen: const d.Value.absent()));
          //     } else if (double.tryParse(s) != null) {
          //       updateWdhCompanion(
          //           wdh.copyWith(nomTransLen: d.Value(double.parse(s))));
          //     }
          //   },
          // ),
          // DataInput(
          //     title: "Transect azimuth.",
          //     boxLabel: "Report in degrees",
          //     prefixIcon: FontAwesomeIcons.angleLeft,
          //     suffixVal: "\u00B0",
          //     inputType: const TextInputType.numberWithOptions(decimal: false),
          //     startingStr: db.companionValueToStr(wdh.transAzimuth),
          //     errorMsg:
          //     checkTransAzim(db.companionValueToStr(wdh.transAzimuth)),
          //     inputFormatters: [
          //       LengthLimitingTextInputFormatter(3),
          //       ThousandsFormatter(allowFraction: false),
          //     ],
          //     onSubmit: (String s) {
          //       changeMade = true;
          //       if (s == "") {
          //         updateWdhCompanion(
          //             wdh.copyWith(transAzimuth: const d.Value.absent()));
          //       } else if (int.tryParse(s) != null) {
          //         updateWdhCompanion(
          //             wdh.copyWith(transAzimuth: d.Value(int.parse(s))));
          //       }
          //     }),
          // const SizedBox(height: kPaddingV * 2),
          // const TextHeaderSeparator(
          //   title: "Total distance along the transect assessed for:",
          //   fontSize: 20,
          // ),
          // DataInput(
          //     title: "Small Woody Debris (1.1cm - 7.5cm)",
          //     boxLabel: "Report to the nearest 0.1m",
          //     prefixIcon: FontAwesomeIcons.ruler,
          //     suffixVal: "m",
          //     inputType: const TextInputType.numberWithOptions(decimal: true),
          //     startingStr: db.companionValueToStr(wdh.swdMeasLen),
          //     errorMsg: checkSwdMeasLen(db.companionValueToStr(wdh.swdMeasLen)),
          //     inputFormatters: [
          //       LengthLimitingTextInputFormatter(3),
          //       ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
          //     ],
          //     onSubmit: (String s) {
          //       changeMade = true;
          //       if (s == "") {
          //         updateWdhCompanion(
          //             wdh.copyWith(swdMeasLen: const d.Value.absent()));
          //       } else if (double.tryParse(s) != null) {
          //         updateWdhCompanion(
          //             wdh.copyWith(swdMeasLen: d.Value(double.parse(s))));
          //       }
          //     }),
          // DataInput(
          //     title: "Medium Woody Debris (7.6cm - 30cm)",
          //     boxLabel: "Report to the nearest 0.1m",
          //     prefixIcon: FontAwesomeIcons.ruler,
          //     suffixVal: "m",
          //     inputType: const TextInputType.numberWithOptions(decimal: true),
          //     startingStr: db.companionValueToStr(wdh.mcwdMeasLen),
          //     errorMsg:
          //     checkMwdMeasLen(db.companionValueToStr(wdh.mcwdMeasLen)),
          //     inputFormatters: [
          //       LengthLimitingTextInputFormatter(3),
          //       ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
          //     ],
          //     onSubmit: (String s) {
          //       changeMade = true;
          //       if (s == "") {
          //         updateWdhCompanion(
          //             wdh.copyWith(mcwdMeasLen: const d.Value.absent()));
          //       } else if (double.tryParse(s) != null) {
          //         updateWdhCompanion(
          //             wdh.copyWith(mcwdMeasLen: d.Value(double.parse(s))));
          //       }
          //     }),
          // DataInput(
          //     title: "Large Woody Debris (>30cm)",
          //     boxLabel: "Report to the nearest 0.1m",
          //     prefixIcon: FontAwesomeIcons.ruler,
          //     suffixVal: "m",
          //     inputType: const TextInputType.numberWithOptions(decimal: true),
          //     startingStr: db.companionValueToStr(wdh.lcwdMeasLen),
          //     errorMsg: checkLgMeasLen(db.companionValueToStr(wdh.lcwdMeasLen)),
          //     inputFormatters: [
          //       LengthLimitingTextInputFormatter(3),
          //       ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
          //     ],
          //     onSubmit: (String s) {
          //       changeMade = true;
          //       if (s == "") {
          //         updateWdhCompanion(
          //             wdh.copyWith(lcwdMeasLen: const d.Value.absent()));
          //       } else if (double.tryParse(s) != null) {
          //         updateWdhCompanion(
          //             wdh.copyWith(lcwdMeasLen: d.Value(double.parse(s))));
          //       }
          //     }),
          // Container(
          //     margin: const EdgeInsets.only(
          //         top: kPaddingV * 2, bottom: kPaddingV * 2),
          //     child: ElevatedButton(
          //         onPressed: () {
          //           if (wdh.complete.value) {
          //             Popups.show(context,
          //                 Popups.generateCompleteErrorPopup("Woody Debris"));
          //             return;
          //           }
          //
          //           List<String> errors = checkAll(db);
          //           if (errors.isNotEmpty) {
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
          //             goToHeaderPage();
          //           }
          //         },
          //         child: const Text("Submit"))),
        ],
      ),
    );
  }
}
