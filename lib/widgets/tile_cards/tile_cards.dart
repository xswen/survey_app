import 'package:flutter/material.dart';

import '../../enums/enums.dart';

class TileCards {
  static Color getStatusColour(SurveyStatus? status) {
    switch (status) {
      case SurveyStatus.notStarted:
        return Colors.blueGrey;
      case SurveyStatus.inProgress:
        return Colors.blue;
      case SurveyStatus.complete:
        return Colors.teal;
      case SurveyStatus.notAssessed:
        return Colors.grey;
      default:
        //Default button colour
        return Colors.indigo;
    }
  }

  static String getStatusSubtitle(SurveyStatus? status) {
    switch (status) {
      case SurveyStatus.notStarted:
        return "Not Started";
      case SurveyStatus.inProgress:
        return "In Progress";
      case SurveyStatus.complete:
        return "Complete";
      case SurveyStatus.notAssessed:
        return "Not Assessed";
      default:
        //Case
        return "Error trying to get status";
    }
  }
}
