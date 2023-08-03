import '../../../database/database.dart';
import '../../../global.dart';

class WdErrorCheck with Global {
  //Header error checks
  static String? allHeaderData(WoodyDebrisHeaderData wdh) {
    String result = "";

    if (transAzim(Global.nullableToStr(wdh.transAzimuth)) != null) {
      result += "Transect Azimuth \n";
    }
    if (swdMeasLen(Global.nullableToStr(wdh.swdMeasLen)) != null) {
      result += "Small Measurement Length \n";
    }
    if (mwdMeasLen(Global.nullableToStr(wdh.mcwdMeasLen)) != null) {
      result += "Medium Measurement Length \n";
    }
    if (lgMeasLen(Global.nullableToStr(wdh.lcwdMeasLen)) != null) {
      result += "Large Measurement Length \n";
    }

    if (wdh.swdDecayClass != -1) {
      if (smDecayClass(Global.nullableToStr(wdh.swdDecayClass)) != null) {
        result += "Average Decay Class of Transect";
      }
    }

    return result.isEmpty ? null : result;
  }

  //Nominal length of the sample transect (m). 10.0 to 150.0
  static String? nomTransLen(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (10.0 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 10.0 to 150.0 inclusive.";
    }
    return null;
  }

  //Transect azimuth (degrees) 0 to 360
  static String? transAzim(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (0 > int.parse(text) || int.parse(text) > 360) {
      return "Input out of range. Must be between 0 to 360 inclusive.";
    }
    return null;
  }

  //Total distance along the transect assessed for small woody debris. Recorded to nearest 0.1m. 0 to 150
  static String? swdMeasLen(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (0.0 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 0.0 to 150.0 inclusive.";
    }
    return null;
  }

  //Total distance along the transect assessed for round and odd shaped pieces of medium coarse woody debris
  static String? mwdMeasLen(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (0.0 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 0.0 to 150.0 inclusive.";
    }
    return null;
  }

  //Total distance along the transect assessed for round and odd shaped pieces of large coarse woody debris
  static String? lgMeasLen(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (0.0 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 0.0 to 150.0 inclusive.";
    }
    return null;
  }

  //Average decay class assigned to all pieces of small woody debris along each transect. 0 to 5. -1 if missing
  static String? smDecayClass(String text) {
    if (text.isEmpty) {
      return "Can't be empty";
    } else if (0.0 > double.parse(text) || double.parse(text) > 150.0) {
      return "Input out of range. Must be between 0.0 to 150.0 inclusive.";
    }
    return null;
  }

  static String? smallWdData(WoodyDebrisSmallData? smData) {
    String? result;
    if (smData == null) {
      result = "Small Woody Debris has not been initialised yet";
    } else if (smData.swdDecayClass != -1) {
      result = smDecayClass(Global.nullableToStr(smData.swdDecayClass)) != null
          ? "Small Woody Debris Decay Class"
          : null;
    }
    return result;
  }
}
