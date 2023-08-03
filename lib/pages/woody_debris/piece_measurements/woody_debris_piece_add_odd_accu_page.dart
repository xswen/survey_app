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
import '../../../widgets/popups/popup_content_format.dart';
import '../../../widgets/popups/popup_continue.dart';
import '../../../widgets/popups/popup_dismiss.dart';

class WoodyDebrisPieceAddOddAccuPage extends StatefulWidget {
  const WoodyDebrisPieceAddOddAccuPage({Key? key}) : super(key: key);

  @override
  State<WoodyDebrisPieceAddOddAccuPage> createState() =>
      _WoodyDebrisPieceAddOddAccuPageState();
}

class _WoodyDebrisPieceAddOddAccuPageState
    extends State<WoodyDebrisPieceAddOddAccuPage> with Global {
  final _db = Get.find<Database>();
  WoodyDebrisOddCompanion piece = Get.arguments;
  String genusCode = Global.dbCompanionValueToStr(Get.arguments.genus);
  String speciesName = Global.dbCompanionValueToStr(Get.arguments.species);
  static final ErrorWoodyDebrisPiece _error = ErrorWoodyDebrisPiece();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OurAppBar(
        "Woody Debris Pieces ${piece.accumOdd.value == _db.woodyDebrisTablesDao.odd ? "Odd" : "Accumulation"} ",
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
                  startingStr: Global.dbCompanionValueToStr(piece.horLength),
                  errorMsg: _error.horizontal(
                      Global.dbCompanionValueToStr(piece.horLength)),
                  title: "Horizontal Piece Length",
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
                          ? piece = piece.copyWith(
                              horLength: d.Value(double.parse(s)))
                          : piece =
                              piece.copyWith(horLength: const d.Value.absent());
                    });
                  }),
              DataInput(
                inputType: const TextInputType.numberWithOptions(decimal: true),
                startingStr: Global.dbCompanionValueToStr(piece.verDepth),
                errorMsg: _error
                    .vertical(Global.dbCompanionValueToStr(piece.verDepth)),
                title: "Vertical Piece Depth",
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
                            piece.copyWith(verDepth: d.Value(double.parse(s)))
                        : piece =
                            piece.copyWith(verDepth: const d.Value.absent());
                  });
                },
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
    String? result = _error.checkErrorOddAcum(piece);
    if (result != null) {
      Get.dialog(PopupDismiss(
          title: "Errors found in the following places:",
          contentWidget: PopupContentFormat(
            titles: const [""],
            details: [result],
          )));
    } else {
      if (piece.decayClass.value == -1) {
        bool cont = false;
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
    debugPrint("Woody Debris Odd/Accu Companion data. ${piece.toString()}");
    int id = await _db.into(_db.woodyDebrisOdd).insertOnConflictUpdate(piece);
    WoodyDebrisOddData pieceData =
        await _db.woodyDebrisTablesDao.getWdOddAccu(id);
    debugPrint("Woody Debris Odd logged. ${pieceData.toString()}");
  }
}
