import 'dart:developer';

import '../widgets/date_select.dart';

List<String> dbJurisdictions = [
  "PEI - Prince Edward Island",
  "BC - British Columbia",
  "ON - Ontario"
];

Map dbJurisdictionPlots = <String, List<String>>{
  "PEI - Prince Edward Island": ["Plot 1", "Plot 2"],
  "BC - British Columbia": ["Plot 3", "Plot 4"],
  "ON - Ontario": ["Plot 5"]
};

List<String> dbMeasNums = [
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10"
];

List<String> dbTreeGenus = ["Unknown", "Abies", "Acer"];
Map dbTreeSpecies = <String, List<String>>{
  "Unknown": ["Unknown"],
  "Abies": ["Unknown", "Amabilis", "Balsamea"],
  "Acer": ["Unknown", "Nigrum"]
};

List<String> dbDecayClass = [
  "unmeasured/combines all decay classes",
  "1",
  "2",
  "3",
  "4",
  "5"
];

List<String> dbPieceType = ["Large", "Odd", "Accumulation"];

Database1 database = Database1();
bool surveyExists = false;
DateTime selectedDate = DateTime.now();

class Database1 {
  HeaderData headerData = HeaderData(dbJurisdictions[0],
      dbJurisdictionPlots[dbJurisdictions[0]][0], dbMeasNums[0]);
  WoodyDebris woodyDebris = WoodyDebris();

  Database1();

  void logValues() {
    log("Logging Values");
    headerData.logValues();
  }
}

class HeaderData {
  String jurisdiction = "Unknown";
  String plotNum = "Unknown";
  String measNum = "Unknown";

  HeaderData(this.jurisdiction, this.plotNum, this.measNum);

  void logValues() {
    log("Header Data Values");
    log("Jurisdiction: $jurisdiction");
    log("Plot number: $plotNum");
    log("Measurement Number: $measNum");
  }
}

class WoodyDebris {
  Map transects = <String, WoodyDebrisData>{};

  //Look for a transect number that is currently not in use
  String findAvailTransect() {
    for (int i = 1; i <= 9; i++) {
      if (transects.containsKey(i.toString())) {
        log("Transect $i in use");
      } else {
        log("Transect $i not in use");
        return i.toString();
      }
    }

    log("Error. No usable transect number found");
    return "Error";
  }
}

class WoodyDebrisData {
  WoodyMetaData woodyMetaData = WoodyMetaData();
  WoodyPieceMeasurements pieceMeasurements = WoodyPieceMeasurements();
}

class WoodyMetaData {
  WoodyMetaData({this.transNum = ""});

  List<String> crew = [];
  DateTime measDate = DateTime.now();
  //1 to 9
  String transNum;
  //Nominal length of the sample transect (m). 10.0 to 150.0
  String nomTransLen = "";
  //Transect azimuth (degrees) 0 to 360
  String transAzim = "";
  //Total distance along the transect assessed for small woody debris. Recorded to nearest 0.1m. 0 to 150
  String swdMeasLen = "";
  //Total distance along the transect assessed for round and odd shaped pieces of medium coarse woody debris
  String mwdMeasLen = "";
  //Total distance along the transect assessed for round and odd shaped pieces of large coarse woody debris
  String lgMeasLen = "";
  //Average decay class assigned to all pieces of small woody debris along each transect. 0 to 5. -1 if missing
  String smDecayClass = "";

  void logValues() {
    log("Woody Meta Data");
    log("Meas Date: ${formatDate(measDate)}");
    log("transNum: $transNum");
    log("nomTransLen: $nomTransLen");
    log("transAzim: $transAzim");
    log("swdMeasLen: $swdMeasLen");
    log("mwdMeasLen: $mwdMeasLen");
    log("lgMeasLen: $lgMeasLen");
    log("smDecayClass: $smDecayClass");
  }

  void populateMetaData(
      String transect, DateTime measDate, List<String> crewMembers) {
    database.woodyDebris.transects[transect].crew = crewMembers;
    database.woodyDebris.transects[transect]._measDate = measDate;
  }
}

class WoodyPieceMeasurements {
  String avgDecayClass = dbDecayClass[0];
  int class1 = 0;
  int class2 = 0;
  int class3 = 0;
  List<Piece> pieces = [];

  bool indexExists(int idx) {
    return idx < pieces.length;
  }
}

class Piece {
  String type = "Large";
  String genus = "Unknown";
  String species = "Unknown";
  String decayClass = "unmeasured/combines all decay classes";
  String comments = "";
  //Large Specific
  String diameter = "";
  String tiltAngle = "";
  //Odd and Accumulation Specific
  String horLength = "";
  String vertDepth = "";

  void logValues() {
    log("Piece Data Values");
    log("type: $type");
    log("genus: $genus");
    log("species: $species");
    log("decayClass: $decayClass");
    log("diameter: $diameter");
    log("tiltAngle: $tiltAngle");
    log("horLength: $horLength");
    log("vertDepth: $vertDepth");
    log("comments: $comments");
  }

  //Clean object so only pertinent data's left;
  void cleanData() {
    if (type == "Large") {
      horLength = "";
      vertDepth = "";
    } else {
      diameter = "";
      tiltAngle = "";
    }
  }
}
