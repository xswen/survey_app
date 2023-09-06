import '../../../database/database.dart';

class WoodyDebrisPieceErrorChecks {
  static List<String>? checkErrorRound(
      Database db, WoodyDebrisRoundCompanion piece) {
    List<String> result = [];

    if (diameter(db.companionValueToStr(piece.diameter)) != null) {
      result.add("Diameter");
    }
    if (tiltAngle(db.companionValueToStr(piece.tiltAngle)) != null) {
      result.add("Tilt Angle");
    }

    result = [
      ...result,
      ..._treeAndDecayClass(
          db.companionValueToStr(piece.genus),
          db.companionValueToStr(piece.species),
          db.companionValueToStr(piece.decayClass))
    ];
    return result.isEmpty ? null : result;
  }

  //Piece diameter as determined by calipers or diameter tape measurement. Reported to the nearest 0.1cm
  static String? diameter(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (7.6 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 7.6 to 150.0 inclusive.";
    }
    return null;
  }

  //Reported in degrees. enter -1 for missing data
  static String? tiltAngle(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (int.parse(text) == -1) {
      return null;
    } else if (0.0 > int.parse(text) || int.parse(text) > 90) {
      return "Input out of range. Must be between 0 to 90 inclusive.";
    }

    return null;
  }

  static String? checkErrorOddAcum(Database db, WoodyDebrisOddCompanion piece) {
    String result = "";

    if (horizontal(db.companionValueToStr(piece.horLength)) != null) {
      result += "Horizontal Piece Length \n";
    }
    if (vertical(db.companionValueToStr(piece.verDepth)) != null) {
      result += "Vertical Depth \n";
    }

    // result += _treeAndDecayClass(
    //     db.companionValueToStr(piece.genus),
    //     db.companionValueToStr(piece.species),
    //     db.companionValueToStr(piece.decayClass));

    return result.isEmpty ? null : result;
  }

  static String? horizontal(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (0.0 > double.parse(text) || double.parse(text) > 9999.9) {
      return "Input out of range. Must be between 0.1 to 9999.9 inclusive.";
    }
    return null;
  }

  //Reported in degrees. enter -1 for missing data
  static String? vertical(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (int.parse(text) == -1) {
      return null;
    } else if (0.0 > double.parse(text) || double.parse(text) > 9999.9) {
      return "Input out of range. Must be between 0.1 to 9999.9 inclusive.";
    }
    return null;
  }

  static List<String> _treeAndDecayClass(
      String genus, String species, String decayClass) {
    List<String> result = [];
    if (genus.isEmpty) {
      result.add("Genus");
    }
    if (species.isEmpty) {
      result.add("Species");
    }
    if (decayClass.isEmpty) {
      result.add("Decay Class");
    }

    return result;
  }
}
