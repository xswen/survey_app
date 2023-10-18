import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

const int kMaxTransects = 9;

const List<String> kTransectNumsList = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9"
];

const List<String> kDecayClassList = ["1", "2", "3", "4", "5"];

const String kDecayClassMissingStr = "kDecayClassMissingStr";

const String kContinue = "kContinue";

const kCardTitleName = "name";
const kCardData = "data";

const kLocaleFr = Locale("fr", "CA");
const kLocaleEn = Locale("en", "CA");

const kDegreeSign = "\u00B0";

const kSpeciesUnknownCode = "SPP";

const kParamMissing = "uninitialized";

const kLoadingWidget = Center(child: CircularProgressIndicator());

const kEditColumnDataGridCell = DataGridCell<Icon>(
    columnName: "Edit", value: Icon(FontAwesomeIcons.penToSquare));
