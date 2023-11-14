import 'package:flutter/material.dart';
import 'package:survey_app/enums/enums.dart';

class TileCardSelection extends StatelessWidget {
  const TileCardSelection(
      {super.key,
      required this.title,
      this.subtitle,
      required this.onPressed,
      this.status});

  final String title;
  final String? subtitle;
  final SurveyStatus? status;
  final void Function() onPressed;

  Color generateColour(SurveyStatus? status) {
    switch (status) {
      case SurveyStatus.notStarted:
        return Colors.blueGrey;
      case SurveyStatus.inProgress:
        return Colors.blue;
      case SurveyStatus.complete:
        return Colors.grey;
      default:
        //Default button colour
        return Colors.indigo;
    }
  }

  String getStatusSubtitle(SurveyStatus? status) {
    switch (status) {
      case SurveyStatus.notStarted:
        return "Not Started";
      case SurveyStatus.inProgress:
        return "In Progress";
      case SurveyStatus.complete:
        return "Complete";
      default:
        //Case
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: generateColour(status),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(subtitle ?? getStatusSubtitle(status)),
        onTap: () {
          onPressed();
        },
      ),
    );
  }
}
