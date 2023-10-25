import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_app/database/database.dart';
import 'package:survey_app/pages/woody_debris/woody_debris_piece/woody_debris_piece_error_checks.dart';
import 'package:survey_app/widgets/popups/popup_errors_found_list.dart';
import 'package:survey_app/widgets/popups/popup_warning_missing_fields_list.dart';

import '../../../../widgets/app_bar.dart';
import '../../../../widgets/popups/popups.dart';
import '../../../constants/margins_padding.dart';
import '../../../formatters/thousands_formatter.dart';
import '../../../widgets/builders/decay_class_select_builder.dart';
import '../../../widgets/builders/tree_genus_select_builder.dart';
import '../../../widgets/builders/tree_species_select_builder.dart';
import '../../../widgets/buttons/delete_button.dart';
import '../../../widgets/data_input/dep_data_input.dart';
import '../../../widgets/drawer_menu.dart';
import '../../../widgets/hide_info_checkbox.dart';
import '../../../widgets/popups/popup_continue.dart';
import '../../delete_page.dart';

class WoodyDebrisPieceAccuOddPage extends StatefulWidget {
  static const String routeName = "woodyDebrisPieceAccuOdd";
  static const String keyPiece = "piece";
  static const String keyDeleteFn = "deleteFn";

  const WoodyDebrisPieceAccuOddPage(
      {Key? key, required this.piece, this.deleteFn})
      : super(key: key);

  final WoodyDebrisOddCompanion piece;
  final void Function()? deleteFn;
  @override
  State<WoodyDebrisPieceAccuOddPage> createState() =>
      _WoodyDebrisPieceAccuOddPageState();
}

class _WoodyDebrisPieceAccuOddPageState
    extends State<WoodyDebrisPieceAccuOddPage> {
  final Database db = Database.instance;

  late final String title;
  final controllerHor = TextEditingController();
  final controllerVer = TextEditingController();
  final d.Value<int> kDataMissing = const d.Value(-1);

  late WoodyDebrisOddCompanion piece;
  bool changeMade = false;

  @override
  void initState() {
    title =
        "Woody Debris ${widget.piece.accumOdd.value == db.woodyDebrisTablesDao.accumulation ? "Accumulation" : "Odd"}";
    piece = widget.piece;
    super.initState();
  }

  @override
  void dispose() {
    controllerHor.dispose();
    controllerVer.dispose();
    super.dispose();
  }

  void updatePiece(WoodyDebrisOddCompanion newPiece) {
    changeMade = true;
    setState(() => piece = newPiece);
  }

  @override
  Widget build(BuildContext context) {
    void continueCheck() {
      List<String>? results =
          WoodyDebrisPieceErrorChecks.checkErrorOddAcum(db, piece);
      if (results != null) {
        Popups.show(context, PopupErrorsFoundList(errors: results));
      } else {
        List<String> missFields = [];
        piece.verDepth == kDataMissing ? missFields.add("Tilt Angle") : null;
        piece.decayClass == kDataMissing ? missFields.add("Decay Class") : null;

        if (missFields.isNotEmpty) {
          Popups.show(
              context,
              PopupWarningMissingFieldsList(
                missingFields: missFields,
                rightBtnOnPressed: () {
                  db.woodyDebrisTablesDao.addOrUpdateWdPieceOddAccu(piece);
                  context.pop();
                  context.pop();
                },
              ));
        } else {
          db.woodyDebrisTablesDao.addOrUpdateWdPieceOddAccu(piece);
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
      endDrawer: DrawerMenu(onLocaleChange: () => setState(() {})),
      body: Padding(
        padding:
            const EdgeInsets.fromLTRB(kPaddingH, 0, kPaddingH, kPaddingV / 2),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DepDataInput(
                title: "Horizontal Piece Length",
                boxLabel: "Reported to the nearest 0.1cm",
                prefixIcon: FontAwesomeIcons.ruler,
                suffixVal: "CM",
                controller: controllerHor,
                startingStr: db.companionValueToStr(piece.horLength),
                onSubmit: (String s) {
                  double.tryParse(s) != null
                      ? updatePiece(
                          piece.copyWith(horLength: d.Value(double.parse(s))))
                      : updatePiece(
                          piece.copyWith(horLength: const d.Value.absent()));
                },
                errorMsg: WoodyDebrisPieceErrorChecks.horizontal(
                    db.companionValueToStr(piece.horLength)),
                inputType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                  ThousandsFormatter(allowFraction: true, decimalPlaces: 1)
                ],
              ),
              DepDataInput(
                title: "Vertical Piece Depth",
                generalPadding: const EdgeInsets.only(top: 0.0),
                textBoxPadding: const EdgeInsets.only(top: 0.0),
                boxLabel: "Reported to the nearest 0.1cm",
                prefixIcon: FontAwesomeIcons.angleLeft,
                suffixVal: "CM",
                inputType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                  ThousandsFormatter(allowFraction: true, decimalPlaces: 1)
                ],
                controller: controllerVer,
                startingStr: db.companionValueToStr(piece.verDepth),
                onSubmit: (String s) {
                  double.tryParse(s) != null
                      ? updatePiece(
                          piece.copyWith(verDepth: d.Value(double.parse(s))))
                      : updatePiece(
                          piece.copyWith(verDepth: const d.Value.absent()));
                },
                errorMsg: WoodyDebrisPieceErrorChecks.vertical(
                    db.companionValueToStr(piece.verDepth)),
              ),
              TreeGenusSelectBuilder(
                  updateGenusFn: (genusCode, speciesCode) => updatePiece(
                      piece.copyWith(genus: genusCode, species: speciesCode)),
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
                checkValue: piece.decayClass == kDataMissing,
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
                            DeletePage.keyObjectName: title,
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
