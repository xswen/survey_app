import '../../database/database.dart';
import '../../global.dart';

class ErrorWoodyDebrisPiece with Global {
  String? checkErrorRound(WoodyDebrisRoundCompanion piece) {
    String result = "";

    if (diameter(Global.dbCompanionValueToStr(piece.diameter)) != null) {
      result += "Diameter \n";
    }
    if (tiltAngle(Global.dbCompanionValueToStr(piece.tiltAngle)) != null) {
      result += "Tilt Angle \n";
    }

    result += _treeAndDecayClass(
        Global.dbCompanionValueToStr(piece.genus),
        Global.dbCompanionValueToStr(piece.species),
        Global.dbCompanionValueToStr(piece.decayClass));

    return result.isEmpty ? null : result;
  }

  //Piece diameter as determined by calipers or diameter tape measurement. Reported to the nearest 0.1cm
  String? diameter(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (7.6 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 7.6 to 150.0 inclusive.";
    }
    return null;
  }

  //Reported in degrees. enter -1 for missing data
  String? tiltAngle(String text) {
    print(text);
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (int.parse(text) == -1) {
      return null;
    } else if (0.0 > int.parse(text) || int.parse(text) > 90) {
      return "Input out of range. Must be between -1 to 90 inclusive.";
    }

    return null;
  }

  String? checkErrorOddAcum(WoodyDebrisOddCompanion piece) {
    String result = "";

    if (horizontal(Global.dbCompanionValueToStr(piece.horLength)) != null) {
      result += "Horizontal Piece Length \n";
    }
    if (vertical(Global.dbCompanionValueToStr(piece.verDepth)) != null) {
      result += "Vertical Depth \n";
    }

    result += _treeAndDecayClass(
        Global.dbCompanionValueToStr(piece.genus),
        Global.dbCompanionValueToStr(piece.species),
        Global.dbCompanionValueToStr(piece.decayClass));

    return result.isEmpty ? null : result;
  }

  String? horizontal(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (0.0 > double.parse(text) || double.parse(text) > 9999.9) {
      return "Input out of range. Must be between 0.1 to 9999.9 inclusive.";
    }
    return null;
  }

  //Reported in degrees. enter -1 for missing data
  String? vertical(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (0.0 > double.parse(text) || double.parse(text) > 9999.9) {
      return "Input out of range. Must be between 0.1 to 9999.9 inclusive.";
    }
    return null;
  }

  String _treeAndDecayClass(String genus, String species, String decayClass) {
    String result = "";
    if (genus.isEmpty) {
      result += "Genus \n";
    }
    if (species.isEmpty) {
      result += "Species \n";
    }
    if (decayClass.isEmpty) {
      result += "Decay Class \n";
    }

    return result;
  }
}
