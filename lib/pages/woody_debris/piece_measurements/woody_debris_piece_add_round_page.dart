import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../constants/margins_padding.dart';
import '../../../database/database.dart';
import '../../../error_handling/woody_debris/error_woody_debris_piece.dart';
import '../../../formatters/thousands_formatter.dart';
import '../../../global.dart';
import '../../../routes/route_names.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/builders/decay_class_select_builder.dart';
import '../../../widgets/builders/tree_genus_select_builder.dart';
import '../../../widgets/builders/tree_species_select_builder.dart';
import '../../../widgets/data_input/data_input.dart';
import '../../../widgets/hide_info_checkbox.dart';
import '../../../widgets/popups/popup_content_format.dart';
import '../../../widgets/popups/popup_continue.dart';
import '../../../widgets/popups/popup_dismiss_dep.dart';

class WoodyDebrisPieceAddRoundPage extends StatefulWidget {
  const WoodyDebrisPieceAddRoundPage({Key? key}) : super(key: key);

  @override
  State<WoodyDebrisPieceAddRoundPage> createState() =>
      _WoodyDebrisPieceAddRoundPageState();
}

class _WoodyDebrisPieceAddRoundPageState
    extends State<WoodyDebrisPieceAddRoundPage> with Global {
  final _db = Get.find<Database>();
  WoodyDebrisRoundCompanion piece = Get.arguments;
  String genusCode = Global.dbCompanionValueToStr(Get.arguments.genus);
  String speciesName = Global.dbCompanionValueToStr(Get.arguments.species);
  static final ErrorWoodyDebrisPiece _error = ErrorWoodyDebrisPiece();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar(
        "Woody Debris Pieces Round",
        backFn: () {
          Get.until((route) => Get.currentRoute == Routes.woodyDebrisPieceMain);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DataInput(
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  startingStr: Global.dbCompanionValueToStr(piece.diameter),
                  errorMsg: _error
                      .diameter(Global.dbCompanionValueToStr(piece.diameter)),
                  title:
                      "Piece diameter as determined by calipers or diameter tape measurement.",
                  boxLabel: "Reported to the nearest 0.1cm",
                  prefixIcon: FontAwesomeIcons.ruler,
                  suffixVal: "CM",
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(5),
                    ThousandsFormatter(allowFraction: true, decimalPlaces: 1),
                  ],
                  onSubmit: (s) {
                    setState(() {
                      double.tryParse(s) != null
                          ? piece =
                              piece.copyWith(diameter: d.Value(double.parse(s)))
                          : piece =
                              piece.copyWith(diameter: const d.Value.absent());
                    });
                  }),
              HideInfoCheckbox(
                title: "Tilt angle of piece",
                checkTitle: "Tilt angle missing",
                checkValue: piece.tiltAngle.value == -1,
                onChange: (angleMissing) {
                  if (angleMissing != null && angleMissing) {
                    Get.dialog(PopupContinue(
                      title: "Warning Missing Field",
                      content: "Are you sure you want to set as missing?",
                      rightBtnOnPressed: () {
                        setState(() => piece =
                            piece.copyWith(tiltAngle: const d.Value(-1)));
                        Get.back();
                      },
                    ));
                  } else {
                    setState(() =>
                        piece = piece.copyWith(tiltAngle: const d.Value(null)));
                  }
                },
                child: DataInput(
                  inputType:
                      const TextInputType.numberWithOptions(signed: true),
                  startingStr: Global.dbCompanionValueToStr(piece.tiltAngle),
                  errorMsg: _error
                      .tiltAngle(Global.dbCompanionValueToStr(piece.tiltAngle)),
                  boxLabel: "Reported to the nearest degree",
                  prefixIcon: FontAwesomeIcons.angleLeft,
                  suffixVal: "\u00B0",
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(2),
                    ThousandsFormatter(allowNegative: false),
                  ],
                  onSubmit: (s) {
                    setState(() {
                      double.tryParse(s) != null
                          ? piece =
                              piece.copyWith(tiltAngle: d.Value(int.parse(s)))
                          : piece =
                              piece.copyWith(diameter: const d.Value.absent());
                    });
                  },
                  generalPadding: const EdgeInsets.all(0),
                  textBoxPadding: const EdgeInsets.all(0),
                ),
              ),
              TreeGenusSelectBuilder(
                onChangedFn: (s) {
                  if (Global.dbCompanionValueToStr(piece.genus).isEmpty ||
                      s != Global.dbCompanionValueToStr(piece.genus)) {
                    _updateGenus(s!);
                  }
                },
                genusCode: genusCode,
              ),
              TreeSpeciesSelectBuilder(
                onChangedFn: (s) async {
                  String speciesCode = await _db.referenceTablesDao
                      .getSpeciesCode(genusCode, s!);
                  speciesName = await _db.referenceTablesDao
                      .getSpeciesName(genusCode, speciesCode);
                  piece = piece.copyWith(species: d.Value(speciesCode));
                  setState(() {});
                },
                selectedSpeciesCode: speciesName,
                genusCode: genusCode,
              ),
              const SizedBox(
                height: kPaddingV * 2,
              ),
              DecayClassSelectBuilder(
                title:
                    "Average decay class is assigned to all pieces of small woody debris along each transect.",
                checkValue: piece.decayClass.value == -1,
                checkOnChange: (decayClassMissing) {
                  if (decayClassMissing != null && decayClassMissing) {
                    Get.dialog(PopupContinue(
                      title: "Warning Missing Field",
                      content: "Are you sure you want to set as missing?",
                      rightBtnOnPressed: () {
                        setState(() => piece =
                            piece.copyWith(decayClass: const d.Value(-1)));
                        Get.back();
                      },
                    ));
                  } else {
                    setState(() => piece =
                        piece.copyWith(decayClass: const d.Value(null)));
                  }
                },
                onChangedFn: (String? s) {
                  piece = piece.copyWith(decayClass: d.Value(int.parse(s!)));
                },
                selectedItem: Global.dbCompanionValueToStr(piece.decayClass),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: kPaddingV * 2),
            child: ElevatedButton(
              onPressed: () {
                _continueCheck();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              child: const Text("Continue"),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateGenus(String name) async {
    genusCode = await _db.referenceTablesDao.getGenusCodeFromName(name);
    speciesName = "Please Select Species";
    setState(() {
      piece =
          piece.copyWith(genus: d.Value(genusCode), species: const d.Value(""));
    });
  }

  _continueCheck() {
    String? result = _error.checkErrorRound(piece);
    if (result != null) {
      Get.dialog(PopupDismissDep(
        title: "Error were found in the following places",
        contentWidget: PopupContentFormat(
          titles: const [""],
          details: [result],
        ),
      ));
    } else {
      if (piece.decayClass.value == -1) {
        Get.dialog(PopupContinue(
            title: "Warning",
            content:
                "Decay class is labelled as missing. This needs to be filled by time of submission. Continue?",
            rightBtnOnPressed: () {
              _continue();
              Get.until(
                  (route) => Get.currentRoute == Routes.woodyDebrisPieceMain);
            }));
      } else {
        _continue();
        Get.until((route) => Get.currentRoute == Routes.woodyDebrisPieceMain);
      }
    }
  }

  _continue() async {
    debugPrint("Woody Debris Round Companion data. ${piece.toString()}");
    int id = await _db.into(_db.woodyDebrisRound).insert(piece);
    WoodyDebrisRoundData pieceData =
        await _db.woodyDebrisTablesDao.getWdRound(id);
    debugPrint("Woody Debris Round logged. ${pieceData.toString()}");
  }
}
