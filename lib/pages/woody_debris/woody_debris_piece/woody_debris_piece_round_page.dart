import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_app/constants/constant_values.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/pages/woody_debris/woody_debris_piece/woody_debris_piece_error_checks.dart';
import 'package:survey_app/widgets/builders/tree_genus_select_builder.dart';
import 'package:survey_app/widgets/builders/tree_species_select_builder.dart';
import 'package:survey_app/widgets/buttons/delete_button.dart';
import 'package:survey_app/widgets/hide_info_checkbox.dart';
import 'package:survey_app/widgets/popups/popup_continue.dart';
import 'package:survey_app/widgets/popups/popup_errors_found_list.dart';
import 'package:survey_app/widgets/popups/popup_warning_missing_fields_list.dart';

import '../../../constants/margins_padding.dart';
import '../../../formatters/thousands_formatter.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/builders/decay_class_select_builder.dart';
import '../../../widgets/data_input/data_input.dart';
import '../../../widgets/popups/popups.dart';
import '../../delete_page.dart';

class WoodyDebrisPieceRoundPage extends StatefulWidget {
  static const String routeName = "woodyDebrisPieceRound";
  static const String keyPiece = "piece";
  static const String keyDeleteFn = "deleteFn";
  const WoodyDebrisPieceRoundPage(
      {Key? key, required this.piece, this.deleteFn})
      : super(key: key);

  final WoodyDebrisRoundCompanion piece;
  final void Function()? deleteFn;

  @override
  State<WoodyDebrisPieceRoundPage> createState() =>
      _WoodyDebrisPieceRoundPageState();
}

class _WoodyDebrisPieceRoundPageState extends State<WoodyDebrisPieceRoundPage> {
  final Database db = Database.instance;

  final String title = "Woody Debris Piece Round";
  final controllerDiameter = TextEditingController();
  final controllerTiltAngle = TextEditingController();
  final int kDataMissing = -1;

  late WoodyDebrisRoundCompanion piece;
  bool changeMade = false;

  @override
  void initState() {
    piece = widget.piece;
    super.initState();
  }

  @override
  void dispose() {
    controllerDiameter.dispose();
    controllerTiltAngle.dispose();
    super.dispose();
  }

  void updatePiece(WoodyDebrisRoundCompanion newPiece) {
    changeMade = true;
    setState(() => piece = newPiece);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Going to ${GoRouterState.of(context).uri.toString()}");

    void continueCheck() {
      List<String>? results =
          WoodyDebrisPieceErrorChecks.checkErrorRound(db, piece);
      if (results != null) {
        Popups.show(context, PopupErrorsFoundList(errors: results));
      } else {
        List<String> missFields = [];
        piece.tiltAngle == const d.Value(-1)
            ? missFields.add("Tilt Angle")
            : null;
        piece.decayClass == const d.Value(-1)
            ? missFields.add("Decay Class")
            : null;

        if (missFields.isNotEmpty) {
          Popups.show(
              context,
              PopupWarningMissingFieldsList(
                missingFields: missFields,
                rightBtnOnPressed: () {
                  db.woodyDebrisTablesDao.addOrUpdateWdPieceRound(piece);
                  context.pop();
                  context.pop();
                },
              ));
        } else {
          db.woodyDebrisTablesDao.addOrUpdateWdPieceRound(piece);
          context.pop();
        }
      }
    }

    return Scaffold(
      appBar: OurAppBar(
        "$title: Piece ${piece.pieceNum.value}",
        backFn: () {
          changeMade
              ? Popups.show(context, Popups.generateWarningUnsavedChanges(() {
                  context.pop();
                  context.pop();
                }))
              : context.pop();
        },
      ),
      body: Padding(
        padding:
            const EdgeInsets.fromLTRB(kPaddingH, 0, kPaddingH, kPaddingV / 2),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DataInput(
                title:
                    "Piece diameter as determined by calipers or diameter tape measurement.",
                boxLabel: "Reported to the nearest 0.1cm",
                prefixIcon: FontAwesomeIcons.ruler,
                suffixVal: "CM",
                controller: controllerDiameter,
                startingStr: db.companionValueToStr(piece.diameter),
                onSubmit: (String s) {
                  double.tryParse(s) != null
                      ? updatePiece(
                          piece.copyWith(diameter: d.Value(double.parse(s))))
                      : updatePiece(
                          piece.copyWith(diameter: const d.Value.absent()));
                },
                errorMsg: WoodyDebrisPieceErrorChecks.diameter(
                    db.companionValueToStr(piece.diameter)),
                inputType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(5),
                  ThousandsFormatter(allowFraction: true, decimalPlaces: 1)
                ],
              ),
              HideInfoCheckbox(
                title: "Tilt angle of piece",
                checkTitle: "Tilt angle missing",
                checkValue: piece.tiltAngle.value == kDataMissing,
                onChange: (angleMissing) {
                  angleMissing!
                      ? Popups.show(context,
                          Popups.generateWarningMarkingAsMissing(() {
                          updatePiece(
                              piece.copyWith(tiltAngle: const d.Value(-1)));
                          context.pop();
                        }))
                      : updatePiece(
                          piece.copyWith(tiltAngle: const d.Value.absent()));
                },
                child: DataInput(
                  generalPadding: const EdgeInsets.only(top: 0.0),
                  textBoxPadding: const EdgeInsets.only(top: 0.0),
                  boxLabel: "Reported to the nearest degree",
                  prefixIcon: FontAwesomeIcons.angleLeft,
                  suffixVal: kDegreeSign,
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(2),
                    ThousandsFormatter(allowNegative: false)
                  ],
                  controller: controllerTiltAngle,
                  startingStr: db.companionValueToStr(piece.tiltAngle),
                  onSubmit: (String s) {
                    int.tryParse(s) != null
                        ? updatePiece(
                            piece.copyWith(tiltAngle: d.Value(int.parse(s))))
                        : updatePiece(
                            piece.copyWith(tiltAngle: const d.Value.absent()));
                  },
                  errorMsg: WoodyDebrisPieceErrorChecks.tiltAngle(
                      db.companionValueToStr(piece.tiltAngle)),
                ),
              ),
              TreeGenusSelectBuilder(
                  onChangedFn: (s) async {
                    //Check that the same genus wasn't double selected so you
                    //don't overwrite species
                    if (db.companionValueToStr(piece.genus).isEmpty ||
                        s != db.companionValueToStr(piece.genus)) {
                      String newGenusCode =
                          await db.referenceTablesDao.getGenusCodeFromName(s!);
                      updatePiece(piece.copyWith(
                          genus: d.Value(newGenusCode),
                          species: const d.Value.absent()));
                    }
                  },
                  genusCode: db.companionValueToStr(piece.genus)),
              TreeSpeciesSelectBuilder(
                  onChangedFn: (s) => db.referenceTablesDao
                          .getSpeciesCode(
                              db.companionValueToStr(piece.genus), s!)
                          .then((newSpeciesCode) {
                        updatePiece(
                            piece.copyWith(species: d.Value(newSpeciesCode)));
                      }),
                  selectedSpeciesCode: db.companionValueToStr(piece.species),
                  genusCode: db.companionValueToStr(piece.genus)),
              const SizedBox(
                height: kPaddingV * 2,
              ),
              HideInfoCheckbox(
                title:
                    "Average decay class is assigned to all pieces of small woody debris along each transect.",
                checkTitle: "Mark decay class as missing",
                checkValue: piece.decayClass == const d.Value(-1),
                onChange: (b) {
                  //Don't need to check if wdh is complete bc you'd never get here
                  //if it was
                  b!
                      ? Popups.show(context,
                          Popups.generateWarningMarkingAsMissing(() {
                          updatePiece(
                              piece.copyWith(decayClass: const d.Value(-1)));
                          context.pop();
                        }))
                      : updatePiece(
                          piece.copyWith(decayClass: const d.Value.absent()));
                },
                child: DecayClassSelectBuilder(
                  onChangedFn: (s) => updatePiece(
                      piece.copyWith(decayClass: d.Value(int.parse(s!)))),
                  selectedItem: db.companionValueToStr(piece.decayClass),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: kPaddingV * 2),
                child: ElevatedButton(
                  onPressed: () => continueCheck(),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  child: const Text("Save"),
                ),
              ),
              widget.deleteFn != null
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
                            DeletePage.keyObjectName: "Round Piece",
                            DeletePage.keyDeleteFn: widget.deleteFn!,
                          });
                        }),
                      ),
                    )
                  : Container(),
            ],
          ),
        ]),
      ),
    );
  }
}
